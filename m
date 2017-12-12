Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Dec 2017 11:00:21 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:37205 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992176AbdLLJ7GEdjmC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Dec 2017 10:59:06 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx4.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 12 Dec 2017 09:59:01 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 12 Dec 2017 01:59:01 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
CC:     <linux-mips@linux-mips.org>
Subject: [RFC PATCH 04/16] MIPS: Add constant accessors for CP0.Context / CP0.XContext
Date:   Tue, 12 Dec 2017 09:57:50 +0000
Message-ID: <1513072682-1371-5-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1513072682-1371-1-git-send-email-matt.redfearn@mips.com>
References: <1513072682-1371-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1513072740-298555-4532-274414-1
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187894
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

The current accessors are asm volatile meaning that the compiler cannot
optimise multiple requests for the value of these registers. Once
smp_processor_id() is switched to using these registers, this is
suboptimal. The Processor ID component of the register is constant, so
__read_const_32bit_c0_register / __read_const_64bit_c0_register can be
used to fetch the constant value and allow the compiler to optimise
multiple fetches. Barriers enforced by preempt_enable() ensure a re-read
of the register after preemption, when the running CPU may have changed.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/include/asm/mipsregs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 24d3028ba76d..67682acf8284 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1478,6 +1478,7 @@ do {									\
 #define read_c0_globalnumber()	__read_32bit_c0_register($3, 1)
 
 #define read_c0_context()	__read_ulong_c0_register($4, 0)
+#define read_const_c0_context()	__read_const_ulong_c0_register($4, 0)
 #define write_c0_context(val)	__write_ulong_c0_register($4, 0, val)
 
 #define read_c0_contextconfig()		__read_32bit_c0_register($4, 1)
@@ -1628,6 +1629,7 @@ do {									\
 #define write_c0_watchhi7(val)	__write_32bit_c0_register($19, 7, val)
 
 #define read_c0_xcontext()	__read_ulong_c0_register($20, 0)
+#define read_const_c0_xcontext()	__read_const_ulong_c0_register($20, 0)
 #define write_c0_xcontext(val)	__write_ulong_c0_register($20, 0, val)
 
 #define read_c0_intcontrol()	__read_32bit_c0_ctrl_register($20)
-- 
2.7.4
