Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jun 2018 07:51:35 +0200 (CEST)
Received: from mail-pl0-x241.google.com ([IPv6:2607:f8b0:400e:c01::241]:34847
        "EHLO mail-pl0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994552AbeFHFv1MoMAH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Jun 2018 07:51:27 +0200
Received: by mail-pl0-x241.google.com with SMTP id i5-v6so7618677plt.2
        for <linux-mips@linux-mips.org>; Thu, 07 Jun 2018 22:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=we2piHi7dcdfzEZ+YYDL/tHGMos3Un/e/bcbwr11dbk=;
        b=sw4Plc4VR9YzZy3nao0KesQ3E2N2aIVDKU4zpabO84RbSBR4q9JMv3LHMskb0VpFMa
         M/7Sah/kSKFDtZLcYUBIgnYjrQZJ7d31/QSSQtoEc/vXN6UxgJPNIN6AA8j2Du88Pf5P
         xV5qO/pGX8H/CpxlUotJxTiLZ2q6a9COwvcbS1hYDQ23eytZwHty832VcRSXmVwrfWrD
         WpDkMLprMFCR9u1nyDe8d9K1M+gXXoXw8SBivswVWRqcDUUp6GnrhtCdlU21v3n9jMcF
         SkK04Swv5j9QnZiG2gYid5eaHiB4BwB6hD7y2zU3O7R0AOCKlORMIeWbcMj+odJ4cTv2
         2Ibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=we2piHi7dcdfzEZ+YYDL/tHGMos3Un/e/bcbwr11dbk=;
        b=sg9sMALyShcxPYAXSQp8pmrZMegpEcV6zHEFmeURlXuHgKehHy4Zzki6gKPEDwkcD9
         Y0Lu19sNN+O6U04ZFkFO12kjhA1gw8EARhQPcYPvYk0WTSLfTsgxbUGBPXSl2ZcRV1Mi
         GsFU4bJmPQaPv7T3pbdQMRDk74HBPbwQ62457d9Qb5ptqr4NT7nBfiAodDn/7IUQwA+M
         XXDMJRQOMtaE6OrwXnr83B/MMGziht0azzRHwMH8kTGK7s+Y0l324gx311U81OXJU9B9
         HI1KL1I6y5q7c69mDWk4vWzm+PxPYmcGzo0pKtzZl0B/74WYe3VuoLymdpAcdWdM09we
         JQyQ==
X-Gm-Message-State: APt69E1/juE+iXFbtRoHbu6jm79wwnTFgLqAXudfFZ3mEn/5JIX81SPZ
        pCrBtuAlsga4gvjAzKfufj+ctcu0aeo=
X-Google-Smtp-Source: ADUXVKJhPq86QhaXxI2pj9I+XKG1xWPGCGLDD7ZNziSjTdutWFEHiLay+zfflzaGsPrSGnIJryKDxQ==
X-Received: by 2002:a17:902:3303:: with SMTP id a3-v6mr5065041plc.209.1528437080678;
        Thu, 07 Jun 2018 22:51:20 -0700 (PDT)
Received: from localhost.localdomain ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id u9-v6sm106922500pfi.60.2018.06.07.22.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 22:51:19 -0700 (PDT)
From:   r@hev.cc
To:     linux-mips@linux-mips.org, paul.burton@mips.com
Cc:     jhogan@kernel.org, ralf@linux-mips.org, Heiher <r@hev.cc>
Subject: [PATCH] MIPS: Fix ejtag handler on SMP
Date:   Fri,  8 Jun 2018 13:51:09 +0800
Message-Id: <20180608055109.828-1-r@hev.cc>
X-Mailer: git-send-email 2.17.1
Return-Path: <r@hev.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64213
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
 arch/mips/kernel/genex.S | 46 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 37b9383eacd3..3804afd878f8 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -354,16 +354,56 @@ NESTED(ejtag_debug_handler, PT_SIZE, sp)
 	sll	k0, k0, 30	# Check for SDBBP.
 	bgez	k0, ejtag_return
 
+#ifdef CONFIG_SMP
+1:	PTR_LA	k0, ejtag_debug_buffer_spinlock
+	ll	k0, 0(k0)
+	bnez	k0, 1b
+	PTR_LA	k0, ejtag_debug_buffer_spinlock
+	sc	k0, 0(k0)
+	beqz	k0, 1b
+# ifdef CONFIG_WEAK_REORDERING_BEYOND_LLSC
+	sync
+# endif
+
+	PTR_LA	k0, ejtag_debug_buffer
+	LONG_S	k1, 0(k0)
+
+	mfc0	k1, CP0_EBASE
+	andi	k1, MIPS_EBASE_CPUNUM
+	PTR_SLL	k1, LONGLOG
+	PTR_LA	k0, ejtag_debug_buffer_per_cpu
+	PTR_ADDU k0, k1
+
+	PTR_LA	k1, ejtag_debug_buffer
+	LONG_L	k1, 0(k1)
+	LONG_S	k1, 0(k0)
+
+	PTR_LA	k0, ejtag_debug_buffer_spinlock
+	sw	zero, 0(k0)
+#else
 	PTR_LA	k0, ejtag_debug_buffer
 	LONG_S	k1, 0(k0)
+#endif
+
 	SAVE_ALL
 	move	a0, sp
 	jal	ejtag_exception_handler
 	RESTORE_ALL
+
+#ifdef CONFIG_SMP
+	mfc0	k1, CP0_EBASE
+	andi	k1, MIPS_EBASE_CPUNUM
+	PTR_SLL	k1, LONGLOG
+	PTR_LA	k0, ejtag_debug_buffer_per_cpu
+	PTR_ADDU k0, k1
+	LONG_L	k1, 0(k0)
+#else
 	PTR_LA	k0, ejtag_debug_buffer
 	LONG_L	k1, 0(k0)
+#endif
 
 ejtag_return:
+	back_to_back_c0_hazard
 	MFC0	k0, CP0_DESAVE
 	.set	mips32
 	deret
@@ -377,6 +417,12 @@ ejtag_return:
 	.data
 EXPORT(ejtag_debug_buffer)
 	.fill	LONGSIZE
+#ifdef CONFIG_SMP
+EXPORT(ejtag_debug_buffer_spinlock)
+	.fill	LONGSIZE
+EXPORT(ejtag_debug_buffer_per_cpu)
+	.fill	LONGSIZE * NR_CPUS
+#endif
 	.previous
 
 	__INIT
-- 
2.17.1
