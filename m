Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Aug 2011 17:55:51 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47706 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491765Ab1HDPzG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Aug 2011 17:55:06 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p74Ft5uE006546
        for <linux-mips@linux-mips.org>; Thu, 4 Aug 2011 16:55:05 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p74Ft5Ix006545
        for linux-mips@linux-mips.org; Thu, 4 Aug 2011 16:55:05 +0100
Resent-From: Ralf Baechle <ralf@linux-mips.org>
Resent-Date: Thu, 4 Aug 2011 16:55:05 +0100
Resent-Message-ID: <20110804155505.GD5297@linux-mips.org>
Resent-To: linux-mips@linux-mips.org
Received: from mail-wy0-f177.google.com ([74.125.82.177]:57964 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491189Ab1HDOzz (ORCPT
        <rfc822;ralf@linux-mips.org>); Thu, 4 Aug 2011 16:55:55 +0200
Received: by wyg19 with SMTP id 19so1227597wyg.36
        for <ralf@linux-mips.org>; Thu, 04 Aug 2011 07:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=DRZP8Y5NpM6BfMJC3QwvTNV5SuEcFV8pw4Icf2XUt9M=;
        b=p8xmCMG/9Bk8i7cfYbzY2IUuepk3xIPZhbqZ2T1+IOA9GLZBRxcXK9vj1z+lpG0905
         qCr+VqlP3ystsobe2hY21FN+Wwli/7si/G1ivgiA56/JjTCnBYQrHsMiXELD4AoWzogO
         xFWr6BBCMnkJVRJmsPQk9iKu17DcIQBlLApQc=
MIME-Version: 1.0
Received: by 10.216.80.14 with SMTP id j14mr966826wee.9.1312469749772; Thu, 04
 Aug 2011 07:55:49 -0700 (PDT)
Received: by 10.216.46.136 with HTTP; Thu, 4 Aug 2011 07:55:49 -0700 (PDT)
Date:   Thu, 4 Aug 2011 22:55:49 +0800
Message-ID: <CAJd=RBDv1wsdVYmwdtr2BGOCuya1eKg4PeWeggPbz5u_5545ig@mail.gmail.com>
Subject: [RFC patch] MIPS/netlogic: dont setup boot CPU twice
From:   Hillf Danton <dhillf@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 30838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3442

When do smp setup, check for boot CPU is added, then it is impossible to be
initialized twice.

Signed-off-by: Hillf Danton <dhillf@gmail.com>
---
 arch/mips/netlogic/xlr/smp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/netlogic/xlr/smp.c b/arch/mips/netlogic/xlr/smp.c
index b495a7f..e6f8c62 100644
--- a/arch/mips/netlogic/xlr/smp.c
+++ b/arch/mips/netlogic/xlr/smp.c
@@ -167,6 +167,8 @@ void __init nlm_smp_setup(void)

 	num_cpus = 1;
 	for (i = 0; i < NR_CPUS; i++) {
+		if (i == boot_cpu)
+			continue;
 		if (nlm_cpu_ready[i]) {
 			cpu_set(i, phys_cpu_present_map);
 			__cpu_number_map[i] = num_cpus;
