Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 18:19:59 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:45790 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133463AbWAYSTk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jan 2006 18:19:40 +0000
Received: (qmail 19630 invoked from network); 25 Jan 2006 18:23:58 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 25 Jan 2006 18:23:58 -0000
Message-ID: <43D7C2FE.2090407@ru.mvista.com>
Date:	Wed, 25 Jan 2006 21:27:10 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux MIPS <linux-mips@linux-mips.org>
CC:	ralf@linux-mips.org, Jordan Crouse <jordan.crouse@amd.com>
Subject: [PATCH] Au1xx0: really set KSEG0 to uncached on reboot
Content-Type: multipart/mixed;
 boundary="------------040002010409020106000103"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------040002010409020106000103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

     Resending with signoffs...

     Just found really old buglet in AMD Au1xx0 restart code: instead of
modifying the whole CP0 Config.K0 field to 010b (meaning KSEG0 uncached)
before flushing the caches and resetting a board, it only sets bit 1 of that
reg. which is effectively a NOP since Config.K0 == 011b as the kernel sets it
up (which is also its default value for Au1xx0).

WBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------040002010409020106000103
Content-Type: text/plain;
 name="Au1xx0-make-KSEG0-uncached-on-reboot.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Au1xx0-make-KSEG0-uncached-on-reboot.patch"

diff --git a/arch/mips/au1000/common/reset.c b/arch/mips/au1000/common/reset.c
index 65b84db..4ffcced 100644
--- a/arch/mips/au1000/common/reset.c
+++ b/arch/mips/au1000/common/reset.c
@@ -151,7 +151,7 @@ void au1000_restart(char *command)
 	}
 
 	set_c0_status(ST0_BEV | ST0_ERL);
-	set_c0_config(CONF_CM_UNCACHED);
+	change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
 	flush_cache_all();
 	write_c0_wired(0);
 



--------------040002010409020106000103--
