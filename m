Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6O2fSt07770
	for linux-mips-outgoing; Mon, 23 Jul 2001 19:41:28 -0700
Received: from viditec-netmedia.com.tw (61-220-240-70.HINET-IP.hinet.net [61.220.240.70])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6O2fJO07762
	for <linux-mips@oss.sgi.com>; Mon, 23 Jul 2001 19:41:19 -0700
Received: from kjlin ([61.220.240.66])
	by viditec-netmedia.com.tw (8.10.0/8.10.0) with SMTP id f6O4j0v16641
	for <linux-mips@oss.sgi.com>; Tue, 24 Jul 2001 12:45:00 +0800
Message-ID: <01b701c113e7$9cbba1c0$056aaac0@kjlin>
From: "kjlin" <kj.lin@viditec-netmedia.com.tw>
To: <linux-mips@oss.sgi.com>
References: <016701c110c6$a371d580$056aaac0@kjlin>
Subject: Re: weird printf problem
Date: Tue, 24 Jul 2001 10:23:22 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_01B4_01C1142A.AA6963A0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.

------=_NextPart_000_01B4_01C1142A.AA6963A0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

My kernel version is 2.4.1 and the processor is an MIPS R4000 style =
embedded processor.
I ues the serial port as my console.
I found that the reason why the printf message will not be completely =
outputed is the process of my testing program will not be selected again =
by the schedular after outputing some message.
Its "state" is TASK_INTERRUPTIBLE but the return value of =
signal_pending(prev) is zero.
Therefore, it is deleted from running queue in schedul() and never wake =
up.

asmlinkage void schedule(void)
{
...
...
move_rr_back:

         switch (prev->state) {
                 case TASK_INTERRUPTIBLE:
                         if (signal_pending(prev)) {
                                 prev->state =3D TASK_RUNNING;
                                 break;
                         }
                 default:
                         del_from_runqueue(prev);       (<---- Be =
deleted here!)
                 case TASK_RUNNING:
        }
...
...
}

I am not familiar with the machanism of tty_write().
Can any body tell me where should be chceked over?
My serial driver is modified based on drivers/char/serial.c

Thanks.
  ----- Original Message -----=20
  From: kjlin=20
  To: linux-mips@oss.sgi.com=20
  Sent: Friday, July 20, 2001 10:49 AM
  Subject: weird printf problem


  Hi all,

  I ported linux to my embeded board and encountered a weird "printf" =
problem.
  The library i used is uClibc.
  I made the kernel to run a testing program directly after boot up.
  In my case, less "printf" work well but more will fail.
  Here is my testing program:

  main()
  {
      int i=3D0;

      while(i<200)
      {
                  printf("Hello World=3D%d\n",i);
                  i++;
      }
  }
  =20
  The output message will die at "Hello World=3D10" or "Hello =
World=3D168" or "Hello World=3D76" ........
  Every times the message dies at different place but it will never =
successfully be outputed "200" times.
  However, if the condition is changed to "while(i<100)", then =
everything is fine.
  It is so weird!!
  Why too much "printf" will cause the program to die?
  Is it the problem of uClibc or kernel?
  Does the compiler for my testing program concern this weird problem?
  Can anybody give me some hints?

  Thanks,
  KJ

