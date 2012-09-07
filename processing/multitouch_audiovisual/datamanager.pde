public class Pt {
  int x;
  int y;
}

class DataManager {
  Serial port;
  String fakeData;
  byte[] serBuffer = null;

  DataManager() {
    this.serBuffer = new byte[(horizontalWires * verticalWires * 10)/8];
  }

  void calibrate(Serial port) {
    this.port = port;
    try {
      this.port.clear(); // // do we need this? (cargo cult programming)
      //this.port.buffer(serBuffer.length);
      delay(2000); // still needed?
      this.port.write('s');
      textInformation = "starting to calibrate";
    } 
    catch (Exception e) {
      textInformation = "error with Serial connection: "+e;
      println(Serial.list());
    }
  }

  void initFakeData() {
    // show the hand
    fakeData = "1.0218749046325684,0.8097867369651794,0.9315683841705322,0.901065468788147,0.9506103992462158,0.9477819800376892,0.9595820307731628,0.9320240616798401,0.9986903667449951,0.9437098503112793,0.8427046537399292,1.2948648929595947,0.9542681574821472,1.2312002182006836,1.0486751794815063,0.9851735830307007,0.9082821011543274,0.8903130292892456,0.872377872467041,0.9956980347633362,0.7956831455230713,0.8482016921043396,1.0942963361740112,0.7883279919624329,0.9144436120986938,0.9180737733840942,0.8987343311309814,0.9091134071350098,1.054099440574646,0.9292076826095581,0.9588000178337097,0.9545393586158752,0.980679988861084,0.8682169914245605,1.1563708782196045,0.9300829768180847,0.8822140097618103,0.9951786398887634,0.9948641061782837,0.9766265749931335,0.8868603110313416,0.9242367744445801,1.1366204023361206,1.1963589191436768,0.9763747453689575,0.8165039420127869,0.9937048554420471,1.0291110277175903,0.9986996054649353,0.9947393536567688,0.9888765811920166,0.9951502084732056,0.9984205365180969,0.9332219958305359,0.9028418660163879,1.0958682298660278,0.899419903755188,1.0049349069595337,1.0206947326660156,0.9614531397819519,0.9865061044692993,0.8967220783233643,0.8849254250526428,0.9514106512069702,1.0158729553222656,0.9374399185180664,1.0790433883666992,0.9179796576499939,0.9470042586326599,0.9626652598381042,1.0440101623535156,0.831190288066864,1.0033477544784546,1.0909091234207153,0.9313808083534241,0.9100170731544495,0.8235602974891663,1.0036978721618652,1.0182536840438843,0.8800855875015259,0.9043018817901611,0.9265670776367188,0.8663119673728943,0.9336737990379333,0.9137683510780334,1.0455929040908813,1.001662254333496,0.9998577237129211,1.191956877708435,0.8716572523117065,1.30856454372406,0.9208466410636902,0.9985221028327942,0.9986996054649353,0.9974379539489746,0.9194098114967346,1.057883620262146,1.1680691242218018,1.196315884590149,0.8878697752952576,0.9235377907752991,0.9544159173965454,1.0135160684585571,1.1199193000793457,0.8753308653831482,0.7871297001838684,1.0678187608718872,0.945702850818634,1.0707080364227295,1.013000249862671,0.9929268956184387,1.1352792978286743,0.8695641756057739,0.9037089943885803,0.8339211940765381,0.8354101181030273,0.996442973613739,0.8518788814544678,0.9871436953544617,0.950283408164978,0.9333763122558594,1.0670626163482666,1.1572117805480957,0.9243114590644836,0.9633012413978577,0.9058394432067871,0.9252742528915405,0.8709272146224976,0.9895656108856201,0.8630527853965759,0.9077918529510498,0.9896557927131653,1.0951522588729858,0.9322757124900818,0.9014242887496948,0.9226778149604797,0.9222427606582642,0.9159632921218872,0.9986996054649353,1.0421067476272583,1.0363293886184692,1.0115171670913696,0.9120829701423645,1.04875910282135,1.0655746459960938,0.9132017493247986,1.0044509172439575,0.8626746535301208,0.9267844557762146,0.9156811237335205,0.9471172094345093,0.8761332035064697,0.9135189056396484,0.9794466495513916,0.889128565788269,1.062813639640808,1.0789237022399902,0.987191915512085,0.9440154433250427,0.9870336055755615,0.9771872758865356,0.9553754329681396,1.0080394744873047,0.9222167134284973,0.9035007953643799,0.9377534985542297,0.9668472409248352,0.9333638548851013,0.9583479166030884,1.0466214418411255,1.0724992752075195,1.0400699377059937,0.9840796589851379,0.9212818741798401,0.9045029282569885,0.9377555847167969,0.9880419373512268,0.8615790605545044,0.8244990110397339,0.8894155621528625,0.9947184324264526,0.9896706342697144,1.119882583618164,1.1856211423873901,0.9986900091171265,0.9635252952575684,0.9050203561782837,0.9700112342834473,0.8702903985977173,0.9337370991706848,0.9625540375709534,0.9616519212722778,0.9465047121047974,1.015930414199829,0.9747006297111511,1.0096964836120605,0.909308910369873,0.8201444745063782,0.6964192390441895,0.8981242179870605,0.845268726348877,0.9397029876708984,0.9129623174667358,0.969512939453125,0.9522730708122253,1.0189584493637085,0.9986993074417114,1.051296591758728,0.94110107421875,0.9777590036392212,0.8465608358383179,1.0586141347885132,1.039216160774231,0.9432597756385803,1.0103434324264526,0.9115940928459167,0.9360944628715515,1.0680922269821167,0.9295603036880493,0.9214234352111816,1.0494130849838257,1.0953065156936646,0.679645836353302,0.8493664264678955,0.9601656794548035,0.99000084400177,0.9279500246047974,0.9137967824935913,1.1219260692596436,0.9728764295578003,0.9240990877151489,1.0193774700164795,0.8441764116287231,0.8601912260055542,1.0304092168807983,0.8777611255645752,0.8694134950637817,0.9550206065177917,0.8467097282409668,0.8635478019714355,0.8837871551513672,0.9411666989326477,1.0402625799179077,0.5785648226737976,0.8488141894340515,0.9758399128913879,0.9360102415084839,0.9175058603286743,0.9450189471244812,1.0122032165527344,0.9574586153030396,0.9216160178184509,1.063990592956543,0.8444515466690063,1.0744856595993042,0.8833763599395752,0.8758150339126587,0.8992035388946533,0.9532148241996765,0.9216283559799194,0.8295589685440063,1.0027047395706177,1.1145391464233398,1.0377767086029053,1.136915922164917,0.8790743947029114,0.829839825630188,0.9767207503318787,0.981054425239563,0.9116092324256897,1.037306785583496,0.9341861605644226,0.9569971561431885,0.9146562218666077,0.9438908696174622,1.0621700286865234,1.0573773384094238,0.8480618000030518,1.1355074644088745,0.9038229584693909,0.8474075198173523,0.9603264331817627,0.8633007407188416,0.8514955639839172,0.858916163444519,0.8963761329650879,1.426294207572937,0.71656334400177,0.9051224589347839,1.1285516023635864,1.0083894729614258,0.9088872075080872,0.8938524723052979,0.9382773637771606,1.042719841003418,1.0257282257080078,0.7716066241264343,0.999638020992279,0.9448110461235046,0.9546207189559937,0.9683201313018799,0.834516704082489,0.7607862949371338,1.1250838041305542,0.8299773931503296,0.8693198561668396,0.8552598357200623,0.9877023696899414,0.9153861999511719,1.170309066772461,0.8852914571762085,0.8732826113700867,0.907459557056427,1.0021713972091675,0.8870100975036621,1.0312011241912842,0.8032797574996948,0.9090656042098999,0.9909417629241943,0.992422342300415,1.1642590761184692,1.0640074014663696,0.8458657264709473,0.840325653553009,0.7472092509269714,0.8835515975952148,0.973287045955658,1.2478971481323242,0.740062952041626,0.9429006576538086,1.5165684223175049,1.0808968544006348,1.4981812238693237,0.7114797234535217,0.8639461994171143,0.89248126745224,0.8703944683074951,1.194877028465271,0.8137887120246887,0.9006404876708984,0.7759655117988586,0.4922439157962799,1.029305100440979,0.44129714369773865,0.674907386302948,0.6097927689552307,0.9593632817268372,1.1325621604919434,0.867138147354126,0.5819523334503174,0.9975225329399109,0.852616548538208,1.0855416059494019,1.0785454511642456,0.5573288798332214,0.931940495967865,0.9944324493408203,0.8400563597679138,1.2067657709121704,0.9048774838447571,0.8425163626670837,0.7347290515899658,1.1077989339828491,0.8525274991989136,0.8802114725112915,0.7561520338058472,1.0783510208129883,0.9593546390533447,0.91124427318573,0.7413263320922852,0.689214825630188,0.8047534227371216,0.6118444800376892,0.8203068375587463,0.9269090294837952,0.6237990260124207,0.748565137386322,0.8608477115631104,1.0867366790771484,0.8945276737213135,0.9444118142127991,0.996511697769165,0.9247737526893616,1.0004353523254395,0.8982042074203491,0.9622284173965454,1.3891263008117676,0.7851325869560242,0.9066258072853088,1.0699875354766846,0.8891806602478027,1.1963392496109009,1.2243671417236328,0.8972131609916687,0.828125,0.8105190992355347,1.221083641052246,1.2989083528518677,0.5937381982803345,0.8021085262298584,0.9394251704216003,0.9895415902137756,0.9515541195869446,1.0118788480758667,0.957103967666626,0.8418769240379333,0.9179186224937439,0.9922404289245605,0.9809118509292603,0.6523591876029968,0.8198316097259521,1.0089788436889648,0.9954584240913391,0.9186354279518127,1.1067211627960205,0.8328320980072021,0.876803457736969,0.9611615538597107,1.015557885169983,1.3403828144073486,0.7914175987243652,0.9938886761665344,0.9621497392654419,0.9985171556472778,0.9646545052528381,0.9923750758171082,1.1441400051116943,0.9688223600387573,0.9915689826011658,0.9230441451072693,0.8879697322845459,0.9723301529884338,1.031131386756897,0.8670653104782104,1.0880675315856934,0.9396467804908752,1.0046584606170654,0.9867948293685913,0.9089359045028687,0.96244877576828,0.9955100417137146,0.6748415231704712,0.842880368232727,1.0438170433044434,0.9403427839279175,0.9382146000862122,0.8882898092269897,1.0145628452301025,0.9099804759025574,0.9971122741699219,1.0576915740966797,0.865475058555603,0.9877340197563171,0.8594570755958557,0.8542680740356445,0.9063101410865784,0.86564701795578,0.9454466700553894,0.7819404602050781,0.8361550569534302,0.9069550633430481,0.9762467741966248,0.9824154376983643,1.072201132774353,0.8769686818122864,0.9728307127952576,0.930121123790741,1.030849814414978,1.0810136795043945,0.919270396232605,0.9983730912208557,0.8264148235321045,1.0166655778884888,0.9188913106918335,0.9120994210243225,1.0571930408477783,1.1366548538208008,0.8874136209487915,0.9923096895217896,0.9842970967292786,1.0351437330245972,0.9984622597694397,1.1875624656677246,0.8200365304946899,1.0981158018112183,0.9365070462226868,0.9210879802703857,0.8601250052452087,0.9489537477493286,1.0593379735946655,1.078735113143921,0.8742034435272217,0.8550096750259399,0.919137716293335,0.9203362464904785,0.9740423560142517,0.9296080470085144,0.8601745963096619,0.9895818829536438,0.9457219839096069,1.0101709365844727,0.8603744506835938,1.0627521276474,0.9849024415016174,1.3617584705352783,1.0615774393081665,0.8050376176834106,0.9865593910217285,1.092389464378357,0.8769327402114868,0.9164562821388245,1.0769591331481934,0.9694834351539612,0.9346824288368225,0.914426326751709,1.004895806312561,0.9341055154800415,0.934086263179779,1.0689491033554077,1.002887487411499,0.8550152778625488,0.8300912976264954,0.9737113118171692,0.9489744901657104,0.8866774439811707,1.0162353515625,0.8174160122871399,0.997545599937439,1.0563796758651733,0.743503987789154,0.8078570365905762,0.9772047400474548,0.8729252815246582,0.9891234040260315,1.0775129795074463,0.9333151578903198,0.9956244826316833,1.0004775524139404,0.9487552046775818,0.9132876992225647,0.9176082611083984,1.111190915107727,0.89210444688797,0.9211258888244629,0.9418560862541199,0.932169497013092,0.8710156679153442,0.9528961777687073,0.8114466667175293,1.0220575332641602,0.8861122727394104,0.7568895220756531,0.8315691351890564,0.9816550016403198,0.9853634834289551,0.9066383242607117,0.8374090790748596,0.999920129776001,0.99992436170578,0.8966733813285828,0.9233318567276001,0.900062084197998,1.0176798105239868,0.9959455132484436,0.818597674369812,0.946330189704895,1.1287227869033813,0.8498201966285706,0.902575671672821,0.8650818467140198,0.9064592719078064,0.9206672310829163,0.9452092051506042,0.9947142004966736,0.9125998020172119,0.9862735271453857,0.9987018704414368,0.8526217341423035,0.9984152913093567,0.9999657273292542,0.9970396161079407,1.0058422088623047,0.8408157229423523,0.858108401298523,0.8978939056396484,0.8428276777267456,0.96102374792099,0.992101788520813,0.9694570899009705,1.0154883861541748,0.9108530282974243,0.9181557893753052,0.9119806885719299,0.9986996054649353,0.8563863635063171,0.8388427495956421,0.9521350860595703,0.9640601277351379,0.8861306309700012,0.9962633848190308,1.0517429113388062,0.8329547643661499,0.9893496632575989,1.0614428520202637,1.1074849367141724,0.9145618081092834,0.9993381500244141,0.8617940545082092,1.1220735311508179,0.9357030987739563,0.8663203716278076,1.078588843345642,0.9529848098754883,0.8458786010742188,0.9456972479820251,0.8726157546043396,1.0503301620483398,0.8348976373672485,0.8594099283218384,0.9968066811561584,0.856632649898529,0.9332572817802429,0.9986799955368042,0.9388349652290344,0.997564435005188,0.9160210490226746,0.8581444621086121,1.036110758781433,0.930361807346344,0.9296192526817322,0.9546074271202087,0.880805492401123,0.873149573802948,1.0017447471618652,0.958497166633606,0.888862133026123,1.159881830215454,0.9201898574829102,0.971225917339325,1.0126415491104126,1.1282776594161987,1.0604008436203003,0.9099274277687073,1.0187451839447021,0.7865799069404602,0.9446457624435425,1.003395676612854,0.9246900677680969,0.8379852771759033,0.9010201692581177,0.8530160188674927,0.9676647782325745,0.9969539046287537,1.0448863506317139,0.8804194927215576,0.9470776319503784,0.8439293503761292,0.8830849528312683,0.9724252820014954,1.0536714792251587,0.8114863038063049,1.1128190755844116,0.9622047543525696,0.931907594203949,0.9238308072090149,0.922852635383606,0.9627854824066162,0.9757184386253357,0.8936834335327148,0.8761693835258484,1.099737524986267,1.0114375352859497,0.9961208701133728,0.8828701972961426,0.8285287618637085,0.8721967935562134,0.8988560438156128,0.9834022521972656,1.0442532300949097,0.7983203530311584,1.0982023477554321,0.8950684666633606,0.7887426614761353,0.669618546962738,0.5117608904838562,1.0728200674057007,0.999454915523529,1.1268757581710815,0.8953968286514282,0.9731590747833252,0.8131350874900818,0.596407949924469,0.9585359692573547,0.9112915396690369,0.3410030007362366,1.247626781463623,0.6677594184875488,0.36579859256744385,0.9738866686820984,0.8649330139160156,0.6005105376243591,0.7035661935806274,1.0557173490524292,0.6423991918563843,";
    this.parseFakeData();
  }

