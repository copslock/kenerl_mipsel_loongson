Received:  by oss.sgi.com id <S305161AbQEKL1p>;
	Thu, 11 May 2000 11:27:45 +0000
Received: from deliverator.sgi.com ([204.94.214.10]:851 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQEKL1d>;
	Thu, 11 May 2000 11:27:33 +0000
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id EAA19078; Thu, 11 May 2000 04:22:43 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id EAA55389; Thu, 11 May 2000 04:27:02 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA03849
	for linux-list;
	Thu, 11 May 2000 04:16:10 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA85204
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 11 May 2000 04:16:09 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA06172
	for <linux@cthulhu.engr.sgi.com>; Thu, 11 May 2000 04:16:01 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from dandelion.sonytel.be (dandelion.sonytel.be [193.74.243.153])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id NAA07109
	for <linux@cthulhu.engr.sgi.com>; Thu, 11 May 2000 13:15:44 +0200 (MET DST)
Date:   Thu, 11 May 2000 13:15:43 +0200 (MET DST)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     linux@cthulhu.engr.sgi.com
Subject: weird tests in arch/mips/config.in
Message-ID: <Pine.GSO.4.10.10005111310320.14945-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


I found why I no longer get IDE and serial support on my DDB Vrc-5074 board
with the current Linux/MIPS CVS tree: someone played with the conditions in
arch/mips/config.in.

What's the purpose of e.g.

    if [ "$CONFIG_DECSTATION" != "n" -a "$CONFIG_SGI_IP22" != "n" ]; then

? This is only true if you compile a kernel that supports both DECstations and
IP22s, which is not what you want. I'd expect tests like

    if [ "$CONFIG_DECSTATION" = "y" -o "$CONFIG_SGI_IP22" = "y" ]; then

or

    if [ "$CONFIG_DECSTATION" = "n" -a "$CONFIG_SGI_IP22" = "n" ]; then

FWIW, the path below is what I needed for my DDB5074. But I think the
DECstation and IP22 guys have to sort out the above conditions first.

Index: arch/mips/config.in
===================================================================
RCS file: /cvs/linux/arch/mips/config.in,v
retrieving revision 1.50
diff -u -r1.50 config.in
--- arch/mips/config.in	2000/04/19 04:00:05	1.50
+++ arch/mips/config.in	2000/05/11 10:04:50
@@ -168,13 +168,11 @@
    source net/Config.in
 fi
 
-if [ "$CONFIG_DECSTATION" != "n" -a \
-     "$CONFIG_SGI_IP22" != "n" ]; then
-    source drivers/telephony/Config.in
-fi
+if [ "$CONFIG_SGI_IP22" = "y" -o \
+     "$CONFIG_DECSTATION" = "y" -o \
+     "$CONFIG_DDB5074" = "y" ]; then
 
-if [ "$CONFIG_SGI_IP22" != "n" -a \
-     "$CONFIG_DECSTATION" != "n" ]; then
+    source drivers/telephony/Config.in
 
     mainmenu_option next_comment
     comment 'ATA/IDE/MFM/RLL support'
@@ -200,8 +198,9 @@
 fi
 endmenu
 
-if [ "$CONFIG_DECSTATION" != "n" -a \
-     "$CONFIG_SGI_IP22" != "n" ]; then
+if [ "$CONFIG_DECSTATION" = "y" -o \
+     "$CONFIG_SGI_IP22" = "y" -o \
+     "$CONFIG_DDB5074" = "y" ]; then
     source drivers/i2o/Config.in
 fi
 
@@ -268,8 +267,9 @@
    endmenu
 fi
 
-if [ "$CONFIG_DECSTATION" != "n" -a \
-     "$CONFIG_SGI_IP22" != "n" ]; then
+if [ "$CONFIG_DECSTATION" = "y" -o \
+     "$CONFIG_SGI_IP22" = "y" -o \
+     "$CONFIG_DDB5074" = "y" ]; then
    source drivers/char/Config.in
 fi
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248638 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
