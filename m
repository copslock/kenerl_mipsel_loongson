Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Apr 2018 13:41:29 +0200 (CEST)
Received: from mail-pl0-x242.google.com ([IPv6:2607:f8b0:400e:c01::242]:39542
        "EHLO mail-pl0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993599AbeDCLlVMIHkq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Apr 2018 13:41:21 +0200
Received: by mail-pl0-x242.google.com with SMTP id s24-v6so8389996plq.6
        for <linux-mips@linux-mips.org>; Tue, 03 Apr 2018 04:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=3o/QEl6ozECTzmRjQJVStP81SYAM7/HDBSfiRqucTlE=;
        b=xlaAI7lr0kd1bHE24/THcDhlpr28XsxGbiknymoQ+EQPzlJmYz5laMLOrPOBA7qMoH
         r01l/VaVp/BTvZyQyWzZxgWRAYTPeewJLCum3xI3gd5lF6780mUAWbWT5FgD5WVeNdWU
         /pA6h/d2pibwM0yNdptjsgJ/2hj+YtHOSIAbqKzxYK94C0dOAvaAd9cGcpJ8CyFikeZn
         GAA2yAF3zLdcs36NFwa25nYGuIPYKUMT//6CGu7n4Vz97K1dlaAcAtxro29pSmMeTSAr
         HRAq0TgA5H6CoTj/v3FJnQgSu0R0rRgme4Ap3EH/vfL0e6VM9I5X89HovOwsYJF9sSC+
         xKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3o/QEl6ozECTzmRjQJVStP81SYAM7/HDBSfiRqucTlE=;
        b=e4Db99xRqDp33DRxXikMghnc6KzbnrJl/m1Kvm1qYtso14DzSChnYqZGy9MrPbYgz8
         7Pg4CUkYV+7HxLMKD2AbKSiahjN3Aek3E87pPrYS+0BgwxrQMiqmqYftGs+vjPSkPgcQ
         coW9h2Seh/KXmOHDWgLcC31lVQX/2P7r4uetmWkfjTzvAfYx3pPVRKr4vqAzQKOPlFQl
         1SYepFdPxHKnntCa9xwB3nzyuXpn64Z1a/MqYS5jVxGfTcBK4yPmGcpMr0eDOzbhfCoS
         Fy3+EkEg8IwZ8IglgoUyz3ifHXnTWtTYEr/3mCfxrPtRuP+0irFXdA/mWxyRtGjzeY31
         vmtA==
X-Gm-Message-State: AElRT7H+CxEyddd/0GXnNdiymYa5pg2GNiwLGBTz+EgsqdwWRa24uSvb
        Mwmk1xqqqOWdvCMR1aUb4CactrwDilE=
X-Google-Smtp-Source: AIpwx4+H55GqAbgKx1QkZN9qo01kIQJDYN5Fj5m55FmIPSkenHouVwncDAR8ARu3hsfjE5xMkHMmFA==
X-Received: by 10.98.223.16 with SMTP id u16mr10337541pfg.146.1522755674560;
        Tue, 03 Apr 2018 04:41:14 -0700 (PDT)
Received: from localhost.localdomain ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id f64sm5148947pfa.154.2018.04.03.04.41.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Apr 2018 04:41:13 -0700 (PDT)
From:   r@hev.cc
To:     linux-mips@linux-mips.org, jhogan@kernel.org, ralf@linux-mips.org
Cc:     Heiher <r@hev.cc>
Subject: [PATCH v2] MIPS: Fix ejtag handler on SMP
Date:   Tue,  3 Apr 2018 19:41:02 +0800
Message-Id: <20180403114102.10700-1-r@hev.cc>
X-Mailer: git-send-email 2.16.3
Return-Path: <r@hev.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r@hev.cc
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: Heiher <r@hev.cc>

On SMP systems, the shared ejtag debug buffer may be overwritten by
other cores, because every cores can generate ejtag exception at
same time.

Unfortunately, in that context, it's difficult to relax more registers
to access per cpu buffers. so use ll/sc to serialize the access.

Signed-off-by: Heiher <r@hev.cc>
---
 arch/mips/kernel/genex.S | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 37b9383eacd3..1af8c83835ef 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -354,6 +354,16 @@ NESTED(ejtag_debug_handler, PT_SIZE, sp)
 	sll	k0, k0, 30	# Check for SDBBP.
 	bgez	k0, ejtag_return
 
+#ifdef CONFIG_SMP
+	PTR_LA	k0, ejtag_debug_buffer
+1:	ll	k0, LONGSIZE(k0)
+	bnez	k0, 1b
+	PTR_LA	k0, ejtag_debug_buffer
+	sc	k0, LONGSIZE(k0)
+	beqz	k0, 1b
+	sync
+#endif
+
 	PTR_LA	k0, ejtag_debug_buffer
 	LONG_S	k1, 0(k0)
 	SAVE_ALL
@@ -363,7 +373,12 @@ NESTED(ejtag_debug_handler, PT_SIZE, sp)
 	PTR_LA	k0, ejtag_debug_buffer
 	LONG_L	k1, 0(k0)
 
+#ifdef CONFIG_SMP
+	sw	zero, LONGSIZE(k0)
+#endif
+
 ejtag_return:
+	back_to_back_c0_hazard
 	MFC0	k0, CP0_DESAVE
 	.set	mips32
 	deret
@@ -377,6 +392,9 @@ ejtag_return:
 	.data
 EXPORT(ejtag_debug_buffer)
 	.fill	LONGSIZE
+#ifdef CONFIG_SMP
+	.fill	LONGSIZE
+#endif
 	.previous
 
 	__INIT
-- 
2.16.3
