Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Dec 2009 14:01:59 +0100 (CET)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:45700 "EHLO
        mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493108AbZLRNBC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Dec 2009 14:01:02 +0100
Received: by yxe42 with SMTP id 42so3231727yxe.22
        for <multiple recipients>; Fri, 18 Dec 2009 05:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=rYhgtuacZzBZMZx4fEit0CfkT4ORI+0iCpOb70EK6bw=;
        b=l6AO9q3CPPOLsaw9Lfcj1DjDvxmRUJLNM6XbKWhCTOJa+zwq5G6i+NzCYZ60nmBlAq
         8aoqUif7QcLY9bglkHTMQinfwlARrY3Ag+RenGf51Hx/J+WCrYBUCDDWSAk/ZlTpiR1o
         4MFPul0dpjThqthmk/I0Mti/1Qm+cRYBVtOME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        b=jLKCM1+nRttLMHEjloYgIylFTyv59EidYTNrfPXObDbjOs63OkKD0cf8zqdhLIoZaM
         0h9C3Gr9uQdBvItduCb6+aexkJCFe70VdPbgDyBuAP+CV5l9en3Ni7XeLHEGbtMSCP4I
         MIle15Ce7ErLR3r4265EOnOLCRowaajWd3q/Y=
Received: by 10.101.190.12 with SMTP id s12mr6193586anp.31.1261141251854;
        Fri, 18 Dec 2009 05:00:51 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 15sm970131gxk.0.2009.12.18.05.00.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Dec 2009 05:00:51 -0800 (PST)
Date:   Fri, 18 Dec 2009 21:36:32 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 4/5] MIPS: remove unused powertv platform_die()
Message-Id: <20091218213632.7d5b0037.yuasa@linux-mips.org>
In-Reply-To: <20091218213346.01f63eac.yuasa@linux-mips.org>
References: <20091218212917.f42e8180.yuasa@linux-mips.org>
        <20091218213018.79a9fc11.yuasa@linux-mips.org>
        <20091218213346.01f63eac.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/powertv/powertv_setup.c |   21 ---------------------
 1 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/arch/mips/powertv/powertv_setup.c b/arch/mips/powertv/powertv_setup.c
index bd8ebf1..698b1ea 100644
--- a/arch/mips/powertv/powertv_setup.c
+++ b/arch/mips/powertv/powertv_setup.c
@@ -64,9 +64,6 @@
 #define REG_SIZE	"4"		/* In bytes */
 #endif
 
-static struct pt_regs die_regs;
-static bool have_die_regs;
-
 static void register_panic_notifier(void);
 static int panic_handler(struct notifier_block *notifier_block,
 	unsigned long event, void *cause_string);
@@ -218,24 +215,6 @@ static int panic_handler(struct notifier_block *notifier_block,
 	return NOTIFY_DONE;
 }
 
-/**
- * Platform-specific handling of oops
- * @str:	Pointer to the oops string
- * @regs:	Pointer to the oops registers
- * All we do here is to save the registers for subsequent printing through
- * the panic notifier.
- */
-void platform_die(const char *str, const struct pt_regs *regs)
-{
-	/* If we already have saved registers, don't overwrite them as they
-	 * they apply to the initial fault */
-
-	if (!have_die_regs) {
-		have_die_regs = true;
-		die_regs = *regs;
-	}
-}
-
 /* Information about the RF MAC address, if one was supplied on the
  * command line. */
 static bool have_rfmac;
-- 
1.6.5.7
