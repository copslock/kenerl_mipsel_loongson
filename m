Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2003 11:41:23 +0000 (GMT)
Received: from webmail27.rediffmail.com ([IPv6:::ffff:203.199.83.37]:39119
	"HELO rediffmail.com") by linux-mips.org with SMTP
	id <S8225381AbTKQLkv>; Mon, 17 Nov 2003 11:40:51 +0000
Received: (qmail 22353 invoked by uid 510); 17 Nov 2003 11:40:11 -0000
Date: 17 Nov 2003 11:40:11 -0000
Message-ID: <20031117114011.22352.qmail@webmail27.rediffmail.com>
Received: from unknown (210.210.7.195) by rediffmail.com via HTTP; 17 nov 2003 11:40:11 -0000
MIME-Version: 1.0
From: "ashish  anand" <ashish_ibm@rediffmail.com>
Reply-To: "ashish  anand" <ashish_ibm@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: is cp0 interrupt infrastructure sufficient..?
Content-type: multipart/alternative;
	boundary="Next_1069069211---0-203.199.83.37-22293"
Return-Path: <ashish_ibm@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashish_ibm@rediffmail.com
Precedence: bulk
X-list: linux-mips

 This is a multipart mime message


--Next_1069069211---0-203.199.83.37-22293
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0AI have a generic question regarding interrupt controler functionality=
 <BR>=0Aintegrated in CP0 on mips architecture.<BR>=0AI don't see any inter=
face to configure the edge/level triggering settings.<BR>=0A<BR>=0Athough i=
n our BSP we take care of handling spurious interrupts , but is<BR>=0Athis =
designed to be like that..?<BR>=0A<BR>=0AI mean to ask , suppose I want to =
add a edge triggering peripheral <BR>=0A, to the extent of my understanding=
 this will certainly generate the<BR>=0Aspurious interrupts when coupled wi=
th a level triggering configuration <BR>=0Ain CP0 (by default..?).<BR>=0A<B=
R>=0Aif i am handling through CP0_CAUSE or any other register inspection<BR=
>=0Athat can work but I am loosing so many valid interupts which would have=
 been really valid with edge trigger pin of interrupt controller&nbsp; .<BR=
>=0Afurther this type of handling is valid for actual spurious interrupts <=
BR>=0Anot for those who are certain to be fired because of edge/level misma=
tching.<BR>=0A<BR>=0ABest Regards,<BR>=0AAshish Anand<BR>=0A<BR>=0A<BR>=0A<=
BR>=0A<BR>=0A=0A</P>=0A<br><br>=0A<A target=3D"_blank" HREF=3D"http://clien=
ts.rediff.com/signature/track_sig.asp"><IMG SRC=3D"http://ads.rediff.com/Re=
alMedia/ads/adstream_nx.cgi/www.rediffmail.com/inbox.htm@Bottom" BORDER=3D0=
 VSPACE=3D0 HSPACE=3D0 HEIGHT=3D74 WIDTH=3D496></a>=0A
--Next_1069069211---0-203.199.83.37-22293
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I have a generic question regarding interrupt controler functionality =0Ain=
tegrated in CP0 on mips architecture.=0AI don't see any interface to config=
ure the edge/level triggering settings.=0A=0Athough in our BSP we take care=
 of handling spurious interrupts , but is=0Athis designed to be like that..=
?=0A=0AI mean to ask , suppose I want to add a edge triggering peripheral =
=0A, to the extent of my understanding this will certainly generate the=0As=
purious interrupts when coupled with a level triggering configuration =0Ain=
 CP0 (by default..?).=0A=0Aif i am handling through CP0_CAUSE or any other =
register inspection=0Athat can work but I am loosing so many valid interupt=
s which would have been really valid with edge trigger pin of interrupt con=
troller  .=0Afurther this type of handling is valid for actual spurious int=
errupts =0Anot for those who are certain to be fired because of edge/level =
mismatching.=0A=0ABest Regards,=0AAshish Anand=0A=0A=0A=0A=0A
--Next_1069069211---0-203.199.83.37-22293--
