Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Feb 2015 23:53:08 +0100 (CET)
Received: from mail-ie0-f172.google.com ([209.85.223.172]:39399 "EHLO
        mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006930AbbBWWxHTa-Yv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Feb 2015 23:53:07 +0100
Received: by iecvy18 with SMTP id vy18so27488669iec.6;
        Mon, 23 Feb 2015 14:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=LObSXMPJe7TaIocVDT1qbyB2HaV6KbFxoeCjETRrECE=;
        b=PNSqivHD+wz9mZoivx9ZgFeU/8VP892Gjdk9eeOd3cGHJrMSI/mK0Dig2ayFTnXYXc
         8VK0kigKsDxfk0ZW8YXH+fZRamopDdPUcYLg1W/HUuJiVXDCIhrHi4gVsso0CfFJ2IUn
         qzOZpmpOhJv95Z+LCiAPpFvF5+3YZkg4Jwm2aSxZV19u7h0fuc0gcJ0nC4YGU5JSXOfh
         pNb3h7GTiDI7BLM9USzWCIdo/PJkh+v13s3YAIijN3OtMhzizeaiB2O2a89ntnq4huXm
         9xY25r7syflfXWzTLqCmKszwpelJQ9ntQSkKBLQZoVnKWrim5iYdeAavOaZXZyiRi49R
         Cb7w==
X-Received: by 10.107.36.9 with SMTP id k9mr17419631iok.2.1424731981816;
        Mon, 23 Feb 2015 14:53:01 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id b1sm6959902igl.7.2015.02.23.14.53.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 23 Feb 2015 14:53:01 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id t1NMqxqD027959;
        Mon, 23 Feb 2015 14:52:59 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id t1NMqw5M027958;
        Mon, 23 Feb 2015 14:52:58 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH] Revert "MIPS: mm: tlbex: Use cpu_has_mips_r2_exec_hazard for the EHB instruction"
Date:   Mon, 23 Feb 2015 14:52:54 -0800
Message-Id: <1424731974-27926-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

This reverts commit 77f3ee59ee7cfe19e0ee48d9a990c7967fbfcbed.

There are two problems:

1) It breaks OCTEON, which will now crash in early boot with:

  Kernel panic - not syncing: No TLB refill handler yet (CPU type: 80)

2) The logic is broken.

The meaning of cpu_has_mips_r2_exec_hazard is that the EHB instruction
is required.  The offending patch attempts (and fails) to change the
meaning to be that EHB is part of the ISA.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/mm/tlbex.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index d75ff73..ff8d99c 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -501,7 +501,7 @@ static void build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case tlb_indexed: tlbw = uasm_i_tlbwi; break;
 	}
 
-	if (cpu_has_mips_r2_exec_hazard) {
+	if (cpu_has_mips_r2) {
 		/*
 		 * The architecture spec says an ehb is required here,
 		 * but a number of cores do not have the hazard and
@@ -1953,7 +1953,7 @@ static void build_r4000_tlb_load_handler(void)
 
 		switch (current_cpu_type()) {
 		default:
-			if (cpu_has_mips_r2_exec_hazard) {
+			if (cpu_has_mips_r2) {
 				uasm_i_ehb(&p);
 
 		case CPU_CAVIUM_OCTEON:
@@ -2020,7 +2020,7 @@ static void build_r4000_tlb_load_handler(void)
 
 		switch (current_cpu_type()) {
 		default:
-			if (cpu_has_mips_r2_exec_hazard) {
+			if (cpu_has_mips_r2) {
 				uasm_i_ehb(&p);
 
 		case CPU_CAVIUM_OCTEON:
-- 
1.7.11.7
