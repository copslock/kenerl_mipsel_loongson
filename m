Return-Path: <SRS0=q1L1=X7=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6F1ECE58B
	for <linux-mips@archiver.kernel.org>; Sun,  6 Oct 2019 17:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84DA2173B
	for <linux-mips@archiver.kernel.org>; Sun,  6 Oct 2019 17:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383520;
	bh=9RTI3BxKAQ8c6bSqWTjG3ttwscWdlooxdIEWTE/1ib4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MI5Qryld9//0mHehkcdEHnydBvJUMWzYYCKOuBiCmgVDoMTQ9SZ9vpC0RmUEqfnlJ
	 35WMreTRuKS0/2lKigyW3BGln7eUdxqNxj6EEFgzr8CHcb7i/vEveVR+c+kNH5BSC+
	 H4XjZ/0G1WNMV422zOy6eU1lz0FjDvOzWgZ1La8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbfJFRii (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:38:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730643AbfJFRih (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 6 Oct 2019 13:38:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B277B2087E;
        Sun,  6 Oct 2019 17:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383516;
        bh=9RTI3BxKAQ8c6bSqWTjG3ttwscWdlooxdIEWTE/1ib4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IIxHuEHsaN5HOvw/8BoAF1YC5JnxgQaZv/DQTADRex9Z/ztE7LVY6+/i3bELKFuF/
         7zzPh3NMzHokUTAMkkhnMyvWWit/mWqpEYEwdEv/w9quGiE7FMGGsr8yDzeImPzynH
         xmNGcl+68BcmSYZiSA6Z8+7pcq+g1fbrjcGhdgk0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhou Yanjie <zhouyanjie@zoho.com>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org,
        ralf@linux-mips.org, paul@crapouillou.net, jhogan@kernel.org,
        malat@debian.org, tglx@linutronix.de, allison@lohutok.net,
        syq@debian.org, chenhc@lemote.com, jiaxun.yang@flygoat.com,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 090/137] MIPS: Ingenic: Disable broken BTB lookup optimization.
Date:   Sun,  6 Oct 2019 19:21:14 +0200
Message-Id: <20191006171216.329875861@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171209.403038733@linuxfoundation.org>
References: <20191006171209.403038733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Zhou Yanjie <zhouyanjie@zoho.com>

[ Upstream commit 053951dda71ecb4b554a2cdbe26f5f6f9bee9dd2 ]

In order to further reduce power consumption, the XBurst core
by default attempts to avoid branch target buffer lookups by
detecting & special casing loops. This feature will cause
BogoMIPS and lpj calculate in error. Set cp0 config7 bit 4 to
disable this feature.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: ralf@linux-mips.org
Cc: paul@crapouillou.net
Cc: jhogan@kernel.org
Cc: malat@debian.org
Cc: gregkh@linuxfoundation.org
Cc: tglx@linutronix.de
Cc: allison@lohutok.net
Cc: syq@debian.org
Cc: chenhc@lemote.com
Cc: jiaxun.yang@flygoat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/mipsregs.h | 4 ++++
 arch/mips/kernel/cpu-probe.c     | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 1e6966e8527e9..bdbdc19a2b8f8 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -689,6 +689,9 @@
 #define MIPS_CONF7_IAR		(_ULCAST_(1) << 10)
 #define MIPS_CONF7_AR		(_ULCAST_(1) << 16)
 
+/* Ingenic Config7 bits */
+#define MIPS_CONF7_BTB_LOOP_EN	(_ULCAST_(1) << 4)
+
 /* Config7 Bits specific to MIPS Technologies. */
 
 /* Performance counters implemented Per TC */
@@ -2813,6 +2816,7 @@ __BUILD_SET_C0(status)
 __BUILD_SET_C0(cause)
 __BUILD_SET_C0(config)
 __BUILD_SET_C0(config5)
+__BUILD_SET_C0(config7)
 __BUILD_SET_C0(intcontrol)
 __BUILD_SET_C0(intctl)
 __BUILD_SET_C0(srsmap)
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 9635c1db3ae6a..e654ffc1c8a0d 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1964,6 +1964,13 @@ static inline void cpu_probe_ingenic(struct cpuinfo_mips *c, unsigned int cpu)
 		c->cputype = CPU_JZRISC;
 		c->writecombine = _CACHE_UNCACHED_ACCELERATED;
 		__cpu_name[cpu] = "Ingenic JZRISC";
+		/*
+		 * The XBurst core by default attempts to avoid branch target
+		 * buffer lookups by detecting & special casing loops. This
+		 * feature will cause BogoMIPS and lpj calculate in error.
+		 * Set cp0 config7 bit 4 to disable this feature.
+		 */
+		set_c0_config7(MIPS_CONF7_BTB_LOOP_EN);
 		break;
 	default:
 		panic("Unknown Ingenic Processor ID!");
-- 
2.20.1



