Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6K36Jk10121
	for linux-mips-outgoing; Thu, 19 Jul 2001 20:06:19 -0700
Received: from viditec-netmedia.com.tw (61-220-240-70.HINET-IP.hinet.net [61.220.240.70])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6K36GV10113
	for <linux-mips@oss.sgi.com>; Thu, 19 Jul 2001 20:06:16 -0700
Received: from kjlin ([61.220.240.66])
	by viditec-netmedia.com.tw (8.10.0/8.10.0) with SMTP id f6K5BFv06730
	for <linux-mips@oss.sgi.com>; Fri, 20 Jul 2001 13:11:15 +0800
Message-ID: <016701c110c6$a371d580$056aaac0@kjlin>
From: "kjlin" <kj.lin@viditec-netmedia.com.tw>
To: <linux-mips@oss.sgi.com>
Subject: weird printf problem
Date: Fri, 20 Jul 2001 10:49:45 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0164_01C11109.B05F54A0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.

------=_NextPart_000_0164_01C11109.B05F54A0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

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
The output message will die at "Hello World=3D10" or "Hello World=3D168" =
or "Hello World=3D76" ........
Every times the message dies at different place but it will never =
successfully be outputed "200" times.
However, if the condition is changed to "while(i<100)", then everything =
is fine.
It is so weird!!
Why too much "printf" will cause the program to die?
Is it the problem of uClibc or kernel?
Does the compiler for my testing program concern this weird problem?
Can anybody give me some hints?

Thanks,
KJ

------=_NextPart_000_0164_01C11109.B05F54A0
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
<DIV><FONT size=3D2>
<DIV><FONT size=3D2>
<DIV><FONT size=3D2>Hi all,</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>I ported linux to&nbsp;my embeded board&nbsp;and =
encountered a=20
weird "printf" problem.</FONT></DIV>
<DIV>The library i used is uClibc.</DIV>
<DIV><FONT size=3D2>I made the kernel to run a testing program directly =
after boot=20
up.</FONT></DIV>
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
while(i&lt;200)<BR>&nbsp;&nbsp;&nbsp;&nbsp;{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
printf("Hello=20
World=3D%d\n",i);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
i++;<BR>&nbsp;&nbsp;&nbsp;&nbsp;}</FONT></DIV>
<DIV><FONT size=3D2>}</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>The&nbsp;output message will die at "Hello =
World=3D10" or "Hello=20
World=3D168" or "Hello World=3D76" ........</FONT></DIV>
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
<DIV><FONT size=3D2>Is it the problem of uClibc or kernel?</FONT></DIV>
<DIV>Does the compiler for my testing program concern this weird =
problem?</DIV>
<DIV><FONT size=3D2>Can anybody give me some hints?</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks,</DIV>
<DIV>KJ</DIV></FONT></DIV></FONT></DIV></BODY></HTML>

------=_NextPart_000_0164_01C11109.B05F54A0--
