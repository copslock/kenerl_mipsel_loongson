Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Apr 2004 21:18:30 +0100 (BST)
Received: from mailout2.echostar.com ([IPv6:::ffff:204.76.128.102]:50951 "EHLO
	mailout2.echostar.com") by linux-mips.org with ESMTP
	id <S8225747AbUDNUS1>; Wed, 14 Apr 2004 21:18:27 +0100
Received: by riv-exchcon.echostar.com with Internet Mail Service (5.5.2653.19)
	id <2LYLSY2W>; Wed, 14 Apr 2004 14:18:20 -0600
Message-ID: <F71A246055866844B66AFEB10654E7860F1B0B@riv-exchb6.echostar.com>
From: "Xu, Jiang" <Jiang.Xu@echostar.com>
To: linux-mips@linux-mips.org
Subject: questions about keyboard
Date: Wed, 14 Apr 2004 14:18:18 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4225D.9FF8CAD9"
Return-Path: <Jiang.Xu@echostar.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jiang.Xu@echostar.com
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C4225D.9FF8CAD9
Content-Type: text/plain

Hi,  All,
 
I tried couple places and hope can get some help here.
 
I try to connect a USB keyboard device to a mips embedded system.
There is no console or X Window or any type of the graphic system
configured.
All I want to do is to:
The user can dynamically connect the USB keyboard to the device. The device
will listen to the key event from the keyboard and response by doing certain
things.
 
I believe I successfully configured the USB keyboard.  I verified this by
put "printk" at the first line of the function handle_scancode in
keyboard.c.  Everytime when I push the key on the keyboard, I see that
printk.
 
However, what I don't get is how can I get the key event from the kernel?  I
tried to listen to all the ttyN, but none of them connect to the keyboard.  
I wonder how I can write a user space application that can get the key
event?  Could somebody help me out?  Because it is an embedded device, there
is no X.
 
Thanks
 
John
 

------_=_NextPart_001_01C4225D.9FF8CAD9
Content-Type: text/html

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=us-ascii">
<TITLE>Message</TITLE>

<META content="MSHTML 5.50.4937.800" name=GENERATOR></HEAD>
<BODY>
<DIV><FONT face=Arial size=2><SPAN class=640081020-14042004>Hi,&nbsp; 
All,</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=640081020-14042004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=640081020-14042004>I tried couple 
places and hope can get some help here.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=640081020-14042004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=640081020-14042004>I try to connect a 
USB keyboard device to a mips embedded system.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=640081020-14042004>There is no console 
or X Window or any type of the graphic system configured.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=640081020-14042004>All I want to do is 
to:</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=640081020-14042004>The user can 
dynamically connect the USB keyboard to the device.&nbsp;The device will listen 
to the key event from the keyboard and response by doing certain 
things.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=640081020-14042004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=640081020-14042004>I believe I 
successfully configured the USB keyboard.&nbsp; I verified this by put "printk" 
at the first line of the function handle_scancode in keyboard.c.&nbsp; Everytime 
when I push the key on the keyboard, I see that printk.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=640081020-14042004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=640081020-14042004>However, what I 
don't get&nbsp;is how can I get the key event from the kernel?&nbsp; I tried to 
listen to all the ttyN, but none of them connect to the keyboard.&nbsp; 
</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=640081020-14042004>I wonder how I can 
write a user space application that can get the key event?&nbsp; <SPAN 
class=640081020-14042004>Could somebody help me out?&nbsp; Because it is an 
embedded device, there is no X.</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=640081020-14042004><SPAN 
class=640081020-14042004></SPAN></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=640081020-14042004><SPAN 
class=640081020-14042004>Thanks</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=640081020-14042004><SPAN 
class=640081020-14042004></SPAN></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=640081020-14042004><SPAN 
class=640081020-14042004>John</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=640081020-14042004></SPAN></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C4225D.9FF8CAD9--
