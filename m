Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 06:29:51 +0200 (CEST)
Received: from mail-pd0-f177.google.com ([209.85.192.177]:41980 "EHLO
        mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011987AbaJUE2rXLnES (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 06:28:47 +0200
Received: by mail-pd0-f177.google.com with SMTP id v10so491995pde.22
        for <multiple recipients>; Mon, 20 Oct 2014 21:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cHj+D0skfj5niDUOXIPAtKr2STdkwljzvnDBR/QebSc=;
        b=pANeESMwjh4u6yLZ0nypFPZGJ25g4zA5iIRMclMFFD4D+ioaOebaKjKnUJd3f/B3CG
         SyhQYTcd1Xw1YNkRLLrYFpY7wAhuWcDR8rwMBPDwYxzqgNuU7N75wmZHVpO7vAmBkhgV
         /ZcJQ2P199aORMpZOgzztQFzRIRiqzMG7XIhekPB1FqHtRDvUeDvo8BaXH+tfvwNAXBY
         a/q8/beT92YJbRIeYkkDurKagA806K0PaoARWqgB/hNFwuIYPmu9zY+pYicfq5C5rnvm
         OmPUTDVtzLZWPiBcsGw8an6uk/gddumllZhoTlQo8T0Hq59KyztraCEfRoV8YIwtSYcq
         pGyg==
X-Received: by 10.68.225.99 with SMTP id rj3mr2449401pbc.97.1413865720733;
        Mon, 20 Oct 2014 21:28:40 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id b2sm10498181pbu.42.2014.10.20.21.28.39
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 21:28:40 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        jfraser@broadcom.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Subject: [PATCH/RFC 04/17] MIPS: BMIPS: Allow BMIPS3300 to utilize SMP ebase relocation code
Date:   Mon, 20 Oct 2014 21:27:54 -0700
Message-Id: <1413865687-15255-5-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
References: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

From: Jon Fraser <jfraser@broadcom.com>

BMIPS3300 processors do not have the hardware to support SMP, but with a
small tweak, the SMP ebase relocation code allows BMIPS3300-based
platforms to reuse the S2/S3 power management code from BMIPS4380-based
chips.  Normally this is as simple as adding one line to prom_init():

    board_ebase_setup = &bmips_ebase_setup;

Signed-off-by: Jon Fraser <jfraser@broadcom.com>
Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/kernel/smp-bmips.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 8383fa4..887c3ea 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -541,6 +541,7 @@ void bmips_ebase_setup(void)
 			&bmips_smp_int_vec, 0x80);
 		__sync();
 		return;
+	case CPU_BMIPS3300:
 	case CPU_BMIPS4380:
 		/*
 		 * 0x8000_0000: reset/NMI (initially in kseg1)
-- 
2.1.1
