Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Oct 2003 06:48:48 +0100 (BST)
Received: from mail5.infineon.com ([IPv6:::ffff:203.126.245.197]:23012 "EHLO
	mail5-i.infineon.com") by linux-mips.org with ESMTP
	id <S8225346AbTJNFsp>; Tue, 14 Oct 2003 06:48:45 +0100
Received: from sinse004.ap.infineon.com (sgpk993a.sin.infineon.com [172.17.65.75])
	by mail5-i.infineon.com (8.11.7p1+Sun/8.11.7) with ESMTP id h9E5miT23181
	for <linux-mips@linux-mips.org>; Tue, 14 Oct 2003 13:48:44 +0800 (SGT)
Received: from blrw502w.blr.infineon.com ([172.29.142.21]) by sinse004.ap.infineon.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id 46XX073R; Tue, 14 Oct 2003 13:48:41 +0800
Received: by blrw502w.blr.infineon.com with Internet Mail Service (5.5.2653.19)
	id <TVHGBNZ2>; Tue, 14 Oct 2003 11:16:23 +0530
Message-ID: <0C674B14EAEBD61196D900B0D03DB49F010C835E@blrw502w.blr.infineon.com>
From: "Babbellapati Syam Krishna (IFIN DC COM)" 
	<Syam-Krishna.Babbellapati@infineon.com>
To: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: "sel" field in MTC0 instruction?
Date: Tue, 14 Oct 2003 11:16:20 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C39216.7E8A3B30"
Return-Path: <Syam-Krishna.Babbellapati@infineon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Syam-Krishna.Babbellapati@infineon.com
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C39216.7E8A3B30
Content-Type: text/plain

Hi there,
 
I am running linux on a MIPS64 5kc processor. From the Data Sheet and
Software User's manual, I could see that we can access the various MIPS
Performance Counters (Coprocessor 0, Register 25) by using the "sel" field
of the MTC0 or MFC0 registers.
 
Format:   MTC0 rt, rd

        (OR) MTC0 rt, rd, sel

Based on the second format, I have written a new assembly languauge routine:

 
#define write_32bit_cp0_performance_register(register,value) \
__asm__ __volatile__( \
"mtc0\t%0,"STR(register)",sel\n\t" \
"nop" \
: : "r" (value));
 
"sel" in the above assembly instruction is a value of either 0, 1, 2 or 3
based on the register which we would like to write.
"sel" in the above code is newly introduced by us and if there is no sel
then the code compiles properly but I guess we would always be accessing one
register only in that case.
(A similar routine is written using "mfc0" also for reading the values
back.)
 
But this code results in a compilation error:
{standard input}: Assembler messages:
{standard input}:41: Error: illegal operands `mtc0 $3,$25,0'
{standard input}:45: Error: illegal operands `mfc0 $5,$25,1'
where $25 is CP0_PERFORMANCE register.
 
The command used for compilation is:
mipsel-linux-gcc -c -I /home/syam/linux-2.4.20with095LTT/include/ -Wall -O2
-fomit-frame-pointer -fno-common -finline-limit=5000 -G 0 -mno-abicalls
-fno-pic -mcpu=r4600 -mips2 -pipe -DMODULE -mlong-calls tempCache.c
 
 
Could someone help me in making me understand what is wrong here? Is it a
problem with the syntax of the arguments or is there an assembler support
which I am lacking for such an instruction?
 
Any kind of pointers would be of help.
 
Thank you,
Syam

----------------------------------------------------------------------------
------------- 
*Disclaimer*
"This e-mail and any attachments are confidential and may contain trade
secrets or privileged or undisclosed information. They may also be subject
to copyright protection. Please do not copy, distribute or forward this
email to anyone unless authorized. If you are not a named addressee, you
must not use, disclose, retain or reproduce all or any part of the
information contained in this e-mail or any attachments. If you have
received this email by mistake please notify the sender immediately by
return email and destroy/delete all copies of the email." 

 

------_=_NextPart_001_01C39216.7E8A3B30
Content-Type: text/html

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=us-ascii">
<TITLE>Message</TITLE>

<META content="MSHTML 5.50.4926.2500" name=GENERATOR></HEAD>
<BODY>
<DIV><SPAN class=955195704-14102003><FONT face=Arial size=2>Hi 
there,</FONT></SPAN></DIV>
<DIV><SPAN class=955195704-14102003><FONT face=Arial 
size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=955195704-14102003><FONT face=Arial size=2>I am running linux 
on a MIPS64 5kc processor. From the Data Sheet and Software User's manual, I 
could see that we can access the various MIPS Performance Counters (Coprocessor 
0, Register 25) by using the "sel" field of the MTC0 or MFC0 
registers.</FONT></SPAN></DIV>
<DIV><SPAN class=955195704-14102003><FONT face=Arial 
size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=955195704-14102003>
<P><FONT size=2><STRONG>Format:&nbsp;</STRONG><SPAN 
class=955195704-14102003><FONT face=Courier>&nbsp;&nbsp;</FONT></SPAN><FONT 
face=Courier>MTC0 rt, rd</FONT></FONT></P>
<P><FONT face=Courier><FONT size=2><SPAN 
class=955195704-14102003>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(OR) 
</SPAN>MTC0 rt, rd, sel</FONT></FONT></P>
<P><FONT color=#0000ff><FONT face=Arial color=#000000 size=2><SPAN 
class=955195704-14102003>Based on the second format, I have written a new 
assembly languauge routine:</SPAN></FONT></P></DIV>
<DIV><FONT face=Arial color=#000000 size=2><SPAN 
class=955195704-14102003></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#000000 size=2>#define 
write_32bit_cp0_performance_register(register,value) \</FONT></DIV>
<DIV><FONT face=Arial color=#000000 size=2>__asm__ __volatile__( \</FONT></DIV>
<DIV><FONT face=Arial color=#000000 
size=2>"mtc0\t%0,"STR(register)",</FONT></FONT><FONT face=Arial 
size=2>sel</FONT><FONT color=#0000ff><FONT face=Arial color=#000000 size=2>\n\t" 
\</FONT></DIV>
<DIV><FONT face=Arial color=#000000 size=2>"nop" \</FONT></DIV>
<DIV><FONT face=Arial color=#000000 size=2>: : "r" (value));</FONT></DIV>
<DIV><FONT face=Arial color=#000000 size=2></FONT>&nbsp;</DIV>
<DIV></FONT><FONT face=Arial size=2>"</FONT><FONT face=Arial><FONT 
size=2>sel"&nbsp;<SPAN class=955195704-14102003>in the above assembly 
instruction is&nbsp;</SPAN>a value of either 0, 1, 2 or 3 based on the register 
which we would like to write.</FONT></FONT></DIV>
<DIV><FONT face=Arial size=2>"sel" in the above code is newly introduced by us 
and if there is no sel then the code compiles properly but I guess we would 
always be accessing one register only in&nbsp;<SPAN 
class=955195704-14102003>that </SPAN>case.</FONT></DIV><FONT color=#0000ff>
<DIV><FONT face=Arial color=#000000 size=2>(A similar routine is written using 
"mfc0" also for reading the values back.)</FONT></DIV>
<DIV><FONT face=Arial color=#000000 size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#000000 size=2>But this code results in a 
compilation error:</FONT></DIV></FONT><FONT face="Courier New" size=2>
<DIV><FONT face=Arial>{standard input}: Assembler messages:</FONT></DIV>
<DIV><FONT face=Arial>{standard input}:41: Error: illegal operands `mtc0 
$3,$25,0'</FONT></DIV>
<DIV><FONT face=Arial>{standard input}:45: Error: illegal operands `mfc0 
$5,$25,1'</FONT></DIV></FONT><FONT color=#0000ff>
<DIV><FONT face=Arial><FONT color=#000000><FONT size=2><SPAN 
class=955195704-14102003>w</SPAN>here $25 is CP0_PERFORMANCE 
register.</FONT></FONT></FONT></DIV>
<DIV><FONT face=Arial color=#000000 size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#000000 size=2>The command used for compilation 
is:</FONT></DIV></FONT><FONT face=Arial size=2>
<DIV>mipsel-linux-gcc -c -I /home/syam/linux-2.4.20with095LTT/include/ -Wall -O2 
-fomit-frame-pointer -fno-common -finline-limit=5000 -G 0 -mno-abicalls -fno-pic 
-mcpu=r4600 -mips2 -pipe -DMODULE -mlong-calls tempCache.c</DIV></FONT></SPAN>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV><SPAN class=955195704-14102003><FONT face=Arial 
size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=955195704-14102003><FONT face=Arial size=2>Could someone help 
me in making me understand what is wrong here? Is it a problem with the syntax 
of the arguments or is there an assembler support which I am lacking for such an 
instruction?</FONT></SPAN></DIV>
<DIV><SPAN class=955195704-14102003><FONT face=Arial 
size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=955195704-14102003><FONT face=Arial size=2>Any kind of pointers 
would be of help.</FONT></SPAN></DIV>
<DIV><SPAN class=955195704-14102003><FONT face=Arial 
size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=955195704-14102003><FONT face=Arial size=2>Thank 
you,</FONT></SPAN></DIV>
<DIV><SPAN class=955195704-14102003><FONT face=Arial 
size=2>Syam</FONT></SPAN></DIV><!-- Converted from text/rtf format -->
<P><SPAN lang=en-us><FONT face="Comic Sans MS" 
size=2>-----------------------------------------------------------------------------------------</FONT><FONT 
face="Times New Roman"> </FONT></SPAN><BR><SPAN lang=en-us><FONT 
face="Comic Sans MS" color=#0000ff size=1>*Disclaimer*<BR>"This e-mail and any 
attachments are confidential and may contain trade secrets or privileged or 
undisclosed information. They may also be subject to copyright protection. 
Please do not copy, distribute or forward this email to anyone unless 
authorized. If you are not a named addressee, you must not use, disclose, retain 
or reproduce all or any part of the information contained in this e-mail or any 
attachments. If you have received this email by mistake please notify the sender 
immediately by return email and destroy/delete all copies of the email." 
</FONT></SPAN></P>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C39216.7E8A3B30--
