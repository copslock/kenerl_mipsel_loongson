Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Mar 2004 13:06:22 +0000 (GMT)
Received: from webmail7.rediffmail.com ([IPv6:::ffff:202.54.124.152]:16183
	"HELO rediffmail.com") by linux-mips.org with SMTP
	id <S8225548AbUCZNGP>; Fri, 26 Mar 2004 13:06:15 +0000
Received: (qmail 4181 invoked by uid 510); 26 Mar 2004 13:06:00 -0000
Date: 26 Mar 2004 13:06:00 -0000
Message-ID: <20040326130600.4179.qmail@webmail7.rediffmail.com>
Received: from unknown (203.124.152.50) by rediffmail.com via HTTP; 26 mar 2004 13:06:00 -0000
MIME-Version: 1.0
From: "ashish  anand" <ashish_ibm@rediffmail.com>
Reply-To: "ashish  anand" <ashish_ibm@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: clearing interrupt outside handler..?
Content-type: multipart/alternative;
	boundary="Next_1080306360---0-202.54.124.152-4149"
Return-Path: <ashish_ibm@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashish_ibm@rediffmail.com
Precedence: bulk
X-list: linux-mips

 This is a multipart mime message


--Next_1080306360---0-202.54.124.152-4149
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0AHello,<BR>=0A<BR>=0AI am restarting a thread discussed november last =
year regarding<BR>=0Aspurious interrupts generation due to edge triggering =
.<BR>=0Apls. refer ,<BR>=0Ahttp://www.linux-mips.org/archives/linux-mips/20=
03-11/msg00071.html<BR>=0A<BR>=0Asomehow this problem is again surfaced.<BR=
>=0AI am interfacing a peripheral to mips CP0 interrupt controller<BR>=0Ath=
rough GPIO which converts edge to level .<BR>=0Anow my question is that ,<B=
R>=0A<BR>=0Ais it always safe to clear the interrupt status outside the int=
errupt handler in a driver under some particular path flow ?<BR>=0AI think =
it is not as it may land-up in a situation where by the time<BR>=0AGPIO det=
ects the edge due to requirement of certain&nbsp; minimum pulse width durat=
ion , it is already cleared and thus a spurious interrupt generation will h=
appen.<BR>=0A<BR>=0AI might be wrong .I am looking for comments on above me=
ntioned situation.<BR>=0A<BR>=0ABest Regards,<BR>=0AAshish<BR>=0A<BR>=0A<BR=
>=0A<BR>=0A=0A</P>=0A<br><br>=0A<A target=3D"_blank" HREF=3D"http://clients=
.rediff.com/signature/track_sig.asp"><IMG SRC=3D"http://ads.rediff.com/Real=
Media/ads/adstream_nx.cgi/www.rediffmail.com/inbox.htm@Bottom" BORDER=3D0 V=
SPACE=3D0 HSPACE=3D0 HEIGHT=3D74 WIDTH=3D496></a>=0A
--Next_1080306360---0-202.54.124.152-4149
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,=0A=0AI am restarting a thread discussed november last year regarding=
=0Aspurious interrupts generation due to edge triggering .=0Apls. refer ,=
=0Ahttp://www.linux-mips.org/archives/linux-mips/2003-11/msg00071.html=0A=
=0Asomehow this problem is again surfaced.=0AI am interfacing a peripheral =
to mips CP0 interrupt controller=0Athrough GPIO which converts edge to leve=
l .=0Anow my question is that ,=0A=0Ais it always safe to clear the interru=
pt status outside the interrupt handler in a driver under some particular p=
ath flow ?=0AI think it is not as it may land-up in a situation where by th=
e time=0AGPIO detects the edge due to requirement of certain  minimum pulse=
 width duration , it is already cleared and thus a spurious interrupt gener=
ation will happen.=0A=0AI might be wrong .I am looking for comments on abov=
e mentioned situation.=0A=0ABest Regards,=0AAshish=0A=0A=0A=0A
--Next_1080306360---0-202.54.124.152-4149--
