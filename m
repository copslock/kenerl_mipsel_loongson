Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2017 23:26:20 +0200 (CEST)
Received: from mail-oi0-x242.google.com ([IPv6:2607:f8b0:4003:c06::242]:33114
        "EHLO mail-oi0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992800AbdHIV0Kd8U-N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Aug 2017 23:26:10 +0200
Received: by mail-oi0-x242.google.com with SMTP id e124so6901544oig.0;
        Wed, 09 Aug 2017 14:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=CUIqMIvUifdnAC1bvkTAUf5wLVAEt3ekf6TriBO/hM4=;
        b=p03NF1CU/H0bnz4hppoTADBcbb0fzMM1q4X7Fs2WyHlJzpDb64hFZX5KXTXPv2dUw2
         nV1iY6pu2GooM2mKTBfcwlC6WqGrlTX+g6mNdH0uNk3QsTyJemfJz24iEDEqdD3AP1FB
         Gwk9JaHq+/ou3ItI+k+nl0lJhCrSpql3mytFU/4///ToB0tkGi4ElG6DYNaZFZsmMuz+
         qjdw70dpjv1ipDjyD4uC9v9niBy+c01NtfAhjrNNM8RQal11N3lpOMTNg2k/fsPYs/TP
         p/GZ5rZTH6NP4d0tUakBLMLJiDq3xyAcb6MoJ7we8p4zTpoj+v8S+35KotTTZUll+Mjf
         hg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=CUIqMIvUifdnAC1bvkTAUf5wLVAEt3ekf6TriBO/hM4=;
        b=TDapjc3KiXxo5YZL4l0ejm+IH0DzgwMhldZEbAExfdGRJR6FvWoz7Ar3U4LSc0iyQ5
         XD9BJmwYxNW8iqMZWCJisjo1aOZqPjq212XTbkIy/nRFflpm3X22DEy5TmaeFKUJitaO
         6EnEJ3824akWG7N34gmOkGDalbeA04Y1jVJNUK/GagpBIBe9vY0Flo7vsByZ/RAsYN8n
         tjuTM6nPfenM8P9lbl57O9MtZc0//X6aMVXCK0fHQN+ybx5nkSoij5jJyJOSwu6skNcT
         eIEYLSfHYmY2H2kIUsjnQ0GJearC7didkCxwNyq5bMgfNPPH64b5IB7WcWRzeZsgWIwP
         E3fg==
X-Gm-Message-State: AHYfb5hdlGlk9SUB7tdupyFHpYYti0fVRu+ziCIuQTqIX7SxIGwkNBFZ
        Ujfytqa60FdXQih7jwY=
X-Received: by 10.202.190.4 with SMTP id o4mr9646713oif.122.1502313964220;
        Wed, 09 Aug 2017 14:26:04 -0700 (PDT)
Received: from serve.minyard.net ([47.184.154.34])
        by smtp.gmail.com with ESMTPSA id p63sm5876199oie.8.2017.08.09.14.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Aug 2017 14:26:02 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPA id 7EF6D329;
        Wed,  9 Aug 2017 16:26:01 -0500 (CDT)
Received: by t430.minyard.net (Postfix, from userid 1000)
        id B4EF2300A65; Wed,  9 Aug 2017 16:26:00 -0500 (CDT)
From:   minyard@acm.org
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Corey Minyard <cminyard@mvista.com>
Subject: [PATCH] mips: Fix using smp_processor_id() when preemptible
Date:   Wed,  9 Aug 2017 16:25:50 -0500
Message-Id: <1502313950-725-1-git-send-email-minyard@acm.org>
X-Mailer: git-send-email 2.7.4
Return-Path: <tcminyard@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: minyard@acm.org
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

From: Corey Minyard <cminyard@mvista.com>

I was getting the following:

BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
caller is pcibios_set_cache_line_size+0x10/0x58

pcibios_set_cache_line_size() used current_cpu_data outside of
an unpreemptible context.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 arch/mips/pci/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index bd67ac7..afd2f8a 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -28,9 +28,11 @@ EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
 
 static int __init pcibios_set_cache_line_size(void)
 {
-	struct cpuinfo_mips *c = &current_cpu_data;
+	struct cpuinfo_mips *c;
 	unsigned int lsize;
 
+	preempt_disable();
+	c = &current_cpu_data;
 	/*
 	 * Set PCI cacheline size to that of the highest level in the
 	 * cache hierarchy.
@@ -38,6 +40,7 @@ static int __init pcibios_set_cache_line_size(void)
 	lsize = c->dcache.linesz;
 	lsize = c->scache.linesz ? : lsize;
 	lsize = c->tcache.linesz ? : lsize;
+	preempt_enable();
 
 	BUG_ON(!lsize);
 
-- 
2.7.4
