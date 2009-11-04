Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2009 10:05:43 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:59763 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492615AbZKDJFX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Nov 2009 10:05:23 +0100
Received: by mail-pw0-f45.google.com with SMTP id 11so3158630pwi.24
        for <multiple recipients>; Wed, 04 Nov 2009 01:05:22 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=AcQ4R5dJlFioqnmx7cLQvs7Sq5EDkZx7sGAVCLDY3zc=;
        b=hLGy3ZV7LBOnEJCi5PWy9fFDPS0ICZzonP0uOCPExeJAygYs6002hc1LvVK3e1rt/o
         T/6syzaQ4N5Tdvirwac3RfIIdACzCqUWGN1bC7cLXZx1tLfxiVNXaRNiu9nzIZuDGduj
         zidouvYPOANHIiWfgYZHDs9YN7Rns3G4YELuA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OHSqVRYFdLyc6X87mlEIpcx+jur6oHZxOaGJ5gZ1lFI8qnFiDt8vDd3D+5arhy7VNr
         RqpFOb4x7Y/2kI2KOHVPHW8AM4tINocSC7zWGAlEQXG2oA410+nnrVlGvrDnppL/9DZ4
         gYS9e3AqYxDPCGlneGr7s/5T6ca9/A2qDzafg=
Received: by 10.114.162.5 with SMTP id k5mr1681715wae.10.1257325522596;
        Wed, 04 Nov 2009 01:05:22 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm498158pzk.9.2009.11.04.01.05.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 01:05:22 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
	LKML <linux-kernel@vger.kernel.org>, huhb@lemote.com,
	yanh@lemote.com, Zhang Le <r0bertz@gentoo.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>, zhangfx@lemote.com,
	liujl@lemote.com
Subject: [PATCH -queue v0 2/6] [loongson] oprofile: avoid do_IRQ for perfcounter when the interrupt is from bonito
Date:	Wed,  4 Nov 2009 17:05:08 +0800
Message-Id: <061879e220036f930cd1cf5a6d22fca4d2be255c.1257325319.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1257325319.git.wuzhangjin@gmail.com>
References: <cover.1257325319.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

In loongson2f, the IP6 is shared by bonito and perfcounter, we need to
avoid do_IRQ for perfcounter when the interrupt is from bonito. This
patch does it.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/oprofile/op_model_loongson2.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/oprofile/op_model_loongson2.c b/arch/mips/oprofile/op_model_loongson2.c
index 575cd14..08d4b09 100644
--- a/arch/mips/oprofile/op_model_loongson2.c
+++ b/arch/mips/oprofile/op_model_loongson2.c
@@ -125,6 +125,9 @@ static irqreturn_t loongson2_perfcount_handler(int irq, void *dev_id)
 	 */
 
 	/* Check whether the irq belongs to me */
+	enabled = read_c0_perfcnt() & LOONGSON2_PERFCNT_INT_EN;
+	if (!enabled)
+		return IRQ_NONE;
 	enabled = reg.cnt1_enabled | reg.cnt2_enabled;
 	if (!enabled)
 		return IRQ_NONE;
-- 
1.6.2.1
