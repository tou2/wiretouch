#include "wtmApp.h"

//--------------------------------------------------------------
void wtmApp::setup()
{
    this->sensorColumns = 32;
    this->sensorRows = 22;
	
    this->bytesPerFrame = (sensorColumns*sensorRows*10)/8;
    this->recvBuffer = (unsigned char*)malloc(this->bytesPerFrame * sizeof(unsigned char));
    
    ofSetVerticalSync(true);
	ofBackground(255);
	ofSetLogLevel(OF_LOG_VERBOSE);
    
    // setup GUI
    int guiWidth = 300;
    int widgetLength = guiWidth - (2* OFX_UI_GLOBAL_WIDGET_SPACING);
    int widgetHeight = 16;
    gui = new ofxUICanvas(WINDOWWIDTH-(guiWidth+WINDOWBORDERDISTANCE),WINDOWBORDERDISTANCE,guiWidth,600);
    gui->addWidgetDown(new ofxUILabel("SENSOR PARAMETERS", OFX_UI_FONT_SMALL));
    gui->addSlider("HALFWAVE AMP", 0.0, 100.0, 50, widgetLength, widgetHeight);
    gui->addSlider("OUTPUT AMP", 0.0, 100.0, 50, widgetLength, widgetHeight);
    gui->addSlider("SAMPLE DELAY", 0.0, 100.0, 50, widgetLength, widgetHeight);
    gui->addSlider("SIGNAL FREQUENCY", 0.0, 100.0, 50, widgetLength, widgetHeight);
    gui->addLabelToggle("BLOBS", false,(widgetLength/2)-(OFX_UI_GLOBAL_WIDGET_SPACING/2),widgetHeight);
    gui->setWidgetPosition(OFX_UI_WIDGET_POSITION_RIGHT);
    gui->addLabelToggle("GRID", false,(widgetLength/2)-(OFX_UI_GLOBAL_WIDGET_SPACING/2),widgetHeight);
	gui->setWidgetPosition(OFX_UI_WIDGET_POSITION_DOWN);
    gui->addWidgetDown(new ofxUIFPS(OFX_UI_FONT_SMALL));
    
    ofAddListener(gui->newGUIEvent, this, &wtmApp::guiEvent);
    gui->setWidgetColor(OFX_UI_WIDGET_COLOR_BACK, ofColor(200,200,200));
    gui->setWidgetColor(OFX_UI_WIDGET_COLOR_FILL, ofColor(60,60,60,200)); // also: font color
    gui->setWidgetColor(OFX_UI_WIDGET_COLOR_FILL_HIGHLIGHT, ofColor(180,220));
    gui->setColorBack(ofColor(255, 255, 255));
    gui->loadSettings("GUI/guiSettings.xml");
    
	// this should be set to whatever com port your serial device is connected to.
	// (ie, COM4 on a pc, /dev/tty.... on linux, /dev/tty... on a mac)
	// arduino users check in arduino app....
	int baud = 300;
	serial.setup(0, baud);
    sleep(5);
}

//--------------------------------------------------------------
void wtmApp::update()
{    
    if (!didSend) {
        didSend = 1;
        
        //for (int i=0; i<100; i++) {
            serial.writeByte('s');
            serial.writeByte('\n');
        //}
    } else {        
        if (serial.available() >= this->bytesPerFrame) {
            int len = serial.readBytes(this->recvBuffer, this->bytesPerFrame);
            
            if (len == this->bytesPerFrame) {
                if (0 != this->lastRecvFrameTime) {
                    float now = ofGetElapsedTimef();
                    
                    ofLog() << (1.0/(now - this->lastRecvFrameTime)) << " pkts/sec, dt: " << (now - this->lastRecvFrameTime);
                    
                    this->lastRecvFrameTime = now;
                } else
                    this->lastRecvFrameTime = ofGetElapsedTimef();
                
                this->makeTexture();
            }
        }
    }
}

//--------------------------------------------------------------
void wtmApp::draw(){
    if (this->texture.isAllocated())
        this->texture.draw(10, 10, 640, 440);
}

void wtmApp::makeTexture()
{
    unsigned char* pixels = (unsigned char*)alloca(this->sensorColumns * this->sensorRows * sizeof(unsigned char));
    
    unsigned char* b = this->recvBuffer;
    int bs = 0, br = 0, cnt = 0;
    
    for (int i=0; i<this->bytesPerFrame; i++) {
        br |= b[i] << bs;
        bs += 8;
        while (bs >= 10) {
            int sig = br & 0x3ff;
            br >>= 10;
            bs -= 10;
            
            int px = cnt / this->sensorRows, py = cnt % this->sensorRows;
            
            pixels[py * this->sensorColumns + px] = (unsigned char)((float)sig/(float)1023.0 * 255);
            
            cnt++;
        }
    }
    
    if (!this->texture.isAllocated())
        this->texture.allocate(this->sensorColumns, this->sensorRows, GL_LUMINANCE);
    
    this->texture.loadData(pixels, this->sensorColumns, this->sensorRows, GL_LUMINANCE);    
}

//------------------------------------------------------------s--
void wtmApp::keyPressed(int key)
{
}

//--------------------------------------------------------------
void wtmApp::keyReleased(int key){

}

//--------------------------------------------------------------
void wtmApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void wtmApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void wtmApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void wtmApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void wtmApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void wtmApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void wtmApp::dragEvent(ofDragInfo dragInfo){ 

}

void wtmApp::exit()
{
    serial.close();
    gui->saveSettings("GUI/guiSettings.xml");
    delete gui;
}

void wtmApp::guiEvent(ofxUIEventArgs &e)
{
    string widgetName = e.widget->getName();
	if (widgetName == "HALFWAVE AMP") {
        ofxUISlider *slider = (ofxUISlider *) e.widget;
        // slider->getScaledValue()
    }
    else if (widgetName == "OUTPUT AMP") {
        ofxUISlider *slider = (ofxUISlider *) e.widget;        
    }
    else if (widgetName == "SAMPLE DELAY") {
        ofxUISlider *slider = (ofxUISlider *) e.widget;
    }
    else if (widgetName == "SIGNAL FREQUENCY") {
        ofxUISlider *slider = (ofxUISlider *) e.widget;
    }
    else if (widgetName == "BLOBS") {
        ofxUIButton *button = (ofxUIButton *) e.widget;
        bDrawBlobs = button->getValue();
    }
    else if (widgetName == "GRID") {
        ofxUIButton *button = (ofxUIButton *) e.widget;
        bDrawGrid = button->getValue();
    }
}