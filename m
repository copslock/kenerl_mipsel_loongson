Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Apr 2006 09:06:03 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:15843 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133719AbWDQIFo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Apr 2006 09:05:44 +0100
Received: (qmail 10798 invoked from network); 16 Apr 2006 22:53:59 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 16 Apr 2006 22:53:59 -0000
Message-ID: <444291E9.2070407@ru.mvista.com>
Date:	Sun, 16 Apr 2006 22:50:17 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Geoff Levand <geoffrey.levand@am.sony.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org
Subject: Re: tx49 Ether problems
References: <20060415.010518.126141918.anemo@mba.ocn.ne.jp> <444032A5.3030304@am.sony.com> <44415D17.1070005@ru.mvista.com>
In-Reply-To: <44415D17.1070005@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------010205010502030804020507"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------010205010502030804020507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

Sergei Shtylyov wrote:

>>> On Fri, 14 Apr 2006 08:38:00 -0700, Geoff Levand
>>> <geoffrey.levand@am.sony.com> wrote:

>>>> I seem to get a lot of problems with an nfs root fs
>>>> on tx4937 board.  I haven't looked at it closely yet,
>>>> but I guess its some problem with the ne2000 driver.
>>>> I wanted to know if you know anything about this.

>>> Please look at:

>>> http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20060226.23054
>>> 1.75185772.anemo%40mba.ocn.ne.jp

>>> With a quick glance of ne.c, it seems ei_status.stop_page should be
>>> changed to 0x60 on the board.  Please confirm its value.

     Hm, all this is very, very strange -- SAPROM readback indicates 16-bit DCR
is set to 0x49 by the driver which means 16-bit mode but RTL8019's data bus on
Toshiba RBTX4938 board is 8-bit according to its manual. In 16-bit mode
stop_page value of 0x80 is legitimate, and I haven't heard of any problems so
far (until Geoff's report). However, even in 16-bit mode, 8-bit data I/O only
works (which is enforced by that late #if override below), and if I force
8-bit mode from the very beginning, everything works again -- I guess the
RTL8019AS chip senses the correct slot size at reset, and just ignores DCR.WTS
bit then. BUT, if I force NE1SM_START_PG and NE1SM_STOP_PG to be used as the
values start_page and stop_page, the driver doesn't work. RTL8019AS has 16 KB
of SRAM, so I guess they're mapped at address 0x4000 insternally, and the
start_page should be 0x40 indeed.
     I've also found out that SAPROM bytes 6..15 (after removing the
duplicates) contain the string "RBTX4938BB" which can be used for recognition
instead of the first 3 bytes of the Ethernet address.

>> Yes, this seems to fix the problem.

>> Index: 2.6.16.1/drivers/net/ne.c
>> ===================================================================
>> --- 2.6.16.1.orig/drivers/net/ne.c    2006-04-14 15:54:41.000000000 -0700
>> +++ 2.6.16.1/drivers/net/ne.c    2006-04-14 16:27:51.000000000 -0700
>> @@ -140,7 +140,8 @@
>>  #define NE1SM_START_PG    0x20    /* First page of TX buffer */
>>  #define NE1SM_STOP_PG     0x40    /* Last page +1 of RX ring */
>>  #define NESM_START_PG    0x40    /* First page of TX buffer */
>> -#define NESM_STOP_PG    0x80    /* Last page +1 of RX ring */
>> +#define NESM_8_STOP_PG    0x60    /* Last page +1 of RX ring, RTL8019 
>> 8 bit mode */
>> +#define NESM_STOP_PG    0x80    /* Last page +1 of RX ring */
>>
>>  #if defined(CONFIG_PLAT_MAPPI)
>>  #  define DCR_VAL 0x4b
>> @@ -516,6 +517,7 @@
>>      ei_status.tx_start_page = start_page;
>>      ei_status.stop_page = stop_page;
>>  #if defined(CONFIG_TOSHIBA_RBTX4927) || defined(CONFIG_TOSHIBA_RBTX4938)
>> +    ei_status.stop_page = NESM_8_STOP_PG;
>>      wordlength = 1;
>>  #endif
> 
> 
>    This is really strange place for that #ifdef -- 'wordlength' is 
> determined much earlier in this function (and stop_page is set to 0x40 
> for 8-bit case), shouldn't #ifdef be moved instead?

     What I think we actually need is more generic fix for RTL8019AS, not the
board specific hacks -- if this RX ring stop page value limitation *really*
needs to be enforced.

    I've cooked up a patch, please try it...

WBR, Sergei


--------------010205010502030804020507
Content-Type: text/plain;
 name="RTL8019AS-8bit-PSTOP-limitation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="RTL8019AS-8bit-PSTOP-limitation.patch"

diff --git a/drivers/net/ne.c b/drivers/net/ne.c
index 08b218c..04b396b 100644
--- a/drivers/net/ne.c
+++ b/drivers/net/ne.c
@@ -139,7 +139,8 @@ bad_clone_list[] __initdata = {
 
 #if defined(CONFIG_PLAT_MAPPI)
 #  define DCR_VAL 0x4b
-#elif defined(CONFIG_PLAT_OAKS32R)
+#elif defined(CONFIG_PLAT_OAKS32R)  || \
+   defined(CONFIG_TOSHIBA_RBTX4927) || defined(CONFIG_TOSHIBA_RBTX4938)
 #  define DCR_VAL 0x48
 #else
 #  define DCR_VAL 0x49
@@ -396,7 +397,13 @@ static int __init ne_probe1(struct net_d
 		/* We must set the 8390 for word mode. */
 		outb_p(DCR_VAL, ioaddr + EN0_DCFG);
 		start_page = NESM_START_PG;
-		stop_page = NESM_STOP_PG;
+
+		if (!(DCR_VAL & 0x01) &&
+		    inb(ioaddr + EN0_RCNTLO) == 0x50 &&
+		    inb(ioaddr + EN0_RCNTHI) == 0x70)
+			stop_page = 0x60;
+		else
+			stop_page = NESM_STOP_PG;
 	} else {
 		start_page = NE1SM_START_PG;
 		stop_page = NE1SM_STOP_PG;
@@ -509,15 +516,8 @@ static int __init ne_probe1(struct net_d
 	ei_status.name = name;
 	ei_status.tx_start_page = start_page;
 	ei_status.stop_page = stop_page;
-#if defined(CONFIG_TOSHIBA_RBTX4927) || defined(CONFIG_TOSHIBA_RBTX4938)
-	wordlength = 1;
-#endif
 
-#ifdef CONFIG_PLAT_OAKS32R
-	ei_status.word16 = 0;
-#else
-	ei_status.word16 = (wordlength == 2);
-#endif
+	ei_status.word16 = ((DCR_VAL & 0x01) && wordlength == 2);
 
 	ei_status.rx_start_page = start_page + TX_PAGES;
 #ifdef PACKETBUF_MEMSIZE


--------------010205010502030804020507--
