Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Dec 2005 20:38:28 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:59860 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S3458260AbVLHUiC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Dec 2005 20:38:02 +0000
Received: (qmail 19969 invoked from network); 8 Dec 2005 20:37:53 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 8 Dec 2005 20:37:53 -0000
Message-ID: <43989A2C.9020006@ru.mvista.com>
Date:	Thu, 08 Dec 2005 23:40:12 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Jordan Crouse <jordan.crouse@amd.com>
Subject: Re: [PATCH] Enable DBAu1550 soft-off
References: <1133342401.24526.25.camel@localhost.localdomain> <43988FA6.5080209@ru.mvista.com> <439897FC.5050008@ru.mvista.com>
In-Reply-To: <439897FC.5050008@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------070202070007000808060508"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------070202070007000808060508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello, I wrote.

>> Matej Kupljen wrote:
>>
>>> Hi
>>>
>>> Please, find the attached patch which enables
>>> powering off the DBAU1200 board.
>>
>>
>>
>>     As a follow up to this one, here's the patch which does the same 
>> thing for
>> DBAu1550 by just reusing Pb1550 code. I added #else because #if 
>> renders the
>> rest of the au1000_halt() code unreachable on DBAu1550/PB1550 anyway.

> 
>    Failed to chenge the subject to a proper one. :-/

     And forgot about sign-off line. :-(

> WBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

--------------070202070007000808060508
Content-Type: text/plain;
 name="DBAu1550-soft-off.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="DBAu1550-soft-off.patch"

diff --git a/arch/mips/au1000/common/reset.c b/arch/mips/au1000/common/reset.c
index 65b84db..8a4afdc 100644
--- a/arch/mips/au1000/common/reset.c
+++ b/arch/mips/au1000/common/reset.c
@@ -164,13 +164,13 @@ void au1000_restart(char *command)
 
 void au1000_halt(void)
 {
-#if defined(CONFIG_MIPS_PB1550)
+#if defined(CONFIG_MIPS_PB1550) || defined(CONFIG_MIPS_DB1550)
 	/* power off system */
-	printk("\n** Powering off Pb1550\n");
+	printk("\n** Powering off...\n");
 	au_writew(au_readw(0xAF00001C) | (3<<14), 0xAF00001C);
 	au_sync();
 	while(1); /* should not get here */
-#endif
+#else
 	printk(KERN_NOTICE "\n** You can safely turn off the power\n");
 #ifdef CONFIG_MIPS_MIRAGE
 	au_writel((1 << 26) | (1 << 10), GPIO2_OUTPUT);
@@ -187,6 +187,7 @@ void au1000_halt(void)
 	                "wait\n\t"
 			".set\tmips0");
 #endif
+#endif /* defined(CONFIG_MIPS_PB1550) || defined(CONFIG_MIPS_DB1550) */
 }
 
 void au1000_power_off(void)


--------------070202070007000808060508--