------=_NextPart_000_01B4_01C1142A.AA6963A0
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dbig5" http-equiv=3DContent-Type>
<META content=3D"MSHTML 5.00.2919.6307" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT size=3D2>My kernel version is 2.4.1 and the processor is an =
MIPS R4000=20
style embedded processor.</FONT></DIV>
<DIV><FONT size=3D2>I ues the serial port as my console.</FONT></DIV>
<DIV><FONT size=3D2>I found that the reason why the printf message will =
not be=20
completely outputed is the process of my testing program will not be =
selected=20
again by the schedular after outputing some message.</FONT></DIV>
<DIV><FONT size=3D2>Its "state" is TASK_INTERRUPTIBLE but the return =
value of=20
signal_pending(prev) is zero.</FONT></DIV>
<DIV><FONT size=3D2>Therefore, it&nbsp;is&nbsp;deleted from running =
queue in=20
schedul() and never wake up.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>asmlinkage&nbsp;void schedule(void)</FONT></DIV>
<DIV><FONT size=3D2>{</FONT></DIV>
<DIV><FONT size=3D2>...</FONT></DIV>
<DIV><FONT size=3D2>...</FONT></DIV>
<DIV><FONT size=3D2>move_rr_back:</FONT></DIV>
<DIV><FONT size=3D2><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
switch=20
(prev-&gt;state)=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
case=20
TASK_INTERRUPTIBLE:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;=20
if (signal_pending(prev))=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
prev-&gt;state =3D=20
TASK_RUNNING;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
break;</FONT></DIV>
<DIV><FONT=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
}<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
default:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;=20
del_from_runqueue(prev);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(&lt;--=
--&nbsp;<STRONG>Be=20
deleted=20
here</STRONG>!)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
case TASK_RUNNING:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
}<BR>...</FONT></DIV>
<DIV><FONT size=3D2>...</FONT></DIV>
<DIV><FONT size=3D2>}</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>I am not familiar with the machanism of=20
tty_write().</FONT></DIV>
<DIV><FONT size=3D2>Can any body tell me where should be chceked=20
over?</FONT></DIV>
<DIV><FONT size=3D2>My serial driver is modified based on=20
drivers/char/serial.c</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>Thanks.</FONT></DIV>
<BLOCKQUOTE=20
style=3D"BORDER-LEFT: #000000 2px solid; MARGIN-LEFT: 5px; MARGIN-RIGHT: =
0px; PADDING-LEFT: 5px; PADDING-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt =B7s=B2=D3=A9=FA=C5=E9">----- Original =
Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt =B7s=B2=D3=A9=FA=C5=E9; =
font-color: black"><B>From:</B>=20
  <A href=3D"mailto:kj.lin@viditec-netmedia.com.tw"=20
  title=3Dkj.lin@viditec-netmedia.com.tw>kjlin</A> </DIV>
  <DIV style=3D"FONT: 10pt =B7s=B2=D3=A9=FA=C5=E9"><B>To:</B> <A=20
  href=3D"mailto:linux-mips@oss.sgi.com"=20
  title=3Dlinux-mips@oss.sgi.com>linux-mips@oss.sgi.com</A> </DIV>
  <DIV style=3D"FONT: 10pt =B7s=B2=D3=A9=FA=C5=E9"><B>Sent:</B> Friday, =
July 20, 2001 10:49 AM</DIV>
  <DIV style=3D"FONT: 10pt =B7s=B2=D3=A9=FA=C5=E9"><B>Subject:</B> weird =
printf problem</DIV>
  <DIV><BR></DIV>
  <DIV><FONT size=3D2>
  <DIV><FONT size=3D2>
  <DIV><FONT size=3D2>Hi all,</FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><FONT size=3D2>I ported linux to&nbsp;my embeded board&nbsp;and =
encountered=20
  a weird "printf" problem.</FONT></DIV>
  <DIV>The library i used is uClibc.</DIV>
  <DIV><FONT size=3D2>I made the kernel to run a testing program =
directly after=20
  boot up.</FONT></DIV>
  <DIV><FONT size=3D2>In my case,&nbsp;less "printf" work well but more =
will=20
  fail.</FONT></DIV>
  <DIV><FONT size=3D2>Here is my testing program:</FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><FONT size=3D2>main()</FONT></DIV>
  <DIV><FONT size=3D2>{</FONT></DIV>
  <DIV><FONT size=3D2>&nbsp;&nbsp;&nbsp; int i=3D0;</FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><FONT size=3D2>&nbsp;&nbsp;&nbsp;=20
  =
while(i&lt;200)<BR>&nbsp;&nbsp;&nbsp;&nbsp;{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  printf("Hello=20
  =
World=3D%d\n",i);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  i++;<BR>&nbsp;&nbsp;&nbsp;&nbsp;}</FONT></DIV>
  <DIV><FONT size=3D2>}</FONT></DIV>
  <DIV><FONT size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT size=3D2>The&nbsp;output message will die at "Hello =
World=3D10" or=20
  "Hello World=3D168" or "Hello World=3D76" ........</FONT></DIV>
  <DIV><FONT size=3D2>Every times the message dies at different =
place</FONT><FONT=20
  size=3D2> but it will&nbsp;never successfully be outputed "200"=20
  times.</FONT></DIV>
  <DIV><FONT size=3D2>However, if the condition is changed to =
"while(i&lt;100)",=20
  then everything is fine.</FONT></DIV>
  <DIV><FONT size=3D2>It is so weird!!</FONT></DIV>
  <DIV><FONT size=3D2>Why too much "printf" will cause the program to=20
  die?</FONT></DIV>
  <DIV><FONT size=3D2>Is it the problem of uClibc or =
kernel?</FONT></DIV>
  <DIV>Does the compiler for my testing program concern this weird=20
problem?</DIV>
  <DIV><FONT size=3D2>Can anybody give me some hints?</FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV>Thanks,</DIV>
  <DIV>KJ</DIV></FONT></DIV></FONT></DIV></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_01B4_01C1142A.AA6963A0--
