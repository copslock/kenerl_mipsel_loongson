Return-Path: <SRS0=x683=O4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80417C43612
	for <linux-mips@archiver.kernel.org>; Wed, 19 Dec 2018 07:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8CB21841
	for <linux-mips@archiver.kernel.org>; Wed, 19 Dec 2018 07:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C28J8VmB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbeLSHIL (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:08:11 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53601 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbeLSHIK (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 19 Dec 2018 02:08:10 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so4952613wmb.3
        for <linux-mips@vger.kernel.org>; Tue, 18 Dec 2018 23:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p0CjUopsqbZR0PDGZ2K6Ilo52CtrbZ2loe+iqvdso7Q=;
        b=C28J8VmBNhtdIbOAyBplrFQOaSLpUeSKXg+/OGuYMTUxQ7e069lBIlZlZD9qHZtkK8
         WX/KeOis9E6Va0tbGwuoQ0375SG8+xTcxaltyCJ040jfyEzIHA+F0iacmXDFaG8tPhPD
         UA3zXrT1dyrV1e0y6mNfUuccYaedgjd8KFrcfiCpAZdPM8qD2DWVV891Wi3lV8oKgCAK
         V2B6YtGG5/1dtwrAVqEgLnw/JIaQiU1CQeBxn00AMPWInHX+XsvOPns0f0MqGYDOdg34
         aezfKhxS2y10YSJqBSkwyiN7ySX3MExyBihQdcpQ8lYyHOl+Tm1i0eDB5WPvwiY3odwo
         pkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p0CjUopsqbZR0PDGZ2K6Ilo52CtrbZ2loe+iqvdso7Q=;
        b=hxZNDVh/fnW6us8RLYOFmexzLtjz/HVuithTrNpmKlE70F8A3tvyaQcXlEnxme2b9I
         BBw+5euVhKq1c1s+VWCV2DOGx90V1wJG5h7gWaQupkEt1kUU9bMW4wzHBaKNOHhlFjX6
         +06hcIueBfXuPSvkTQcMCCBqNipQD4g5E3sApuloF1NPiFjk67O9/qvJlNKamQ3xzXRj
         jLsjO2i2vIOnxeoLQWb/y1Xko1n49yfBMTTJKLjyc38fNwWw499jYmYZSFabgDv5m57w
         QZl7hZsqdv7DGAGwVCyi28FRUhoJkWgRiN30zKH7bVswd2Aw5kT39uOpJkP7fLkNVB+I
         5UGw==
X-Gm-Message-State: AA+aEWZZWNVTkZUwHtGFYMeIpbY/SWpWL3DbHEO88inc42N9UFd5djzy
        +tbx4YSh4IMrFD/UUOrNQ8m6GAGF
X-Google-Smtp-Source: AFSGD/XeBpmTo3iz77hC86cVeFSs+n6U2rdtHeyN6s0Qzoyo/yAusDgtmCNvsnayL/9IBC+BZJNc4g==
X-Received: by 2002:a1c:dc86:: with SMTP id t128mr6290258wmg.42.1545203288422;
        Tue, 18 Dec 2018 23:08:08 -0800 (PST)
Received: from flagship2.speedport.ip (p200300C20BD333581B9ECEB655B1C7D2.dip0.t-ipconnect.de. [2003:c2:bd3:3358:1b9e:ceb6:55b1:c7d2])
        by smtp.gmail.com with ESMTPSA id s16sm3245724wrt.77.2018.12.18.23.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 23:08:08 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@vger.kernel.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 4/5] MIPS: Alchemy: update cpu-feature-overrides
Date:   Wed, 19 Dec 2018 08:08:02 +0100
Message-Id: <20181219070803.449981-5-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181219070803.449981-1-manuel.lauss@gmail.com>
References: <20181219070803.449981-1-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

No shiny new stuff for Alchemy.

Tested on DB1300 and DB1500.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h b/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
index f439cf9cf9d1..ecfbb5aeada3 100644
--- a/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
@@ -75,10 +75,12 @@
 #define cpu_dcache_line_size()		32
 #define cpu_icache_line_size()		32
 #define cpu_scache_line_size()		0
+#define cpu_tcache_line_size()		0
 
 #define cpu_has_perf_cntr_intr_bit	0
 #define cpu_has_vz			0
 #define cpu_has_msa			0
+#define cpu_has_ufr			0
 #define cpu_has_fre			0
 #define cpu_has_cdmm			0
 #define cpu_has_small_pages		0
@@ -88,5 +90,6 @@
 #define cpu_has_badinstr		0
 #define cpu_has_badinstrp		0
 #define cpu_has_contextconfig		0
+#define cpu_has_perf			0
 
 #endif /* __ASM_MACH_AU1X00_CPU_FEATURE_OVERRIDES_H */
-- 
2.20.0

