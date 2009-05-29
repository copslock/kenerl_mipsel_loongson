Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 May 2009 14:29:46 +0100 (BST)
Received: from mx1.emlix.com ([193.175.82.87]:50634 "EHLO mx1.emlix.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20024660AbZE2N3i (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 May 2009 14:29:38 +0100
Received: from gate.emlix.com ([193.175.27.217]:52814 helo=mailer.emlix.com)
	by mx1.emlix.com with esmtp (Exim 4.63)
	(envelope-from <sb@emlix.com>)
	id 1MA29R-0005fY-4p; Fri, 29 May 2009 15:29:37 +0200
Received: by mailer.emlix.com
	id 1MA29R-0004Gd-Mr; Fri, 29 May 2009 15:29:37 +0200
Message-ID: <4A1FE338.5010802@emlix.com>
Date:	Fri, 29 May 2009 15:29:28 +0200
From:	Simon Braunschmidt <sb@emlix.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
MIME-Version: 1.0
To:	wuzhangjin@gmail.com
CC:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [loongson-PATCH-v1 16/27] Add Siliconmotion 712 framebuffer driver
References: <cover.1242855716.git.wuzhangjin@gmail.com> <ad533255eec0400e4fed72671c0865472dd68d02.1242855716.git.wuzhangjin@gmail.com>
In-Reply-To: <ad533255eec0400e4fed72671c0865472dd68d02.1242855716.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Organization: emlix gmbh, Goettingen, Germany
Return-Path: <sb@emlix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sb@emlix.com
Precedence: bulk
X-list: linux-mips

Hi Wu Zhangjin

I applied your patch cleanly and run it on a i486SX (little endian) 
embedded computing board.

This provides a huge performance benefit compared to vesa framebuffer, 
so thanks a lot for the contribution.

I tested it in both the library-accelerated (cfb...) and hardware 
accelerated codepaths, with no problems. Tested with qt-embedded 4.5.1.

As i have seen lots of functionality are guarded by
#ifdef __BIG_ENDIAN

Is there a way to setup a different mode than 1024x600 on 
kernel-commandline or from userspace, e.g. with fbset?

What I currently do is
picking appropriate values form the table VGAMode in smtcfb.h and 
hardcoding them.

I tried 800x600x16bit@60hz, which worked also, but 1024x768x24bit@60hz 
left me with a corrupted display output (distored colors, missing 
regions), i did not check further wheter it also crashed.

I dont know wheter i am subscribed and this will make it through to lkml 
and linux-mips, feel free to cite me if you want.

Also if you want you may add my

Tested-by: Simon Braunschmidt <sbraun@emlix.com>


see also attached a patch for the debug messages



 From addec9a5a27512621c538a2f799e31e07720cb9c Mon Sep 17 00:00:00 2001
From: Simon Braunschmidt <sbraun@emlix.com>
Date: Fri, 29 May 2009 15:03:51 +0200
Subject: [PATCH] [video] fix debug messages in smtcfb

when defining #DEBUG
---
  drivers/video/smi/smtcfb.c |    6 ++++--
  1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/smi/smtcfb.c b/drivers/video/smi/smtcfb.c
index 33ce878..ebc6371 100644
--- a/drivers/video/smi/smtcfb.c
+++ b/drivers/video/smi/smtcfb.c
@@ -44,6 +44,8 @@
  #include "smtcfb.h"
  #include "smtc2d.h"

+#define DEBUG
+
  #ifdef DEBUG
  #define smdbg(format, arg...)  printk(KERN_DEBUG format , ## arg)
  #else
@@ -1087,7 +1089,7 @@ static int __init sm712be_setup(char *options)
         sm712be_flag = 0;
         if (!options || !*options) {
                 retval = 1;
-               smdbg("\n No sm712be parameter\n", __LINE__);
+               smdbg("\n No sm712be parameter\n");
         }
         if (!retval && strstr(options, "enable"))
                 sm712be_flag = 1;
@@ -1113,7 +1115,7 @@ static int __init sm712vga_setup(char *options)

         if (!options || !*options) {
                 retval = 1;
-               smdbg("\n No vga parameter\n", __LINE__);
+               smdbg("\n No vga parameter\n");
         }

         screen_info.lfb_width = 0;
--
1.6.3.rc0.1.gf800
