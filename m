Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2003 07:01:54 +0000 (GMT)
Received: from webmail29.rediffmail.com ([IPv6:::ffff:203.199.83.39]:38286
	"HELO rediffmail.com") by linux-mips.org with SMTP
	id <S8225501AbTKRHBW>; Tue, 18 Nov 2003 07:01:22 +0000
Received: (qmail 27153 invoked by uid 510); 18 Nov 2003 06:57:41 -0000
Date: 18 Nov 2003 06:57:41 -0000
Message-ID: <20031118065741.27152.qmail@webmail29.rediffmail.com>
Received: from unknown (210.210.7.195) by rediffmail.com via HTTP; 18 nov 2003 06:57:41 -0000
MIME-Version: 1.0
From: "ashish  anand" <ashish_ibm@rediffmail.com>
Reply-To: "ashish  anand" <ashish_ibm@rediffmail.com>
To: "Ralf Baechle" <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Assertion duration of edge interrupts can decrease spurious interrupts ..?
Content-type: multipart/alternative;
	boundary="Next_1069138661---0-203.199.83.39-27131"
Return-Path: <ashish_ibm@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3637
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashish_ibm@rediffmail.com
Precedence: bulk
X-list: linux-mips

 This is a multipart mime message


--Next_1069138661---0-203.199.83.39-27131
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0A1.If i have a compulsion to use egde triggering peripheral on MIPS CP=
0,<BR>=0Awould it be useful if i can increase the assertion duration of edg=
e<BR>=0Ainterupts (this I can do) ..I mean to say probablity of loosing edg=
e interrupts will decrasse.<BR>=0A<BR>=0A2.does CP0 interrupt logic samples=
 interrupts after each instruction or at some multiplication(..or division.=
?) of system clock.<BR>=0A<BR>=0ARegards,<BR>=0AAshish<BR>=0A<BR>=0AOn Mon,=
 17 Nov 2003 Ralf Baechle wrote :<BR>=0A&gt;On Mon, Nov 17, 2003 at 11:40:1=
1AM -0000, ashish&nbsp; anand wrote:<BR>=0A&gt;<BR>=0A&gt; &gt; I have a ge=
neric question regarding interrupt controler functionality<BR>=0A&gt; &gt; =
integrated in CP0 on mips architecture.<BR>=0A&gt; &gt; I don't see any int=
erface to configure the edge/level triggering settings.<BR>=0A&gt;<BR>=0A&g=
t;MIPS only supports level triggered interrupts in coprocessor 0.<BR>=0A&gt=
;<BR>=0A&gt; &gt; though in our BSP we take care of handling spurious inter=
rupts , but is<BR>=0A&gt; &gt; this designed to be like that..?<BR>=0A&gt;<=
BR>=0A&gt;There is no handling needed.&nbsp; If the processor takes an inte=
rrupt but none<BR>=0A&gt;of the interrupt bits in c0_status is set, just re=
turn.&nbsp; That's a legal<BR>=0A&gt;condition.<BR>=0A&gt;<BR>=0A&gt; &gt; =
I mean to ask , suppose I want to add a edge triggering peripheral.<BR>=0A&=
gt; &gt; to the extent of my understanding this will certainly generate the=
<BR>=0A&gt; &gt; spurious interrupts when coupled with a level triggering c=
onfiguration<BR>=0A&gt; &gt; in CP0 (by default..?).<BR>=0A&gt;<BR>=0A&gt;Y=
ou can directly sample the level of the edge irq in the interrupt bits in<B=
R>=0A&gt;the cause register.&nbsp; But that seems a fragile approach.<BR>=
=0A&gt;<BR>=0A&gt; &gt; if i am handling through CP0_CAUSE or any other reg=
ister inspection<BR>=0A&gt; &gt; that can work but I am loosing so many val=
id interupts which would have<BR>=0A&gt; &gt; been really valid with edge t=
rigger pin of interrupt controller&nbsp; .<BR>=0A&gt; &gt; further this typ=
e of handling is valid for actual spurious interrupts<BR>=0A&gt; &gt; not f=
or those who are certain to be fired because of edge/level mismatching.<BR>=
=0A&gt;<BR>=0A&gt;If you really need to use an edge triggered interrupt on =
a MIPS then you<BR>=0A&gt;probably want to use some circuit interrupt contr=
oller that converts the<BR>=0A&gt;edge to a level triggered interrupt.<BR>=
=0A&gt;<BR>=0A&gt;&nbsp;  Ralf<BR>=0A=0A</P>=0A<br><br>=0A<A target=3D"_bla=
nk" HREF=3D"http://clients.rediff.com/signature/track_sig.asp"><IMG SRC=3D"=
http://ads.rediff.com/RealMedia/ads/adstream_nx.cgi/www.rediffmail.com/inbo=
x.htm@Bottom" BORDER=3D0 VSPACE=3D0 HSPACE=3D0 HEIGHT=3D74 WIDTH=3D496></a>=
=0A
--Next_1069138661---0-203.199.83.39-27131
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

1.If i have a compulsion to use egde triggering peripheral on MIPS CP0,=0Aw=
ould it be useful if i can increase the assertion duration of edge=0Ainteru=
pts (this I can do) ..I mean to say probablity of loosing edge interrupts w=
ill decrasse.=0A=0A2.does CP0 interrupt logic samples interrupts after each=
 instruction or at some multiplication(..or division.?) of system clock.=0A=
=0ARegards,=0AAshish=0A=0AOn Mon, 17 Nov 2003 Ralf Baechle wrote :=0A>On Mo=
n, Nov 17, 2003 at 11:40:11AM -0000, ashish  anand wrote:=0A>=0A> > I have =
a generic question regarding interrupt controler functionality=0A> > integr=
ated in CP0 on mips architecture.=0A> > I don't see any interface to config=
ure the edge/level triggering settings.=0A>=0A>MIPS only supports level tri=
ggered interrupts in coprocessor 0.=0A>=0A> > though in our BSP we take car=
e of handling spurious interrupts , but is=0A> > this designed to be like t=
hat..?=0A>=0A>There is no handling needed.  If the processor takes an inter=
rupt but none=0A>of the interrupt bits in c0_status is set, just return.  T=
hat's a legal=0A>condition.=0A>=0A> > I mean to ask , suppose I want to add=
 a edge triggering peripheral.=0A> > to the extent of my understanding this=
 will certainly generate the=0A> > spurious interrupts when coupled with a =
level triggering configuration=0A> > in CP0 (by default..?).=0A>=0A>You can=
 directly sample the level of the edge irq in the interrupt bits in=0A>the =
cause register.  But that seems a fragile approach.=0A>=0A> > if i am handl=
ing through CP0_CAUSE or any other register inspection=0A> > that can work =
but I am loosing so many valid interupts which would have=0A> > been really=
 valid with edge trigger pin of interrupt controller  .=0A> > further this =
type of handling is valid for actual spurious interrupts=0A> > not for thos=
e who are certain to be fired because of edge/level mismatching.=0A>=0A>If =
you really need to use an edge triggered interrupt on a MIPS then you=0A>pr=
obably want to use some circuit interrupt controller that converts the=0A>e=
dge to a level triggered interrupt.=0A>=0A>   Ralf=0A
--Next_1069138661---0-203.199.83.39-27131--
