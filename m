Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Apr 2006 00:27:32 +0100 (BST)
Received: from mail8.fw-sd.sony.com ([160.33.66.75]:8352 "EHLO
	mail8.fw-sd.sony.com") by ftp.linux-mips.org with ESMTP
	id S8133715AbWDNX1V (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 15 Apr 2006 00:27:21 +0100
Received: from mail3.sjc.in.sel.sony.com (mail3.sjc.in.sel.sony.com [43.134.1.211])
	by mail8.fw-sd.sony.com (8.12.11/8.12.11) with ESMTP id k3ENdHfp010566;
	Fri, 14 Apr 2006 23:39:17 GMT
Received: from [192.168.1.10] ([43.134.85.105])
	by mail3.sjc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id k3ENdHSC015891;
	Fri, 14 Apr 2006 23:39:17 GMT
Message-ID: <444032A5.3030304@am.sony.com>
Date:	Fri, 14 Apr 2006 16:39:17 -0700
From:	Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org
CC:	"Levand, Geoffrey" <Geoffrey.Levand@am.sony.com>,
	linux-mips@linux-mips.org
Subject: Re: tx49 Ether problems
References: <20060415.010518.126141918.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060415.010518.126141918.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <geoffrey.levand@am.sony.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoffrey.levand@am.sony.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Fri, 14 Apr 2006 08:38:00 -0700, Geoff Levand
> <geoffrey.levand@am.sony.com> wrote:
>> I seem to get a lot of problems with an nfs root fs
>> on tx4937 board.  I haven't looked at it closely yet,
>> but I guess its some problem with the ne2000 driver.
>> I wanted to know if you know anything about this.
> 
> Please look at:
> 
> http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20060226.23054
> 1.75185772.anemo%40mba.ocn.ne.jp
> 
> With a quick glance of ne.c, it seems ei_status.stop_page should be
> changed to 0x60 on the board.  Please confirm its value.
> 

Yes, this seems to fix the problem.


-Geoff

Index: 2.6.16.1/drivers/net/ne.c
===================================================================
--- 2.6.16.1.orig/drivers/net/ne.c	2006-04-14 15:54:41.000000000 -0700
+++ 2.6.16.1/drivers/net/ne.c	2006-04-14 16:27:51.000000000 -0700
@@ -140,7 +140,8 @@
 #define NE1SM_START_PG	0x20	/* First page of TX buffer */
 #define NE1SM_STOP_PG 	0x40	/* Last page +1 of RX ring */
 #define NESM_START_PG	0x40	/* First page of TX buffer */
-#define NESM_STOP_PG	0x80	/* Last page +1 of RX ring */
+#define NESM_8_STOP_PG	0x60	/* Last page +1 of RX ring, RTL8019 8 bit mode */
+#define NESM_STOP_PG	0x80	/* Last page +1 of RX ring */

 #if defined(CONFIG_PLAT_MAPPI)
 #  define DCR_VAL 0x4b
@@ -516,6 +517,7 @@
 	ei_status.tx_start_page = start_page;
 	ei_status.stop_page = stop_page;
 #if defined(CONFIG_TOSHIBA_RBTX4927) || defined(CONFIG_TOSHIBA_RBTX4938)
+	ei_status.stop_page = NESM_8_STOP_PG;
 	wordlength = 1;
 #endif
