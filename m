Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2003 08:12:40 +0000 (GMT)
Received: from pasmtp.tele.dk ([IPv6:::ffff:193.162.159.95]:37390 "EHLO
	pasmtp.tele.dk") by linux-mips.org with ESMTP id <S8225072AbTCRIMk>;
	Tue, 18 Mar 2003 08:12:40 +0000
Received: from ekner.info (0x83a4a968.virnxx10.adsl-dhcp.tele.dk [131.164.169.104])
	by pasmtp.tele.dk (Postfix) with ESMTP id A1571B5F8
	for <linux-mips@linux-mips.org>; Tue, 18 Mar 2003 09:12:30 +0100 (CET)
Message-ID: <3E76D5FC.323C0C74@ekner.info>
Date: Tue, 18 Mar 2003 09:17:00 +0100
From: Hartvig Ekner <hartvig@ekner.info>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-19.7.x i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Patch to make Db1500 Audio codec recognized
Content-Type: multipart/mixed;
 boundary="------------B342AF166B0D036F4D1E2481"
Return-Path: <hartvig@ekner.info>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvig@ekner.info
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------B342AF166B0D036F4D1E2481
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

A small patch to make the AMD Db1500 Audio codec correctly recognized.

/Hartvig



--------------B342AF166B0D036F4D1E2481
Content-Type: text/plain; charset=us-ascii;
 name="ac97_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ac97_patch"

Index: ac97_codec.c
===================================================================
RCS file: /home/cvs/linux/drivers/sound/Attic/ac97_codec.c,v
retrieving revision 1.18.2.4
diff -u -r1.18.2.4 ac97_codec.c
--- ac97_codec.c	25 Feb 2003 22:03:09 -0000	1.18.2.4
+++ ac97_codec.c	18 Mar 2003 08:10:53 -0000
@@ -153,6 +153,7 @@
 	{0x83847608, "SigmaTel STAC9708",	&sigmatel_9708_ops},
 	{0x83847609, "SigmaTel STAC9721/23",	&sigmatel_9721_ops},
 	{0x83847644, "SigmaTel STAC9744/45",	&sigmatel_9744_ops},
+	{0x83847652, "SigmaTel STAC9752/53",	&default_ops},
 	{0x83847656, "SigmaTel STAC9756/57",	&sigmatel_9744_ops},
 	{0x83847666, "SigmaTel STAC9750T",	&sigmatel_9744_ops},
 	{0x83847684, "SigmaTel STAC9783/84?",	&null_ops},

--------------B342AF166B0D036F4D1E2481--
