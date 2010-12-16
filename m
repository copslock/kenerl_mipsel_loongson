Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Dec 2010 16:39:40 +0100 (CET)
Received: from p02c12o148.mxlogic.net ([208.65.145.81]:47584 "EHLO
        p02c12o148.mxlogic.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491984Ab0LPPjg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Dec 2010 16:39:36 +0100
Received: from unknown [76.164.174.83] (EHLO p02c12o148.mxlogic.net)
        by p02c12o148.mxlogic.net(mxl_mta-6.8.0-0)
        with ESMTP id 8b23a0d4.4fd11940.16581.00-596.39485.p02c12o148.mxlogic.net (envelope-from <stuart.venters@adtran.com>);
        Thu, 16 Dec 2010 08:39:36 -0700 (MST)
X-MXL-Hash: 4d0a32b8520ce80c-dfa8330b89686899b5d3fcb14d218904f17fb405
Received: from unknown [76.164.174.83] (EHLO ex-hc2.corp.adtran.com)
        by p02c12o148.mxlogic.net(mxl_mta-6.8.0-0) over TLS secured channel
        with ESMTP id 3a23a0d4.0.16449.00-346.39120.p02c12o148.mxlogic.net (envelope-from <stuart.venters@adtran.com>);
        Thu, 16 Dec 2010 08:39:22 -0700 (MST)
X-MXL-Hash: 4d0a32aa2c213941-df095f40de2c3ae2673865912ad3b5ba8ae75495
Received: from corp-exfr2.corp.adtran.com (172.23.101.22) by
 ex-hc2.corp.adtran.com (172.22.50.75) with Microsoft SMTP Server id
 14.1.255.0; Thu, 16 Dec 2010 09:39:14 -0600
Received: from EXV1.corp.adtran.com ([172.22.48.215]) by
 corp-exfr2.corp.adtran.com with Microsoft SMTPSVC(6.0.3790.3959);       Thu, 16
 Dec 2010 09:37:51 -0600
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
        boundary="----_=_NextPart_001_01CB9D37.329CD4D4"
Subject: Re: SMTC support status in latest git head.
Date:   Thu, 16 Dec 2010 09:37:50 -0600
Message-ID: <8F242B230AD6474C8E7815DE0B4982D7179FB880@EXV1.corp.adtran.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: SMTC support status in latest git head.
Thread-Index: AcudNzLhpdxoeFw9TESvZ+VCX95xGQ==
From:   STUART VENTERS <stuart.venters@adtran.com>
To:     <kevink@paralogos.com>, <anoop.pa@gmail.com>
CC:     <linux-mips@linux-mips.org>, <Anoop_P.A@pmc-sierra.com>
X-OriginalArrivalTime: 16 Dec 2010 15:37:51.0732 (UTC) FILETIME=[3329A340:01CB9D37]
X-Spam: [F=0.2000000000; CM=0.500; S=0.200(2010121501)]
X-MAIL-FROM: <stuart.venters@adtran.com>
X-SOURCE-IP: [76.164.174.83]
X-AnalysisOut: [v=1.0 c=1 a=fMTePymILGAA:10 a=BLceEmwcHowA:10 a=5zDNsY1we+]
X-AnalysisOut: [1mvVcp/5+1jQ==:17 a=2gDGsJ0qIHAYSYq85ygA:9 a=Rm815P_HxUJB1]
X-AnalysisOut: [vUu0nx3oy7OdUIA:4 a=wPNLvfGTeEIA:10 a=bz_LyBC371D_bxk66sgA]
X-AnalysisOut: [:9 a=kQzYtOy80GB8jIcn57UA:7 a=Wd32qH50gXumUTYiKwDOTyR-fzEA]
X-AnalysisOut: [:4]
Return-Path: <stuart.venters@adtran.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stuart.venters@adtran.com
Precedence: bulk
X-list: linux-mips

------_=_NextPart_001_01CB9D37.329CD4D4
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Two other possible clues:

The EVP is clear in the MVPControl register.
   Does this say that only VPE0, T0 gets to run?

Also the EXCPT bits in VPEControl for VPE1 indicate a Gating Storage =
Exception dispatch.
   But that seems to conflict the EVP bit above.

Perhaps these are an artifact of getting to a good state to dump things =
out.

------_=_NextPart_001_01CB9D37.329CD4D4
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.59">
<TITLE>Re: SMTC support status in latest git head.</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Two other possible clues:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">The EVP is clear in the MVPControl =
register.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; Does this say that only =
VPE0, T0 gets to run?</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Also the EXCPT bits in VPEControl for =
VPE1 indicate a Gating Storage Exception dispatch.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; But that seems to =
conflict the EVP bit above.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Perhaps these are an artifact of =
getting to a good state to dump things out.</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CB9D37.329CD4D4--
