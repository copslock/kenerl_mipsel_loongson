Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Aug 2004 21:31:02 +0100 (BST)
Received: from mailout2.echostar.com ([IPv6:::ffff:204.76.128.102]:61706 "EHLO
	mailout2.echostar.com") by linux-mips.org with ESMTP
	id <S8225241AbUHEUa4>; Thu, 5 Aug 2004 21:30:56 +0100
Received: by riv-exchcon.echostar.com with Internet Mail Service (5.5.2653.19)
	id <QHDV02NK>; Thu, 5 Aug 2004 14:30:44 -0600
Message-ID: <F71A246055866844B66AFEB10654E7860F1B84@riv-exchb6.echostar.com>
From: "Xu, Jiang" <Jiang.Xu@echostar.com>
To: linux-mips@linux-mips.org
Subject: shared memory issues on linux kernel 2.4.18
Date: Thu, 5 Aug 2004 14:30:34 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C47B2B.0F1D2E15"
Return-Path: <Jiang.Xu@echostar.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jiang.Xu@echostar.com
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C47B2B.0F1D2E15
Content-Type: text/plain

Hi, All,
 
The kernel version may be old to most of you guys, but this is what I am
doing the tests on.
 
Previously I use uclibc tool chain and compiling everything fine and it runs
fine; System V IPC works, including shared memory works...
The nightmare starts when I try to use glibc tool chain.  I downloaded
crosstool and successfully compiled everything.
However, when I run it problem happens on shared memory.
What I did for testing is this:
1) call shmget to allocate the shared memory
2) call shmat to mmap to process virtual memory space.
3) call shmctl to verify everything appeared fine.
4) for testing, just write couple bytes inside of that memory region.
 
The problem and also the interesting thing is:
If without 4) everything runs fine.
However, once excute 4) or any type of the writing to that memory region,
the box will get a kernel crash later, but not immediately....
I guess the kernel crashes when kswapd tried to do something, because the
oops happens on kswapd with the following information:
 
Kernel BUG at filemap.c:908!
Unable to handle kernel paging request at virtual address 00000000, epc ==
80025ebc, ra == 80025ebc
 
But if I do not excute 4) everything runs perfect without problem.
 
At now, I am completely out of clue, wonder anybody may have any ideas and
can help me out??
 
Thanks
 
John
 
 
 

------_=_NextPart_001_01C47B2B.0F1D2E15
Content-Type: text/html

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=us-ascii">
<TITLE>Message</TITLE>

<META content="MSHTML 5.50.4937.800" name=GENERATOR></HEAD>
<BODY>
<DIV><FONT face=Arial size=2><SPAN class=119061920-05082004>Hi, 
All,</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=119061920-05082004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=119061920-05082004>The kernel version 
may be old to most of you guys, but this is what I am doing the tests 
on.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=119061920-05082004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=119061920-05082004>Previously I use 
uclibc tool chain and compiling everything fine and it runs fine;&nbsp;System V 
IPC works, including shared memory works...</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=119061920-05082004>The nightmare starts 
when I try to use glibc tool chain.&nbsp; I downloaded crosstool and 
successfully compiled everything.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=119061920-05082004>However, when I run 
it problem happens on shared memory.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=119061920-05082004>What I did for 
testing is this:</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=119061920-05082004>1) call shmget to 
allocate the shared memory</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=119061920-05082004>2) call shmat to 
mmap to process virtual memory space.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=119061920-05082004>3) call shmctl to 
verify everything appeared fine.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=119061920-05082004>4) for testing, just 
write couple bytes inside of that memory region.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=119061920-05082004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=119061920-05082004>The problem and also 
the interesting thing is:</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=119061920-05082004>If without 4) 
everything runs fine.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=119061920-05082004>However, once excute 
4) or any type of the writing to that memory region, the box will get a kernel 
crash later, but not immediately....</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=119061920-05082004>I guess the kernel 
crashes when kswapd tried to do something, because&nbsp;the</SPAN></FONT><FONT 
face=Arial size=2><SPAN class=119061920-05082004> oops happens on kswapd with 
the following information:</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=119061920-05082004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=119061920-05082004>Kernel BUG at 
filemap.c:908!</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=119061920-05082004>Unable to handle 
kernel paging request at virtual address 00000000, epc == 80025ebc, ra == 
80025ebc</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=119061920-05082004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=119061920-05082004>But if I do not 
excute 4) everything runs perfect without problem.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=119061920-05082004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=119061920-05082004>At now, I am 
completely out of clue, wonder anybody may have any ideas and can help me 
out??</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=119061920-05082004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=119061920-05082004>Thanks</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=119061920-05082004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=119061920-05082004>John</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=119061920-05082004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=119061920-05082004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=119061920-05082004></SPAN></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C47B2B.0F1D2E15--