  int sb2ub(byte p) {
    return p < 0 ? 256+p : p;
  }

  Pt convertCoords(int x, int y) {
    Pt pt = new Pt();
  
    int a = x * horizontalWires + y;
    int b = (59*a + 13) % (verticalWires*horizontalWires);
  
    pt.x = b / horizontalWires;
    pt.y = b - pt.x * horizontalWires;
  
    return pt;
  }

  void consumeSerialBuffer(byte[] b) {
    byte[] buf = null != b ? b : serBuffer;
    
    int bs = 0, br = 0, cnt = 0;
    for (int i=0; i<buf.length; i++) {
      br |= sb2ub(buf[i]) << bs;
      bs += 8;
      while (bs >= 10) {          
        int sig = br & 0x3ff;
        br >>= 10;
        bs -= 10;          
        int px = cnt / horizontalWires, py = cnt % horizontalWires;
        Pt pt = convertCoords(px, py);
        if (averageSignalCounter > 0) {
          // calculate the average signal strength for every crosspoint
          crosspoints[pt.x][pt.y].accumulateAvgSig(sig);
        }
        else {
          crosspoints[pt.x][pt.y].setSignalStrength(sig);
        }
        cnt++;
      }
    }
    calibrationFeedback();
  }

  // TODO: this code needs some serious refactoring...
  void calibrationFeedback() {
    if (averageSignalCounter > 0) {
      averageSignalCounter--;
      if (averageSignalCounter != 0) {
        textInformation = "calibrating: "+averageSignalCounter;
      }
      else {
        showHelpText();
      }
    }
  }

  void parseFakeData() {
    fakeData = trim(fakeData);
    float data[] = float(split(fakeData, ','));
    int k = 0;
    for (int i = 0; i < verticalWires; i++) {
      for (int j = 0; j < horizontalWires; j++) {
        crosspoints[i][j].setSignalStrength((int) data[k]);
        k++;
      }
    }
  }

  void printData() {
    println("measured signals:");
    String myString = "";
    for (int i = 0; i < verticalWires; i++) {
      for (int j = 0; j < horizontalWires; j++) {
        myString = myString+(int) crosspoints[i][j].measuredSignal+",";
      }
    }
    println(myString);
    println("calculated signal strength:");
    myString = "";
    for (int i = 0; i < verticalWires; i++) {
      for (int j = 0; j < horizontalWires; j++) {
        myString = myString+crosspoints[i][j].signalStrength+",";
      }
    }
    println(myString);
  }
}

