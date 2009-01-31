Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Jan 2009 11:23:44 +0000 (GMT)
Received: from mail-ew0-f17.google.com ([209.85.219.17]:58321 "EHLO
	mail-ew0-f17.google.com") by ftp.linux-mips.org with ESMTP
	id S21102789AbZAaLXl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 31 Jan 2009 11:23:41 +0000
Received: by ewy10 with SMTP id 10so1115908ewy.0
        for <multiple recipients>; Sat, 31 Jan 2009 03:23:35 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=2LmWa81v45+zbl7nWPX72nrrJcGdVg8P5kR+eKzfaTE=;
        b=iRvdkcTTPj4eRqmzBhmHdmA4WVT7Jsd3X43ZelYxRyfl8Tbvr+1+ZfQjAVd7xIYLCd
         VzkKNamjTTxuAYdOEg6pa8c1OC8k1lnFMN5CkyVEDtiEeK00BIbat0kZwHaLolaKlTfQ
         j9vhhE+oxDyZoBHBXbkW8BQVp8SHlY6OgRrN0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=XmMPkwj+Wqr4X+GGcuKKH/FUo3sVqDLtobv28tT8dfVcq6hFkW/zEXGR05ma6JugQS
         phEnLthKNzg+kaYkdLCa4HYLnxxLkm4Ge3XPyenqCoz0UhrnRpMRfTA+WBFIoYUlnPCP
         A9Qdo++zIqUB2RrnbHsB6VbvSI71rWjwSZfV4=
Received: by 10.210.38.5 with SMTP id l5mr2472605ebl.108.1233401015236;
        Sat, 31 Jan 2009 03:23:35 -0800 (PST)
Received: from ?192.168.1.115? (d133062.upc-d.chello.nl [213.46.133.62])
        by mx.google.com with ESMTPS id k5sm5724456nfh.52.2009.01.31.03.23.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jan 2009 03:23:34 -0800 (PST)
Message-ID: <498434B6.5020409@gmail.com>
Date:	Sat, 31 Jan 2009 12:23:34 +0100
From:	Roel Kluin <roel.kluin@gmail.com>
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
MIME-Version: 1.0
To:	mano@roarinelk.homelinux.net, ralf@linux-mips.org
CC:	linux-mips@linux-mips.org
Subject: [PATCH] MIPS: in plat_time_init() t reaches -1, tested: 0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <roel.kluin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: roel.kluin@gmail.com
Precedence: bulk
X-list: linux-mips

With a postfix decrement t reaches -1 rather than 0,
so the fall-back will not occur.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
index 3288014..0b5681a 100644
--- a/arch/mips/alchemy/common/time.c
+++ b/arch/mips/alchemy/common/time.c
@@ -118,7 +118,7 @@ void __init plat_time_init(void)
 	 * setup counter 1 (RTC) to tick at full speed
 	 */
 	t = 0xffffff;
-	while ((au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_T1S) && t--)
+	while ((au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_T1S) && --t)
 		asm volatile ("nop");
 	if (!t)
 		goto cntr_err;
@@ -127,7 +127,7 @@ void __init plat_time_init(void)
 	au_sync();
 
 	t = 0xffffff;
-	while ((au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C1S) && t--)
+	while ((au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C1S) && --t)
 		asm volatile ("nop");
 	if (!t)
 		goto cntr_err;
@@ -135,7 +135,7 @@ void __init plat_time_init(void)
 	au_sync();
 
 	t = 0xffffff;
-	while ((au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C1S) && t--)
+	while ((au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C1S) && --t)
 		asm volatile ("nop");
 	if (!t)
 		goto cntr_err;
