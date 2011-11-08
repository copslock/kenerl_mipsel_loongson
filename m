Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2011 18:12:20 +0100 (CET)
Received: from ams-iport-3.cisco.com ([144.254.224.146]:49867 "EHLO
        ams-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903668Ab1KHRLq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Nov 2011 18:11:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=manesoni@cisco.com; l=1770; q=dns/txt;
  s=iport; t=1320772306; x=1321981906;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=RU/HfnLRMJkjGKEkq6fvLcWWLK70SnhvnKDgyAMqV90=;
  b=F0bfFlAT0/NLokImuzuLPncBGnmzNtjMkVs6wQFug5UGiOqowOFdXR76
   EkHBzJYeqHrvtLX4y6cckivLiQBAAWhCrPlp7uVBpk0ywNHCp3txX0WjB
   EoC6ZwlZFixSBM6ODL7qel2YthMCoaOrWhqO9IpUK2m4sgl40wexUYlv7
   U=;
X-IronPort-AV: E=Sophos;i="4.69,477,1315180800"; 
   d="scan'208";a="2657333"
Received: from ams-core-4.cisco.com ([144.254.72.77])
  by ams-iport-3.cisco.com with ESMTP; 08 Nov 2011 17:11:40 +0000
Received: from manesoni-ws.cisco.com ([10.65.74.254])
        by ams-core-4.cisco.com (8.14.3/8.14.3) with ESMTP id pA8HBdcu028313;
        Tue, 8 Nov 2011 17:11:39 GMT
Received: by manesoni-ws.cisco.com (Postfix, from userid 1001)
        id E26FC84D65; Tue,  8 Nov 2011 22:35:35 +0530 (IST)
Date:   Tue, 8 Nov 2011 22:35:35 +0530
From:   Maneesh Soni <manesoni@cisco.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <david.daney@cavium.com>, ananth@in.ibm.com,
        kamensky@cisco.com, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 2/4] MIPS Kprobes: Deny probes on ll/sc instructions
Message-ID: <20111108170535.GC16526@cisco.com>
Reply-To: manesoni@cisco.com
References: <20111108170336.GA16526@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20111108170336.GA16526@cisco.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 31432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manesoni@cisco.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6934


From: Maneesh Soni <manesoni@cisco.com>

Deny probes on ll/sc instructions for MIPS kprobes

As ll/sc instruction are for atomic read-modify-write operations, allowing
probes on top of these insturctions is a bad idea.

Signed-off-by: Victor Kamensky <kamensky@cisco.com>
Signed-off-by: Maneesh Soni <manesoni@cisco.com>
---
 arch/mips/kernel/kprobes.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
index 9fb1876..0ab1a5f 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -113,6 +113,30 @@ insn_ok:
 	return 0;
 }
 
+/*
+ * insn_has_ll_or_sc function checks whether instruction is ll or sc
+ * one; putting breakpoint on top of atomic ll/sc pair is bad idea;
+ * so we need to prevent it and refuse kprobes insertion for such
+ * instructions; cannot do much about breakpoint in the middle of
+ * ll/sc pair; it is upto user to avoid those places
+ */
+static int __kprobes insn_has_ll_or_sc(union mips_instruction insn)
+{
+	int ret = 0;
+
+	switch (insn.i_format.opcode) {
+	case ll_op:
+	case lld_op:
+	case sc_op:
+	case scd_op:
+		ret = 1;
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
 int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
 	union mips_instruction insn;
@@ -121,6 +145,13 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 
 	insn = p->addr[0];
 
+	if (insn_has_ll_or_sc(insn)) {
+		pr_notice("Kprobes for ll and sc instructions are not"
+			  "supported\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (insn_has_delayslot(insn)) {
 		pr_notice("Kprobes for branch and jump instructions are not"
 			  "supported\n");
-- 
1.7.1
