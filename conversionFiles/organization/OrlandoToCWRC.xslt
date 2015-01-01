<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://icl.com/saxon"
                xmlns:dyn="http://saxon.sf.net/"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                version="2.0"
                exclude-result-prefixes="fn dyn saxon">
                    
                    
    <saxon:script implements-prefix="dyn" language="java">
        <![CDATA[
            //function evaluate-test(string){
                //return escape(string);
            //}
            
            String evaluateTest(String input){
                System.out.println("FDSFDSFDSFDSFGDSFSDFDSFDSF!!!!!!!!!!!!!!!!!!!!!!!!!");
                return input;
            }
        ]]>
    </saxon:script>
    
    <xsl:character-map name="character_entities">
        <xsl:output-character string="&amp;num;" character="#"/> 
        <xsl:output-character string="&amp;dollar;" character="$"/> 
        <xsl:output-character string="&amp;percnt;" character="&#37;"/> 
        <xsl:output-character string="&amp;plus;" character="+"/> 
        <xsl:output-character string="&amp;pound;" character="&#165;"/> 
        <xsl:output-character string="&amp;deg;" character="&#176;"/> 
        <xsl:output-character string="&amp;frac34;" character="&#190;"/> 
        <xsl:output-character string="&amp;Aacute;" character="&#193;"/> 
        <xsl:output-character string="&amp;Acirc;" character="&#194;"/> 
        <xsl:output-character string="&amp;Auml;" character="&#196;"/> 
        <xsl:output-character string="&amp;AElig;" character="&#198;"/> 
        <xsl:output-character string="&amp;Eacute;" character="&#201;"/> 
        <xsl:output-character string="&amp;Euml;" character="&#203;"/> 
        <xsl:output-character string="&amp;Icirc;" character="&#206;"/> 
        <xsl:output-character string="&amp;Iuml;" character="&#207;"/> 
        <xsl:output-character string="&amp;Oacute;" character="&#211;"/> 
        <xsl:output-character string="&amp;agrave;" character="&#224;"/> 
        <xsl:output-character string="&amp;aacute;" character="&#225;"/> 
        <xsl:output-character string="&amp;acirc;" character="&#226;"/> 
        <xsl:output-character string="&amp;atilde;" character="&#227;"/> 
        <xsl:output-character string="&amp;auml;" character="&#228;"/> 
        <xsl:output-character string="&amp;aelig;" character="&#230;"/> 
        <xsl:output-character string="&amp;ccedil;" character="&#231;"/> 
        <xsl:output-character string="&amp;egrave;" character="&#232;"/> 
        <xsl:output-character string="&amp;eacute;" character="&#233;"/> 
        <xsl:output-character string="&amp;ecirc;" character="&#234;"/> 
        <xsl:output-character string="&amp;euml;" character="&#235;"/> 
        <xsl:output-character string="&amp;iacute;" character="&#237;"/> 
        <xsl:output-character string="&amp;iuml;" character="&#239;"/> 
        <xsl:output-character string="&amp;ntilde;" character="&#241;"/> 
        <xsl:output-character string="&amp;oacute;" character="&#243;"/> 
        <xsl:output-character string="&amp;ocirc;" character="&#244;"/> 
        <xsl:output-character string="&amp;ouml;" character="&#246;"/> 
        <xsl:output-character string="&amp;oslash;" character="&#248;"/> 
        <xsl:output-character string="&amp;uuml;" character="&#252;"/> 
        <xsl:output-character string="&amp;yuml;" character="&#255;"/> 
        <xsl:output-character string="&amp;inodot;" character="&#x131;"/> 
        <xsl:output-character string="&amp;ncaron;" character="&#x148;"/> 
        <xsl:output-character string="&amp;OElig;" character="&#x152;"/> 
        <xsl:output-character string="&amp;oelig;" character="&#x153;"/> 
        <xsl:output-character string="&amp;sacute;" character="&#x15B;"/> 
        <xsl:output-character string="&amp;dash;" character="&#x2010;"/> 
        <xsl:output-character string="&amp;mdash;" character="&#x2014;"/> 
        <xsl:output-character string="&amp;prime;" character="&#x2032;"/> 
        <xsl:output-character string="&amp;trade;" character="&#8482;"/> 

        <xsl:output-character string="&amp;acute;" character="&#180;"/> 
        <xsl:output-character string="&amp;breve;" character="&#x2D8;"/> 
        <xsl:output-character string="&amp;caron;" character="&#x2C7;"/> 
        <xsl:output-character string="&amp;cedil;" character="&#184;"/> 
        <xsl:output-character string="&amp;circ;" character="^"/> 
        <xsl:output-character string="&amp;dblac;" character="&#x2DD;"/> 
        <xsl:output-character string="&amp;die;" character="&#168;"/> 
        <xsl:output-character string="&amp;dot;" character="&#x2D9;"/> 
        <xsl:output-character string="&amp;grave;" character="`"/> 
        <xsl:output-character string="&amp;macr;" character="&#175;"/> 
        <xsl:output-character string="&amp;ogon;" character="&#x2DB;"/> 
        <xsl:output-character string="&amp;ring;" character="&#x2DA;"/> 
        <xsl:output-character string="&amp;tilde;" character="&#x2DC;"/> 
        <xsl:output-character string="&amp;uml;" character="&#168;"/> 

        <xsl:output-character string="&amp;agr;" character="&#945;"/> 
        <xsl:output-character string="&amp;Agr;" character="&#913;"/> 
        <xsl:output-character string="&amp;bgr;" character="&#946;"/> 
        <xsl:output-character string="&amp;Bgr;" character="&#914;"/> 
        <xsl:output-character string="&amp;ggr;" character="&#947;"/> 
        <xsl:output-character string="&amp;Ggr;" character="&#915;"/> 
        <xsl:output-character string="&amp;dgr;" character="&#948;"/> 
        <xsl:output-character string="&amp;Dgr;" character="&#916;"/> 
        <xsl:output-character string="&amp;egr;" character="&#949;"/> 
        <xsl:output-character string="&amp;Egr;" character="&#917;"/> 
        <xsl:output-character string="&amp;zgr;" character="&#950;"/> 
        <xsl:output-character string="&amp;Zgr;" character="&#918;"/> 
        <xsl:output-character string="&amp;eegr;" character="&#951;"/> 
        <xsl:output-character string="&amp;EEgr;" character="&#919;"/> 
        <xsl:output-character string="&amp;thgr;" character="&#952;"/> 
        <xsl:output-character string="&amp;THgr;" character="&#920;"/> 
        <xsl:output-character string="&amp;igr;" character="&#953;"/> 
        <xsl:output-character string="&amp;Igr;" character="&#921;"/> 
        <xsl:output-character string="&amp;kgr;" character="&#954;"/> 
        <xsl:output-character string="&amp;Kgr;" character="&#922;"/> 
        <xsl:output-character string="&amp;lgr;" character="&#955;"/> 
        <xsl:output-character string="&amp;Lgr;" character="&#923;"/> 
        <xsl:output-character string="&amp;mgr;" character="&#956;"/> 
        <xsl:output-character string="&amp;Mgr;" character="&#924;"/> 
        <xsl:output-character string="&amp;ngr;" character="&#957;"/> 
        <xsl:output-character string="&amp;Ngr;" character="&#925;"/> 
        <xsl:output-character string="&amp;xgr;" character="&#958;"/> 
        <xsl:output-character string="&amp;Xgr;" character="&#926;"/> 
        <xsl:output-character string="&amp;ogr;" character="&#959;"/> 
        <xsl:output-character string="&amp;Ogr;" character="&#927;"/> 
        <xsl:output-character string="&amp;pgr;" character="&#960;"/> 
        <xsl:output-character string="&amp;Pgr;" character="&#928;"/> 
        <xsl:output-character string="&amp;rgr;" character="&#961;"/> 
        <xsl:output-character string="&amp;Rgr;" character="&#929;"/> 
        <xsl:output-character string="&amp;sfgr;" character="&#962;"/> 
        <xsl:output-character string="&amp;sgr;" character="&#963;"/> 
        <xsl:output-character string="&amp;Sgr;" character="&#931;"/> 
        <xsl:output-character string="&amp;tgr;" character="&#964;"/> 
        <xsl:output-character string="&amp;Tgr;" character="&#932;"/> 
        <xsl:output-character string="&amp;ugr;" character="&#965;"/> 
        <xsl:output-character string="&amp;Ugr;" character="&#933;"/> 
        <xsl:output-character string="&amp;phgr;" character="&#966;"/> 
        <xsl:output-character string="&amp;PHgr;" character="&#934;"/> 
        <xsl:output-character string="&amp;khgr;" character="&#967;"/> 
        <xsl:output-character string="&amp;KHgr;" character="&#935;"/> 
        <xsl:output-character string="&amp;psgr;" character="&#968;"/> 
        <xsl:output-character string="&amp;PSgr;" character="&#936;"/> 
        <xsl:output-character string="&amp;ohgr;" character="&#969;"/> 
        <xsl:output-character string="&amp;OHgr;" character="&#937;"/> 

        <xsl:output-character string="&amp;aacgr;" character="&#x3AC;"/> 
        <xsl:output-character string="&amp;Aacgr;" character="&#x386;"/> 
        <xsl:output-character string="&amp;eacgr;" character="&#x3AD;"/> 
        <xsl:output-character string="&amp;Eacgr;" character="&#x388;"/> 
        <xsl:output-character string="&amp;eeacgr;" character="&#x3AE;"/> 
        <xsl:output-character string="&amp;EEacgr;" character="&#x389;"/> 
        <xsl:output-character string="&amp;idigr;" character="&#x3CA;"/> 
        <xsl:output-character string="&amp;Idigr;" character="&#x3AA;"/> 
        <xsl:output-character string="&amp;iacgr;" character="&#x3AF;"/> 
        <xsl:output-character string="&amp;Iacgr;" character="&#x38A;"/> 
        <xsl:output-character string="&amp;idiagr;" character="&#x390;"/> 
        <xsl:output-character string="&amp;oacgr;" character="&#x3CC;"/> 
        <xsl:output-character string="&amp;Oacgr;" character="&#x38C;"/> 
        <xsl:output-character string="&amp;udigr;" character="&#x3CB;"/> 
        <xsl:output-character string="&amp;Udigr;" character="&#x3AB;"/> 
        <xsl:output-character string="&amp;uacgr;" character="&#x3CD;"/> 
        <xsl:output-character string="&amp;Uacgr;" character="&#x38E;"/> 
        <xsl:output-character string="&amp;udiagr;" character="&#x3B0;"/>
        <xsl:output-character string="&amp;ohacgr;" character="&#x3CE;"/> 
        <xsl:output-character string="&amp;OHacgr;" character="&#x38F;"/> 

        <xsl:output-character string="&amp;alpha;" character="&#x3B1;"/> 
        <xsl:output-character string="&amp;beta;" character="&#x3B2;"/> 
        <xsl:output-character string="&amp;gamma;" character="&#x3B3;"/> 
        <xsl:output-character string="&amp;Gamma;" character="&#x393;"/> 
        <xsl:output-character string="&amp;gammad;" character="&#x3DC;"/> 
        <xsl:output-character string="&amp;delta;" character="&#x3B4;"/> 
        <xsl:output-character string="&amp;Delta;" character="&#x394;"/> 
        <xsl:output-character string="&amp;epsi;" character="&#x3B5;"/> 
        <xsl:output-character string="&amp;epsiv;" character="&#x2107;"/> 
        <xsl:output-character string="&amp;epsis;" character="&#x1B8;"/> 
        <xsl:output-character string="&amp;zeta;" character="&#x3B6;"/> 
        <xsl:output-character string="&amp;eta;" character="&#x3B7;"/> 
        <xsl:output-character string="&amp;thetas;" character="&#x3B8;"/> 
        <xsl:output-character string="&amp;Theta;" character="&#x398;"/> 
        <xsl:output-character string="&amp;thetav;" character="&#x3D1;"/> 
        <xsl:output-character string="&amp;iota;" character="&#x3B9;"/> 
        <xsl:output-character string="&amp;kappa;" character="&#x3BA;"/> 
        <xsl:output-character string="&amp;kappav;" character="&#x3F0;"/> 
        <xsl:output-character string="&amp;lambda;" character="&#x3BB;"/> 
        <xsl:output-character string="&amp;Lambda;" character="&#x39B;"/> 
        <xsl:output-character string="&amp;mu;" character="&#x3BC;"/> 
        <xsl:output-character string="&amp;nu;" character="&#x3BD;"/> 
        <xsl:output-character string="&amp;xi;" character="&#x3BE;"/> 
        <xsl:output-character string="&amp;Xi;" character="&#x39E;"/> 
        <xsl:output-character string="&amp;pi;" character="&#x3C0;"/> 
        <xsl:output-character string="&amp;piv;" character="&#x3D6;"/> 
        <xsl:output-character string="&amp;Pi;" character="&#x3A0;"/> 
        <xsl:output-character string="&amp;rho;" character="&#x3c1;"/> 
        <xsl:output-character string="&amp;rhov;" character="&#x3F1;"/> 
        <xsl:output-character string="&amp;sigma;" character="&#x3C3;"/> 
        <xsl:output-character string="&amp;Sigma;" character="&#x3A3;"/> 
        <xsl:output-character string="&amp;sigmav;" character="&#x3C2;"/> 
        <xsl:output-character string="&amp;tau;" character="&#x3C4;"/> 
        <xsl:output-character string="&amp;upsi;" character="&#x3C5;"/> 
        <xsl:output-character string="&amp;Upsi;" character="&#x3A5;"/> 
        <xsl:output-character string="&amp;phis;" character="&#x3C6;"/> 
        <xsl:output-character string="&amp;Phi;" character="&#x3A6;"/> 
        <xsl:output-character string="&amp;phiv;" character="&#x3D5;"/> 
        <xsl:output-character string="&amp;chi;" character="&#x3C7;"/> 
        <xsl:output-character string="&amp;psi;" character="&#x3C8;"/> 
        <xsl:output-character string="&amp;Psi;" character="&#x3A8;"/> 
        <xsl:output-character string="&amp;omega;" character="&#x3C9;"/> 
        <xsl:output-character string="&amp;Omega;" character="&#x3A9;"/> 

        <xsl:output-character string="&amp;b.alpha;" character="&#x3B1;"/> 
        <xsl:output-character string="&amp;b.beta;" character="&#x3B2;"/> 
        <xsl:output-character string="&amp;b.gamma;" character="&#x3B3;"/> 
        <xsl:output-character string="&amp;b.Gamma;" character="&#x393;"/> 
        <xsl:output-character string="&amp;b.gammad;" character="&#x3DC;"/> 
        <xsl:output-character string="&amp;b.delta;" character="&#x3B4;"/> 
        <xsl:output-character string="&amp;b.Delta;" character="&#x394;"/> 
        <xsl:output-character string="&amp;b.epsi;" character="&#x3B5;"/> 
        <xsl:output-character string="&amp;b.epsiv;" character="&#x2107;"/> 
        <xsl:output-character string="&amp;b.epsis;" character="&#x1B8;"/> 
        <xsl:output-character string="&amp;b.zeta;" character="&#x3B6;"/> 
        <xsl:output-character string="&amp;b.eta;" character="&#x3B7;"/> 
        <xsl:output-character string="&amp;b.thetas;" character="&#x3B8;"/> 
        <xsl:output-character string="&amp;b.Theta;" character="&#x398;"/> 
        <xsl:output-character string="&amp;b.thetav;" character="&#x3D1;"/> 
        <xsl:output-character string="&amp;b.iota;" character="&#x3B9;"/> 
        <xsl:output-character string="&amp;b.kappa;" character="&#x3BA;"/> 
        <xsl:output-character string="&amp;b.kappav;" character="&#x3F0;"/> 
        <xsl:output-character string="&amp;b.lambda;" character="&#x3BB;"/> 
        <xsl:output-character string="&amp;b.Lambda;" character="&#x39B;"/> 
        <xsl:output-character string="&amp;b.mu;" character="&#x3BC;"/> 
        <xsl:output-character string="&amp;b.nu;" character="&#x3BD;"/> 
        <xsl:output-character string="&amp;b.xi;" character="&#x3BE;"/> 
        <xsl:output-character string="&amp;b.Xi;" character="&#x39E;"/> 
        <xsl:output-character string="&amp;b.pi;" character="&#x3C0;"/> 
        <xsl:output-character string="&amp;b.piv;" character="&#x3D6;"/> 
        <xsl:output-character string="&amp;b.Pi;" character="&#x3A0;"/> 
        <xsl:output-character string="&amp;b.rho;" character="&#x3c1;"/> 
        <xsl:output-character string="&amp;b.rhov;" character="&#x3F1;"/> 
        <xsl:output-character string="&amp;b.sigma;" character="&#x3C3;"/> 
        <xsl:output-character string="&amp;b.Sigma;" character="&#x3A3;"/> 
        <xsl:output-character string="&amp;b.sigmav;" character="&#x3C2;"/> 
        <xsl:output-character string="&amp;b.tau;" character="&#x3C4;"/> 
        <xsl:output-character string="&amp;b.upsi;" character="&#x3C5;"/> 
        <xsl:output-character string="&amp;b.Upsi;" character="&#x3A5;"/> 
        <xsl:output-character string="&amp;b.phis;" character="&#x3C6;"/> 
        <xsl:output-character string="&amp;b.Phi;" character="&#x3A6;"/> 
        <xsl:output-character string="&amp;b.phiv;" character="&#x3D5;"/> 
        <xsl:output-character string="&amp;b.chi;" character="&#x3C7;"/> 
        <xsl:output-character string="&amp;b.psi;" character="&#x3C8;"/> 
        <xsl:output-character string="&amp;b.Psi;" character="&#x3A8;"/> 
        <xsl:output-character string="&amp;b.omega;" character="&#x3C9;"/> 
        <xsl:output-character string="&amp;b.Omega;" character="&#x3A9;"/> 

        <xsl:output-character string="&amp;Agrave;" character="&#192;"/> 
        <xsl:output-character string="&amp;Aacute;" character="&#193;"/> 
        <xsl:output-character string="&amp;Acirc;" character="&#194;"/> 
        <xsl:output-character string="&amp;Atilde;" character="&#195;"/> 
        <xsl:output-character string="&amp;Auml;" character="&#196;"/> 
        <xsl:output-character string="&amp;Aring;" character="&#197;"/> 
        <xsl:output-character string="&amp;AElig;" character="&#198;"/> 
        <xsl:output-character string="&amp;Ccedil;" character="&#199;"/> 
        <xsl:output-character string="&amp;Egrave;" character="&#200;"/> 
        <xsl:output-character string="&amp;Eacute;" character="&#201;"/> 
        <xsl:output-character string="&amp;Ecirc;" character="&#202;"/> 
        <xsl:output-character string="&amp;Euml;" character="&#203;"/> 
        <xsl:output-character string="&amp;Igrave;" character="&#204;"/> 
        <xsl:output-character string="&amp;Iacute;" character="&#205;"/> 
        <xsl:output-character string="&amp;Icirc;" character="&#206;"/> 
        <xsl:output-character string="&amp;Iuml;" character="&#207;"/> 
        <xsl:output-character string="&amp;ETH;" character="&#208;"/> 
        <xsl:output-character string="&amp;Ntilde;" character="&#209;"/> 
        <xsl:output-character string="&amp;Ograve;" character="&#210;"/> 
        <xsl:output-character string="&amp;Oacute;" character="&#211;"/> 
        <xsl:output-character string="&amp;Ocirc;" character="&#212;"/> 
        <xsl:output-character string="&amp;Otilde;" character="&#213;"/> 
        <xsl:output-character string="&amp;Ouml;" character="&#214;"/> 
        <xsl:output-character string="&amp;Oslash;" character="&#216;"/> 
        <xsl:output-character string="&amp;Ugrave;" character="&#217;"/> 
        <xsl:output-character string="&amp;Uacute;" character="&#218;"/> 
        <xsl:output-character string="&amp;Ucirc;" character="&#219;"/> 
        <xsl:output-character string="&amp;Uuml;" character="&#220;"/> 
        <xsl:output-character string="&amp;Yacute;" character="&#221;"/> 
        <xsl:output-character string="&amp;THORN;" character="&#222;"/> 
        <xsl:output-character string="&amp;szlig;" character="&#223;"/> 
        <xsl:output-character string="&amp;agrave;" character="&#224;"/> 
        <xsl:output-character string="&amp;aacute;" character="&#225;"/> 
        <xsl:output-character string="&amp;acirc;" character="&#226;"/> 
        <xsl:output-character string="&amp;atilde;" character="&#227;"/> 
        <xsl:output-character string="&amp;auml;" character="&#228;"/> 
        <xsl:output-character string="&amp;aring;" character="&#229;"/> 
        <xsl:output-character string="&amp;aelig;" character="&#230;"/> 
        <xsl:output-character string="&amp;ccedil;" character="&#231;"/> 
        <xsl:output-character string="&amp;egrave;" character="&#232;"/> 
        <xsl:output-character string="&amp;eacute;" character="&#233;"/> 
        <xsl:output-character string="&amp;ecirc;" character="&#234;"/> 
        <xsl:output-character string="&amp;euml;" character="&#235;"/> 
        <xsl:output-character string="&amp;igrave;" character="&#236;"/> 
        <xsl:output-character string="&amp;iacute;" character="&#237;"/> 
        <xsl:output-character string="&amp;icirc;" character="&#238;"/> 
        <xsl:output-character string="&amp;iuml;" character="&#239;"/> 
        <xsl:output-character string="&amp;eth;" character="&#240;"/> 
        <xsl:output-character string="&amp;ntilde;" character="&#241;"/> 
        <xsl:output-character string="&amp;ograve;" character="&#242;"/> 
        <xsl:output-character string="&amp;oacute;" character="&#243;"/> 
        <xsl:output-character string="&amp;ocirc;" character="&#244;"/> 
        <xsl:output-character string="&amp;otilde;" character="&#245;"/> 
        <xsl:output-character string="&amp;ouml;" character="&#246;"/> 
        <xsl:output-character string="&amp;oslash;" character="&#248;"/> 
        <xsl:output-character string="&amp;ugrave;" character="&#249;"/> 
        <xsl:output-character string="&amp;uacute;" character="&#250;"/> 
        <xsl:output-character string="&amp;ucirc;" character="&#251;"/> 
        <xsl:output-character string="&amp;uuml;" character="&#252;"/> 
        <xsl:output-character string="&amp;yacute;" character="&#253;"/> 
        <xsl:output-character string="&amp;thorn;" character="&#254;"/> 
        <xsl:output-character string="&amp;yuml;" character="&#255;"/> 

        <xsl:output-character string="&amp;abreve;" character="&#x103;"/> 
        <xsl:output-character string="&amp;Abreve;" character="&#x102;"/> 
        <xsl:output-character string="&amp;amacr;" character="&#x101;"/> 
        <xsl:output-character string="&amp;Amacr;" character="&#x100;"/> 
        <xsl:output-character string="&amp;aogon;" character="&#x105;"/> 
        <xsl:output-character string="&amp;Aogon;" character="&#x104;"/> 
        <xsl:output-character string="&amp;cacute;" character="&#x107;"/> 
        <xsl:output-character string="&amp;Cacute;" character="&#x106;"/> 
        <xsl:output-character string="&amp;ccaron;" character="&#x10D;"/> 
        <xsl:output-character string="&amp;Ccaron;" character="&#x10C;"/> 
        <xsl:output-character string="&amp;ccirc;" character="&#x109;"/> 
        <xsl:output-character string="&amp;Ccirc;" character="&#x108;"/> 
        <xsl:output-character string="&amp;cdot;" character="&#x10B;"/> 
        <xsl:output-character string="&amp;Cdot;" character="&#x10A;"/> 
        <xsl:output-character string="&amp;dcaron;" character="&#x10F;"/> 
        <xsl:output-character string="&amp;Dcaron;" character="&#x10E;"/> 
        <xsl:output-character string="&amp;dstrok;" character="&#x111;"/> 
        <xsl:output-character string="&amp;Dstrok;" character="&#x110;"/> 
        <xsl:output-character string="&amp;ecaron;" character="&#x11B;"/> 
        <xsl:output-character string="&amp;Ecaron;" character="&#x11A;"/> 
        <xsl:output-character string="&amp;edot;" character="&#x117;"/> 
        <xsl:output-character string="&amp;Edot;" character="&#x116;"/> 
        <xsl:output-character string="&amp;emacr;" character="&#x113;"/> 
        <xsl:output-character string="&amp;Emacr;" character="&#x112;"/> 
        <xsl:output-character string="&amp;eogon;" character="&#x119;"/> 
        <xsl:output-character string="&amp;Eogon;" character="&#x118;"/> 
        <xsl:output-character string="&amp;gacute;" character="&#x1F5;"/> 
        <xsl:output-character string="&amp;gbreve;" character="&#x11F;"/> 
        <xsl:output-character string="&amp;Gbreve;" character="&#x11E;"/> 
        <xsl:output-character string="&amp;Gcedil;" character="&#x122;"/> 
        <xsl:output-character string="&amp;gcirc;" character="&#x11D;"/> 
        <xsl:output-character string="&amp;Gcirc;" character="&#x11C;"/> 
        <xsl:output-character string="&amp;gdot;" character="&#x121;"/> 
        <xsl:output-character string="&amp;Gdot;" character="&#x120;"/> 
        <xsl:output-character string="&amp;hcirc;" character="&#x125;"/> 
        <xsl:output-character string="&amp;Hcirc;" character="&#x124;"/> 
        <xsl:output-character string="&amp;hstrok;" character="&#x127;"/> 
        <xsl:output-character string="&amp;Hstrok;" character="&#x126;"/> 
        <xsl:output-character string="&amp;Idot;" character="&#x130;"/> 
        <xsl:output-character string="&amp;Imacr;" character="&#x12A;"/> 
        <xsl:output-character string="&amp;imacr;" character="&#x12B;"/> 
        <xsl:output-character string="&amp;ijlig;" character="&#x133;"/> 
        <xsl:output-character string="&amp;IJlig;" character="&#x132;"/> 
        <xsl:output-character string="&amp;inodot;" character="&#x131;"/> 
        <xsl:output-character string="&amp;iogon;" character="&#x12F;"/> 
        <xsl:output-character string="&amp;Iogon;" character="&#x12E;"/> 
        <xsl:output-character string="&amp;itilde;" character="&#x129;"/> 
        <xsl:output-character string="&amp;Itilde;" character="&#x128;"/> 
        <xsl:output-character string="&amp;jcirc;" character="&#x135;"/> 
        <xsl:output-character string="&amp;Jcirc;" character="&#x134;"/> 
        <xsl:output-character string="&amp;kcedil;" character="&#x137;"/> 
        <xsl:output-character string="&amp;Kcedil;" character="&#x136;"/> 
        <xsl:output-character string="&amp;kgreen;" character="&#x138;"/> 
        <xsl:output-character string="&amp;lacute;" character="&#x13A;"/> 
        <xsl:output-character string="&amp;Lacute;" character="&#x139;"/> 
        <xsl:output-character string="&amp;lcaron;" character="&#x13E;"/> 
        <xsl:output-character string="&amp;Lcaron;" character="&#x13D;"/> 
        <xsl:output-character string="&amp;lcedil;" character="&#x13C;"/> 
        <xsl:output-character string="&amp;Lcedil;" character="&#x13B;"/> 
        <xsl:output-character string="&amp;lmidot;" character="&#x140;"/> 
        <xsl:output-character string="&amp;Lmidot;" character="&#x139;"/> 
        <xsl:output-character string="&amp;lstrok;" character="&#x142;"/> 
        <xsl:output-character string="&amp;Lstrok;" character="&#x141;"/> 
        <xsl:output-character string="&amp;nacute;" character="&#x144;"/> 
        <xsl:output-character string="&amp;Nacute;" character="&#x143;"/> 
        <xsl:output-character string="&amp;eng;" character="&#x14B;"/> 
        <xsl:output-character string="&amp;ENG;" character="&#x14A;"/> 
        <xsl:output-character string="&amp;napos;" character="&#x149;"/> 
        <xsl:output-character string="&amp;ncaron;" character="&#x148;"/> 
        <xsl:output-character string="&amp;Ncaron;" character="&#x147;"/> 
        <xsl:output-character string="&amp;ncedil;" character="&#x146;"/> 
        <xsl:output-character string="&amp;Ncedil;" character="&#x145;"/> 
        <xsl:output-character string="&amp;odblac;" character="&#x151;"/> 
        <xsl:output-character string="&amp;Odblac;" character="&#x150;"/> 
        <xsl:output-character string="&amp;Omacr;" character="&#x14C;"/> 
        <xsl:output-character string="&amp;omacr;" character="&#x14D;"/> 
        <xsl:output-character string="&amp;oelig;" character="&#x153;"/> 
        <xsl:output-character string="&amp;OElig;" character="&#x152;"/> 
        <xsl:output-character string="&amp;racute;" character="&#x155;"/> 
        <xsl:output-character string="&amp;Racute;" character="&#x154;"/> 
        <xsl:output-character string="&amp;rcaron;" character="&#x159;"/> 
        <xsl:output-character string="&amp;Rcaron;" character="&#x158;"/> 
        <xsl:output-character string="&amp;rcedil;" character="&#x157;"/> 
        <xsl:output-character string="&amp;Rcedil;" character="&#x156;"/> 
        <xsl:output-character string="&amp;sacute;" character="&#x15B;"/> 
        <xsl:output-character string="&amp;Sacute;" character="&#x158;"/> 
        <xsl:output-character string="&amp;scaron;" character="&#x161;"/> 
        <xsl:output-character string="&amp;Scaron;" character="&#x160;"/> 
        <xsl:output-character string="&amp;scedil;" character="&#x15F;"/> 
        <xsl:output-character string="&amp;Scedil;" character="&#x15E;"/> 
        <xsl:output-character string="&amp;scirc;" character="&#x15C;"/> 
        <xsl:output-character string="&amp;Scirc;" character="&#x15D;"/> 
        <xsl:output-character string="&amp;tcaron;" character="&#x165;"/> 
        <xsl:output-character string="&amp;Tcaron;" character="&#x164;"/> 
        <xsl:output-character string="&amp;tcedil;" character="&#x162;"/> 
        <xsl:output-character string="&amp;Tcedil;" character="&#x163;"/> 
        <xsl:output-character string="&amp;tstrok;" character="&#x167;"/> 
        <xsl:output-character string="&amp;Tstrok;" character="&#x166;"/> 
        <xsl:output-character string="&amp;ubreve;" character="&#x16D;"/> 
        <xsl:output-character string="&amp;Ubreve;" character="&#x16C;"/> 
        <xsl:output-character string="&amp;udblac;" character="&#x171;"/> 
        <xsl:output-character string="&amp;Udblac;" character="&#x170;"/> 
        <xsl:output-character string="&amp;umacr;" character="&#x16B;"/> 
        <xsl:output-character string="&amp;Umacr;" character="&#x16A;"/> 
        <xsl:output-character string="&amp;uogon;" character="&#x173;"/> 
        <xsl:output-character string="&amp;Uogon;" character="&#x172;"/> 
        <xsl:output-character string="&amp;uring;" character="&#x16F;"/> 
        <xsl:output-character string="&amp;Uring;" character="&#x16E;"/> 
        <xsl:output-character string="&amp;utilde;" character="&#x169;"/> 
        <xsl:output-character string="&amp;Utilde;" character="&#x168;"/> 
        <xsl:output-character string="&amp;wcirc;" character="&#x175;"/> 
        <xsl:output-character string="&amp;Wcirc;" character="&#x174;"/> 
        <xsl:output-character string="&amp;ycirc;" character="&#x177;"/> 
        <xsl:output-character string="&amp;Ycirc;" character="&#x176;"/> 
        <xsl:output-character string="&amp;Yuml;" character="&#x178;"/> 
        <xsl:output-character string="&amp;zacute;" character="&#x17A;"/> 
        <xsl:output-character string="&amp;Zacute;" character="&#x179;"/> 
        <xsl:output-character string="&amp;zcaron;" character="&#x1FD;"/> 
        <xsl:output-character string="&amp;Zcaron;" character="&#x17E;"/> 
        <xsl:output-character string="&amp;zdot;" character="&#x17C;"/> 
        <xsl:output-character string="&amp;Zdot;" character="&#x17B;"/> 

        <xsl:output-character string="&amp;hal;" character="&#189;"/> 
        <xsl:output-character string="&amp;frac12;" character="&#189;"/> 
        <xsl:output-character string="&amp;frac14;" character="&#188;"/> 
        <xsl:output-character string="&amp;frac34;" character="&#190;"/> 
        <xsl:output-character string="&amp;frac18;" character="&#x215B;"/>  
        <xsl:output-character string="&amp;frac38;" character="&#x215C;"/> 
        <xsl:output-character string="&amp;frac58;" character="&#x215D;"/> 
        <xsl:output-character string="&amp;frac78;" character="&#x215E;"/> 

        <xsl:output-character string="&amp;sup1;" character="&#185;"/> 
        <xsl:output-character string="&amp;sup2;" character="&#178;"/> 
        <xsl:output-character string="&amp;sup3;" character="&#179;"/> 

        <xsl:output-character string="&amp;plus;" character="+"/> 
        <xsl:output-character string="&amp;plusmn;" character="&#xB1;"/> 
        <xsl:output-character string="&amp;equals;" character="="/> 
        <xsl:output-character string="&amp;divide;" character="&#247;"/> 
        <xsl:output-character string="&amp;times;" character="&#215;"/> 

        <xsl:output-character string="&amp;curren;" character="&#164;"/> 
        <xsl:output-character string="&amp;pound;" character="&#165;"/> 
        <xsl:output-character string="&amp;dollar;" character="$"/> 
        <xsl:output-character string="&amp;cent;" character="&#162;"/> 
        <xsl:output-character string="&amp;yen;" character="&#165;"/> 

        <xsl:output-character string="&amp;num;" character="#"/> 
        <xsl:output-character string="&amp;percnt;" character="&#37;"/> 
        <xsl:output-character string="&amp;ast;" character="*"/> 
        <xsl:output-character string="&amp;commat;" character="@"/> 
        <xsl:output-character string="&amp;lsqb;" character="["/> 
        <xsl:output-character string="&amp;bsol;" character="\"/> 
        <xsl:output-character string="&amp;rsqb;" character="]"/> 
        <xsl:output-character string="&amp;lcub;" character="{"/> 
        <xsl:output-character string="&amp;horbar;" character="&#x2015;"/> 
        <xsl:output-character string="&amp;verbar;" character="|"/> 
        <xsl:output-character string="&amp;rcub;" character="}"/> 
        <xsl:output-character string="&amp;micro;" character="&#181;"/> 
        <xsl:output-character string="&amp;ohm;" character="&#2126;"/> 
        <xsl:output-character string="&amp;deg;" character="&#176;"/> 
        <xsl:output-character string="&amp;ordm;" character="&#186;"/> 
        <xsl:output-character string="&amp;ordf;" character="&#170;"/> 
        <xsl:output-character string="&amp;sect;" character="&#167;"/> 
        <xsl:output-character string="&amp;para;" character="&#182;"/> 
        <xsl:output-character string="&amp;middot;" character="&#183;"/> 
        <xsl:output-character string="&amp;larr;" character="&#x2190;"/> 
        <xsl:output-character string="&amp;rarr;" character="&#x2192;"/> 
        <xsl:output-character string="&amp;uarr;" character="&#x2191;"/> 
        <xsl:output-character string="&amp;darr;" character="&#x2193;"/> 
        <xsl:output-character string="&amp;copy;" character="&#169;"/> 
        <xsl:output-character string="&amp;reg;" character="&#174;"/> 
        <xsl:output-character string="&amp;trade;" character="&#8482;"/> 
        <xsl:output-character string="&amp;brvbar;" character="&#xA6;"/> 
        <xsl:output-character string="&amp;not;" character="&#xAC;"/> 
        <xsl:output-character string="&amp;sung;" character="&#x266A;"/> 

        <xsl:output-character string="&amp;excl;" character="!"/> 
        <xsl:output-character string="&amp;iexcl;" character="&#xA1;"     /> 
        <xsl:output-character string="&amp;quot;" character='"'        /> 
        <xsl:output-character string="&amp;apos;" character="'"/> 
        <xsl:output-character string="&amp;lpar;" character="("/> 
        <xsl:output-character string="&amp;rpar;" character=")"/> 
        <xsl:output-character string="&amp;comma;" character=","/> 
        <xsl:output-character string="&amp;lowbar;" character="_"/> 
        <xsl:output-character string="&amp;hyphen;" character="&#x2010;"/> 
        <xsl:output-character string="&amp;period;" character="."/> 
        <xsl:output-character string="&amp;sol;" character="/"/> 
        <xsl:output-character string="&amp;colon;" character=":"/> 
        <xsl:output-character string="&amp;semi;" character=";"/> 
        <xsl:output-character string="&amp;quest;" character="?"/> 
        <xsl:output-character string="&amp;iquest;" character="&#xBF;"/> 
        <xsl:output-character string="&amp;laquo;" character="&#x2039;"/> 
        <xsl:output-character string="&amp;raquo;" character="&#x203A;"/> 
        <xsl:output-character string="&amp;lsquo;" character="&#x2018;"/> 
        <xsl:output-character string="&amp;rsquo;" character="&#x2019;"/> 
        <xsl:output-character string="&amp;ldquo;" character="&#x201C;"/> 
        <xsl:output-character string="&amp;rdquo;" character="&#x201D;"/> 
        <xsl:output-character string="&amp;nbsp;" character="&#160;"/> 
        <xsl:output-character string="&amp;shy;" character="&#173;"/> 

        <xsl:output-character string="&amp;emsp;" character="&#x2003;"/> 
        <xsl:output-character string="&amp;ensp;" character="&#x2002;"/> 
        <xsl:output-character string="&amp;emsp13;" character="&#x2004;"/> 
        <xsl:output-character string="&amp;emsp14;" character="&#x2005;"/> 
        <xsl:output-character string="&amp;numsp;" character="&#x2007;"/> 
        <xsl:output-character string="&amp;puncsp;" character="&#x2008;"/> 
        <xsl:output-character string="&amp;thinsp;" character="&#x2009;"/> 
        <xsl:output-character string="&amp;hairsp;" character="&#x200A;"/> 
        <xsl:output-character string="&amp;mdash;" character="&#x2014;"/> 
        <xsl:output-character string="&amp;ndash;" character="&#x2013;"/> 
        <xsl:output-character string="&amp;dash;" character="&#x2010;"/> 
        <xsl:output-character string="&amp;blank;" character="&#x2423;"/> 
        <xsl:output-character string="&amp;hellip;" character="&#x2026;"/> 
        <xsl:output-character string="&amp;nldr;" character="&#x2025;"/> 
        <xsl:output-character string="&amp;frac13;" character="&#x2153;"/> 
        <xsl:output-character string="&amp;frac23;" character="&#x2154;"/> 
        <xsl:output-character string="&amp;frac15;" character="&#x2155;"/> 
        <xsl:output-character string="&amp;frac25;" character="&#x2156;"/> 
        <xsl:output-character string="&amp;frac35;" character="&#x2157;"/> 
        <xsl:output-character string="&amp;frac45;" character="&#x2158;"/> 
        <xsl:output-character string="&amp;frac16;" character="&#x2159;"/> 
        <xsl:output-character string="&amp;frac56;" character="&#x215a;"/> 
        <xsl:output-character string="&amp;incare;" character="&#x2105;"/> 
        <xsl:output-character string="&amp;block;" character="&#x2588;"/> 
        <xsl:output-character string="&amp;uhblk;" character="&#x2580;"/> 
        <xsl:output-character string="&amp;lhblk;" character="&#x2584;"/> 
        <xsl:output-character string="&amp;blk14;" character="&#x2591;"/> 
        <xsl:output-character string="&amp;blk12;" character="&#x2592;"/> 
        <xsl:output-character string="&amp;blk34;" character="&#x2593;"/> 
        <xsl:output-character string="&amp;marker;" character="&#x25AE;"/> 
        <xsl:output-character string="&amp;cir;" character="&#x25CB;"/> 
        <xsl:output-character string="&amp;squ;" character="&#x25A1;"/> 
        <xsl:output-character string="&amp;rect;" character="&#x25AD;"/> 
        <xsl:output-character string="&amp;utri;" character="&#x25B5;"/> 
        <xsl:output-character string="&amp;dtri;" character="&#x25BF;"/> 
        <xsl:output-character string="&amp;star;" character="&#x2606;"/> 
        <xsl:output-character string="&amp;bull;" character="&#x2022;"/> 
        <xsl:output-character string="&amp;squf;" character="&#x25AA;"/> 
        <xsl:output-character string="&amp;utrif;" character="&#x25B4;"/> 
        <xsl:output-character string="&amp;dtrif;" character="&#x25BE;"/> 
        <xsl:output-character string="&amp;ltrif;" character="&#x25C2;"/> 
        <xsl:output-character string="&amp;rtrif;" character="&#x25B8;"/> 
        <xsl:output-character string="&amp;clubs;" character="&#x2663;"/> 
        <xsl:output-character string="&amp;diams;" character="&#x2662;"/> 
        <xsl:output-character string="&amp;hearts;" character="&#x2661;"/> 
        <xsl:output-character string="&amp;spades;" character="&#x2660;"/> 
        <xsl:output-character string="&amp;malt;" character="&#x2720;"/> 
        <xsl:output-character string="&amp;dagger;" character="&#x2020;"/> 
        <xsl:output-character string="&amp;Dagger;" character="&#x2021;"/> 
        <xsl:output-character string="&amp;check;" character="&#x2713;"/> 
        <xsl:output-character string="&amp;cross;" character="&#x2717;"/> 
        <xsl:output-character string="&amp;sharp;" character="&#x266F;"/> 
        <xsl:output-character string="&amp;flat;" character="&#x266D;"/> 
        <xsl:output-character string="&amp;male;" character="&#x2642;"/> 
        <xsl:output-character string="&amp;female;" character="&#x2640;"/> 
        <xsl:output-character string="&amp;phone;" character="&#x26E0;"/> 
        <xsl:output-character string="&amp;telrec;" character="&#x2315;"/> 
        <xsl:output-character string="&amp;copysr;" character="&#x2117;"/> 
        <xsl:output-character string="&amp;caret;" character="&#x2041;"/> 
        <xsl:output-character string="&amp;lsquor;" character="&#x201A;"/> 
        <xsl:output-character string="&amp;ldquor;" character="&#x201E;"/> 

        <xsl:output-character string="&amp;fflig;" character="&#xFB00;"/> 
        <xsl:output-character string="&amp;filig;" character="&#xFB01;"/> 
        <xsl:output-character string="&amp;ffilig;" character="&#xFB03;"/> 
        <xsl:output-character string="&amp;ffllig;" character="&#xFB04;"/> 
        <xsl:output-character string="&amp;fllig;" character="&#xFB02;"/> 

        <xsl:output-character string="&amp;mldr;" character="&#x2025;"/> 
        <xsl:output-character string="&amp;rdquor;" character="&#x201D;"/> 
        <xsl:output-character string="&amp;rsquor;" character="&#x2019;"/> 
        <xsl:output-character string="&amp;vellip;" character="&#x22EE;"/> 

        <xsl:output-character string="&amp;hybull;" character="&#x2043;"/> 
        <xsl:output-character string="&amp;loz;" character="&#x2727;"/> 
        <xsl:output-character string="&amp;lozf;" character="&#x2726;"/> 
        <xsl:output-character string="&amp;ltri;" character="&#x25C3;"/> 
        <xsl:output-character string="&amp;rtri;" character="&#x25B9;"/> 
        <xsl:output-character string="&amp;starf;" character="&#x2605;"/> 

        <xsl:output-character string="&amp;natur;" character="&#x266E;"/> 
        <xsl:output-character string="&amp;rx;" character="&#x211E;"/> 
        <xsl:output-character string="&amp;sext;" character="&#x2736;"/> 

        <xsl:output-character string="&amp;target;" character="&#x2316;"/> 
        <xsl:output-character string="&amp;dlcrop;" character="&#x230D;"/> 
        <xsl:output-character string="&amp;drcrop;" character="&#x230C;"/> 
        <xsl:output-character string="&amp;ulcrop;" character="&#x230F;"/> 
        <xsl:output-character string="&amp;urcrop;" character="&#x230E;"/> 

        <xsl:output-character string="&amp;aleph;" character="&#x2135;"/> 
        <xsl:output-character string="&amp;and;" character="&#x2227;"/> 
        <xsl:output-character string="&amp;ang90;" character="&#x221F;"/> 
        <xsl:output-character string="&amp;angsph;" character="&#x2222;"/> 
        <xsl:output-character string="&amp;ap;" character="&#x2249;"/> 
        <xsl:output-character string="&amp;becaus;" character="&#x2235;"/> 
        <xsl:output-character string="&amp;bottom;" character="&#x22A5;"/> 
        <xsl:output-character string="&amp;cap;" character="&#x2229;"/> 
        <xsl:output-character string="&amp;cong;" character="&#x2245;"/> 
        <xsl:output-character string="&amp;conint;" character="&#x222E;"/> 
        <xsl:output-character string="&amp;cup;" character="&#x222A;"/> 
        <xsl:output-character string="&amp;equiv;" character="&#x2261;"/> 
        <xsl:output-character string="&amp;exist;" character="&#x2203;"/> 
        <xsl:output-character string="&amp;forall;" character="&#x2200;"/> 
        <xsl:output-character string="&amp;fnof;" character="&#x192;"/> 
        <xsl:output-character string="&amp;ge;" character="&#x2265;"/> 
        <xsl:output-character string="&amp;iff;" character="&#x21D4;"/> 
        <xsl:output-character string="&amp;infin;" character="&#x221E;"/> 
        <xsl:output-character string="&amp;int;" character="&#x222B;"/> 
        <xsl:output-character string="&amp;isin;" character="&#x2208;"/> 
        <xsl:output-character string="&amp;lang;" character="&#x2329;"/> 
        <xsl:output-character string="&amp;lArr;" character="&#x21D0;"/> 
        <xsl:output-character string="&amp;le;" character="&#x2264;"/> 
        <xsl:output-character string="&amp;minus;" character="-"/> 
        <xsl:output-character string="&amp;mnplus;" character="&#x2213;"/> 
        <xsl:output-character string="&amp;nabla;" character="&#x2207;"/> 
        <xsl:output-character string="&amp;ne;" character="&#x2260;"/> 
        <xsl:output-character string="&amp;ni;" character="&#x220B;"/> 
        <xsl:output-character string="&amp;or;" character="&#x2228;"/> 
        <xsl:output-character string="&amp;par;" character="&#x2225;"/> 
        <xsl:output-character string="&amp;part;" character="&#x2202;"/> 
        <xsl:output-character string="&amp;permil;" character="&#x2030;"/> 
        <xsl:output-character string="&amp;perp;" character="&#x22A5;"/> 
        <xsl:output-character string="&amp;prime;" character="&#x2032;"/> 
        <xsl:output-character string="&amp;Prime;" character="&#x2033;"/> 
        <xsl:output-character string="&amp;prop;" character="&#x221D;"/> 
        <xsl:output-character string="&amp;radic;" character="&#x221A;"/> 
        <xsl:output-character string="&amp;rang;" character="&#x232A;"/> 
        <xsl:output-character string="&amp;rArr;" character="&#x21D2;"/> 
        <xsl:output-character string="&amp;sim;" character="&#x223C;"/> 
        <xsl:output-character string="&amp;sime;" character="&#x2243;"/> 
        <xsl:output-character string="&amp;square;" character="&#x25A1;"/> 
        <xsl:output-character string="&amp;sub;" character="&#x2282;"/> 
        <xsl:output-character string="&amp;sube;" character="&#x2286;"/> 
        <xsl:output-character string="&amp;sup;" character="&#x2283;"/> 
        <xsl:output-character string="&amp;supe;" character="&#x2287;"/> 
        <xsl:output-character string="&amp;there4;" character="&#x2234;"/> 
        <xsl:output-character string="&amp;Verbar;" character="&#x2016;"/> 

        <xsl:output-character string="&amp;angst;" character="&#x212B;"/> 
        <xsl:output-character string="&amp;bernou;" character="&#x212C;"/> 
        <xsl:output-character string="&amp;compfn;" character="&#x2218;"/> 
        <xsl:output-character string="&amp;Dot;" character="&#xA8;"/> 
        <xsl:output-character string="&amp;DotDot;" character="&#x20DC;"/> 
        <xsl:output-character string="&amp;hamilt;" character="&#x210B;"/> 
        <xsl:output-character string="&amp;lagran;" character="&#x2112;"/> 
        <xsl:output-character string="&amp;lowast;" character="&#x2217;"/> 
        <xsl:output-character string="&amp;notin;" character="&#x2209;"/> 
        <xsl:output-character string="&amp;order;" character="&#x2134;"/> 
        <xsl:output-character string="&amp;phmmat;" character="&#x2133;"/> 
        <xsl:output-character string="&amp;tdot;" character="&#x20DB;"/> 
        <xsl:output-character string="&amp;tprime;" character="&#x2034;"/> 
        <xsl:output-character string="&amp;wedgeq;" character="&#x2259;"/> 
    </xsl:character-map>
                    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="/">        
        <cwrc>
            <xsl:for-each select="AUTHORITYLIST/AUTHORITYITEM">
                <entity>
                    <organization>
                        <recordInfo>
                            <originInfo>
                                <projectId>orlando</projectId>
                            </originInfo>
                            <accessCondition type="use and reproduction">
                                Use of this public-domain resource is governed by the <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons Attribution-NonCommercial 4.0 International License</a>.
                            </accessCondition>
                        </recordInfo>
                        
                        <xsl:variable name="standard">
                            <xsl:value-of select="@STANDARD" disable-output-escaping="yes"/>
                        </xsl:variable>
                        <xsl:variable name="standard_escaped">
                            <xsl:value-of select="string(@STANDARD)" disable-output-escaping="no"/>
                        </xsl:variable>
                        
                        <identity>
                            <preferredForm>
                                <namePart>
                                    <xsl:value-of select="fn:replace($standard_escaped, ',+', ',')"/>
                                </namePart> 
                            </preferredForm>
                            
                            <displayLabel>
                                    <xsl:value-of select="@DISPLAY"/>
                            </displayLabel>
                            
                            <variantForms>
                                <xsl:if test="fn:matches($standard, '^.*,,+.*$')">
                                    <variant>
                                        <namePart>
                                            <xsl:value-of select="$standard"/>
                                        </namePart>
                                        <authorizedBy>
                                            <projectId>orlando</projectId>
                                        </authorizedBy>
                                    </variant>
                                </xsl:if>
                                <xsl:if test="fn:compare($standard_escaped, $standard) != 0">
                                    <variant>
                                        <namePart>
                                            <xsl:value-of select="$standard_escaped"/>
                                        </namePart>
                                        <authorizedBy>
                                            <projectId>orlando</projectId>
                                        </authorizedBy>
                                    </variant>
                                </xsl:if>
                                
                                <xsl:for-each select="FORM">
                                    <variant>
                                        <namePart>
                                            <xsl:value-of select="."/>
                                        </namePart>
                                    </variant>
                                </xsl:for-each>
                            </variantForms>
                        </identity>
                        
                    </organization>
                </entity>
            </xsl:for-each>
        </cwrc>
    </xsl:template>
</xsl:stylesheet>