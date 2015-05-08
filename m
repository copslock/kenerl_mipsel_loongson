Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2015 16:12:46 +0200 (CEST)
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35603 "EHLO
        mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026553AbbEHOMoYbwio (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 May 2015 16:12:44 +0200
Received: by igbyr2 with SMTP id yr2so21832955igb.0;
        Fri, 08 May 2015 07:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=aiB8gQn4Ajv2cyQ/v5E70ej+C9Vg+NX2yMujtJgDVTc=;
        b=N+RvswqR3qEEBWQFCHP9Da3Px/0a5CoVFYjgFrNkYNFqe9YESdCmJ6bViPRDEVlrQq
         EOaC8y9LxmkgEC+JvlWG12JtaMOjKN66XC1776g6xRAK5gPed7QRxX83xNxzHOPs8A9V
         HaC+Be2tbhM3aKdASFzBOwGlATXJh2posOuuqI+u/yIiG4CVy+zs9WZv5aTRG1G2BhH+
         zi1EUXYFyaJd5wuegb3arOO5ikocFokjQd8GSEhB8GIab2lvlc1TMup/un6t9evn2YEl
         fTRLBuRkguv5zJJLlzbyT+OUOaoHxBfqRbKTm0UyB4G4feDBVOtsEjoU0D6radgkKnhg
         a3mQ==
X-Received: by 10.50.114.35 with SMTP id jd3mr4628058igb.14.1431094360631;
        Fri, 08 May 2015 07:12:40 -0700 (PDT)
Received: from nick-System-Product-Name.hitronhub.home (CPEbc4dfb2691f3-CMbc4dfb2691f0.cpe.net.cable.rogers.com. [99.231.110.121])
        by mx.google.com with ESMTPSA id 10sm3508487ioh.44.2015.05.08.07.12.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 May 2015 07:12:39 -0700 (PDT)
From:   Nicholas Krause <xerofoify@gmail.com>
To:     ralf@linux-mips.org
Cc:     chenhc@lemote.com, andreas.herrmann@caviumnetworks.com,
        rusty@rustcorp.com.au, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mips:Remove unneeded duplicate declaration of cpu_callin_map in smp.h
Date:   Fri,  8 May 2015 10:12:35 -0400
Message-Id: <1431094355-28145-1-git-send-email-xerofoify@gmail.com>
X-Mailer: git-send-email 2.1.4
Return-Path: <xerofoify@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xerofoify@gmail.com
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

This removes the unneeded duplicate declaration of cpu_callin_map
in smp.h due to use already declaring it in the file,smp.c that
already uses it internally for functions required this variable
for their various internal work.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 arch/mips/include/asm/smp.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index bb02fac..7752011 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -45,8 +45,6 @@ extern int __cpu_logical_map[NR_CPUS];
 #define SMP_DUMP		0x8
 #define SMP_ASK_C0COUNT		0x10
 
-extern volatile cpumask_t cpu_callin_map;
-
 /* Mask of CPUs which are currently definitely operating coherently */
 extern cpumask_t cpu_coherent_mask;
 
-- 
2.1.4
