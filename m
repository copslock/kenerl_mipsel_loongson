Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Oct 2015 20:45:11 +0200 (CEST)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33986 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010574AbbJSSpJK1xcu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Oct 2015 20:45:09 +0200
Received: by padhk11 with SMTP id hk11so37144052pad.1
        for <linux-mips@linux-mips.org>; Mon, 19 Oct 2015 11:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=pEnHXuylnhavUateqUYZ3RmEQ623wcbpPnkG+B7DZQU=;
        b=P1++WAoLxPCSkz3XcjQD6V7Q+VUSN0gV8df+ReZkDFA+GTK+KBs33zzi5fmYE1INIh
         cZtgA+ga+NvgndVFr9ofKbRHzFqDsOcDCEqcNyyXwFYAtEJKXjPbnC787pRoOTz5u0LM
         lIZ20ssMtSkOEoPPLac1wyBvg9olCxCyp6ZZCF9Y7geoaV8txIZTsStIbs5Q6mS+SjJM
         VE1o4oEI/vomRCCVyAwmmI1EG5j6TfZ77h3b6j88mh47cN6HQ3yC/DW9S0AC+8g69U4W
         HqL+hw6gWoWF6szhKoW/eNb6mGzaAa/jmDZF45OLsrZLz+NzZUnPHpyHan3ak69w1ERE
         BIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pEnHXuylnhavUateqUYZ3RmEQ623wcbpPnkG+B7DZQU=;
        b=H2Mu5Mg7lxNmMfbMQFXvvUqyP3VBZsK/s0ta2lfpUnIG8NUFCSHcRQmOMUaxgVU9bc
         15qNBGuXOhJlvA0mYDhQcAvDHc5B4tbNrHS/55ugXunJYtJ4h94AG5Ti7msIXPYvns3M
         rehNbfJ0wKYz/xCaTDWX3eVAQdyW3CKmpRUPVCw1CQoJRBlnCRmzaN6JNEl7ebGy+pPg
         sc2/agHvcsDq1Xl59kfU9ZKFU16gzMi4tDaQVBYgKeLYWbBg1Eo6P1Zwgut651IJz34e
         DGCBR6NBBPbBEmO67bF07H8MoqUnh/x87OXfSgqed5abYaWNyDylt7ub/uLA4cuXFpxL
         1gDw==
X-Gm-Message-State: ALoCoQkXiiWDZyxCGVPdBad2eGzUptdJDpIz5Rzg2by2NJp5lVVa9WTKFaJrQHcJZtW7uk+lirLV
X-Received: by 10.68.227.7 with SMTP id rw7mr5952704pbc.18.1445280302700;
        Mon, 19 Oct 2015 11:45:02 -0700 (PDT)
Received: from slapshot.mtv.corp.google.com ([172.27.88.51])
        by smtp.gmail.com with ESMTPSA id c4sm7771515pat.46.2015.10.19.11.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Oct 2015 11:45:01 -0700 (PDT)
From:   Petri Gynther <pgynther@google.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, f.fainelli@gmail.com, cernekee@gmail.com,
        Petri Gynther <pgynther@google.com>
Subject: [PATCH] MIPS: switch BMIPS5000 to use r4k_wait_irqoff()
Date:   Mon, 19 Oct 2015 11:44:24 -0700
Message-Id: <1445280264-42016-1-git-send-email-pgynther@google.com>
X-Mailer: git-send-email 2.6.0.rc2.230.g3dd15c0
Return-Path: <pgynther@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pgynther@google.com
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

BCM7425 CPU Interface Zephyr Processor, pages 5-309 and 5-310
BCM7428B0 CPU Interface Zephyr Processor, pages 5-337 and 5-338

WAIT instruction:
Thread enters wait state. No instructions are executed until an
interrupt occurs. The processor's clocks are stopped if both threads
are in idle mode.

Description:
Execution of this instruction puts the thread into wait state, an idle
mode in which no instructions are fetched or executed. The thread remains
in wait state until an interrupt occurs that is not masked by the
interrupt mask field in the Status register. Then, if interrupts are
enabled by the IE bit in the Status register, the interrupt is serviced.
The ERET instruction returns to the instruction following the WAIT
instruction. If interrupts are disabled, the processor resumes executing
instructions with the next sequential instruction.

Programming notes:
The WAIT instruction should be executed while interrupts are disabled
by the IE bit in the Status register. This avoids a potential timing
hazard, which occurs if an interrupt is taken between testing the counter
and executing the WAIT instruction. In this hazard case, the interrupt
will have been completed before the WAIT instruction is executed, so
the processor will remain indefinitely in wait state until the next
interrupt.

Signed-off-by: Petri Gynther <pgynther@google.com>
---
 arch/mips/kernel/idle.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index ab1478d..d636c70 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -160,7 +160,6 @@ void __init check_wait(void)
 	case CPU_BMIPS3300:
 	case CPU_BMIPS4350:
 	case CPU_BMIPS4380:
-	case CPU_BMIPS5000:
 	case CPU_CAVIUM_OCTEON:
 	case CPU_CAVIUM_OCTEON_PLUS:
 	case CPU_CAVIUM_OCTEON2:
@@ -171,7 +170,9 @@ void __init check_wait(void)
 	case CPU_XLP:
 		cpu_wait = r4k_wait;
 		break;
-
+	case CPU_BMIPS5000:
+		cpu_wait = r4k_wait_irqoff;
+		break;
 	case CPU_RM7000:
 		cpu_wait = rm7k_wait_irqoff;
 		break;
-- 
2.6.0.rc2.230.g3dd15c0
