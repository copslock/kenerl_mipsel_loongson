Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jul 2017 21:29:35 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:37318 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994841AbdGYTWAPtpEn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jul 2017 21:22:00 +0200
Received: from localhost (rrcs-64-183-28-114.west.biz.rr.com [64.183.28.114])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2AB985A9;
        Tue, 25 Jul 2017 19:21:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.9 087/125] MIPS: Fix MIPS I ISA /proc/cpuinfo reporting
Date:   Tue, 25 Jul 2017 12:20:02 -0700
Message-Id: <20170725192019.071324043@linuxfoundation.org>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170725192014.314851996@linuxfoundation.org>
References: <20170725192014.314851996@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@linux-mips.org>

commit e5f5a5b06e51a36f6ddf31a4a485358263953a3d upstream.

Correct a commit 515a6393dbac ("MIPS: kernel: proc: Add MIPS R6 support
to /proc/cpuinfo") regression that caused MIPS I systems to show no ISA
levels supported in /proc/cpuinfo, e.g.:

system type		: Digital DECstation 2100/3100
machine			: Unknown
processor		: 0
cpu model		: R3000 V2.0  FPU V2.0
BogoMIPS		: 10.69
wait instruction	: no
microsecond timers	: no
tlb_entries		: 64
extra interrupt vector	: no
hardware watchpoint	: no
isa			:
ASEs implemented	:
shadow register sets	: 1
kscratch registers	: 0
package			: 0
core			: 0
VCED exceptions		: not available
VCEI exceptions		: not available

and similarly exclude `mips1' from the ISA list for any processors below
MIPSr1.  This is because the condition to show `mips1' on has been made
`cpu_has_mips_r1' rather than newly-introduced `cpu_has_mips_1'.  Use
the correct condition then.

Fixes: 515a6393dbac ("MIPS: kernel: proc: Add MIPS R6 support to /proc/cpuinfo")
Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16758/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/proc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -83,7 +83,7 @@ static int show_cpuinfo(struct seq_file
 	}
 
 	seq_printf(m, "isa\t\t\t:"); 
-	if (cpu_has_mips_r1)
+	if (cpu_has_mips_1)
 		seq_printf(m, " mips1");
 	if (cpu_has_mips_2)
 		seq_printf(m, "%s", " mips2");
