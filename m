Return-Path: <SRS0=Dbp0=OW=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C170C67873
	for <linux-mips@archiver.kernel.org>; Thu, 13 Dec 2018 09:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6682087F
	for <linux-mips@archiver.kernel.org>; Thu, 13 Dec 2018 09:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h4lx10TU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6682087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbeLMJIp (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:08:45 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44624 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbeLMJIo (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 13 Dec 2018 04:08:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id t13so745016pgr.11
        for <linux-mips@vger.kernel.org>; Thu, 13 Dec 2018 01:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ebvja7ppkTsEwfDofOxrBD+NfckjZ0iQFP4vJ8R1TQI=;
        b=h4lx10TUdlrChEdu0MXS85znwBmk5v0MRQmTPnFhnmeFduQK02TziYBx2ZslzT28bV
         qjpVTOHxSApyY5r1bOFSlDndAKUkOrrc0SLr+TbBynGQRiuNbwZLsUCpOqPYMD7CF1Xf
         QBnjZIhUBZA4uZtE8H+D72PgUDBfEamx7j2eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ebvja7ppkTsEwfDofOxrBD+NfckjZ0iQFP4vJ8R1TQI=;
        b=cLUfO21kdohPJEtEi8RphiVd/5eBWFbPjMBSCLbdsKLFEkYKYI6NDnH8Xf39OK7Zfs
         Q/2xDK39SfgM5v96tlhQ0pt+4Rz07Wxm5ydFR6LH0WyiY/1IOcXMQRfuezJn1FZmUG3V
         VL0qLhk8NPAEJZS8TQCP5FTXw5gAXKh0nx6rnBqlTyR5fJy6iLjmQZTkPqouVZX9uu1a
         O4lgiYF+bv+GwQOL0mvYPl6YxBMWWMhZS2hhNWJsAOtq7binfkbxFMmmU8r4Bd2vr3B5
         hKq8TiMsto2yed856NO6NLxYCxPEwbO3owbBZbUaz7EI+56hykbAuDXU+yWps3YNS1mS
         RvUA==
X-Gm-Message-State: AA+aEWan29uDJvKuKrv3uKKm88HHlGWEhaIwpbA6DmyCh057nv0SSfBt
        0n3J1UJk9zaA+EtIzjX46Af73o8HVVI=
X-Google-Smtp-Source: AFSGD/UjO3/QgoJ8eWigG4vmxKOwB7gsz2kofsORubjuGc41N6CNQOhcz3uxVVGHvvWQ4CuYwPNvDA==
X-Received: by 2002:a63:de04:: with SMTP id f4mr20796162pgg.292.1544692124018;
        Thu, 13 Dec 2018 01:08:44 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id m11sm1650533pgh.51.2018.12.13.01.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 01:08:43 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v5 5/7] mips: remove syscall table entries
Date:   Thu, 13 Dec 2018 14:37:37 +0530
Message-Id: <1544692059-9728-6-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544692059-9728-1-git-send-email-firoz.khan@linaro.org>
References: <1544692059-9728-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The config flag - CONFIG_MIPS_MT_FPAFF uses to check whether which
syscall entries need to be used in scall32-o32.S file.

One of the patch in this patch series will generate syscall table
file. But CONFIG_MIPS_MT_FPAFF flag will add more complexity in the
script to generate the syscall table file.

In order to come up with a common implementation across all archit-
ecture, we need to remove mipsmt_sys_sched_setaffinity and mipsmt-
_sys_sched_getaffinity from the table and define it in other way.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/mips/kernel/scall32-o32.S | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 10f6367..43fa5cd 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -205,6 +205,18 @@ einval: li	v0, -ENOSYS
 	jr	ra
 	END(sys_syscall)
 
+#ifdef CONFIG_MIPS_MT_FPAFF
+	/*
+	 * For FPU affinity scheduling on MIPS MT processors, we need to
+	 * intercept sys_sched_xxxaffinity() calls until we get a proper hook
+	 * in kernel/sched/core.c.  Considered only temporary we only support
+	 * these hooks for the 32-bit kernel - there is no MIPS64 MT processor
+	 * atm.
+	 */
+#define sys_sched_setaffinity	mipsmt_sys_sched_setaffinity
+#define sys_sched_getaffinity	mipsmt_sys_sched_getaffinity
+#endif /* CONFIG_MIPS_MT_FPAFF */
+
 	.align	2
 	.type	sys_call_table, @object
 EXPORT(sys_call_table)
@@ -447,20 +459,8 @@ EXPORT(sys_call_table)
 	PTR	sys_tkill
 	PTR	sys_sendfile64
 	PTR	sys_futex
-#ifdef CONFIG_MIPS_MT_FPAFF
-	/*
-	 * For FPU affinity scheduling on MIPS MT processors, we need to
-	 * intercept sys_sched_xxxaffinity() calls until we get a proper hook
-	 * in kernel/sched/core.c.  Considered only temporary we only support
-	 * these hooks for the 32-bit kernel - there is no MIPS64 MT processor
-	 * atm.
-	 */
-	PTR	mipsmt_sys_sched_setaffinity
-	PTR	mipsmt_sys_sched_getaffinity
-#else
 	PTR	sys_sched_setaffinity
 	PTR	sys_sched_getaffinity		/* 4240 */
-#endif /* CONFIG_MIPS_MT_FPAFF */
 	PTR	sys_io_setup
 	PTR	sys_io_destroy
 	PTR	sys_io_getevents
-- 
1.9.1

