Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2018 19:07:18 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:57734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994727AbeFERHKF8Zgk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Jun 2018 19:07:10 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 348022087E;
        Tue,  5 Jun 2018 17:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528218423;
        bh=i86ZTg5EMBRmXX6N1VLQ2j9rmZYbb/lUw4L1uYOgQbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eOcar6ExywSVUxZdsO6wUspIDe7bbgixTUV1FEKZ7TnBABmQ/pwHbdEtnzn0TQm+f
         TL8Utq3RpCKH6p8BUClhdEWECi9+hAlyhWuJQL2Uai3+2bJdlPOo5zw2GWO5e7FQCs
         gTeeKblMPM75QKgbZ5YbKVs6QCg5uC10rmYb0dSY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.9 49/61] MIPS: ptrace: Fix PTRACE_PEEKUSR requests for 64-bit FGRs
Date:   Tue,  5 Jun 2018 19:02:10 +0200
Message-Id: <20180605170120.823768977@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170117.643936916@linuxfoundation.org>
References: <20180605170117.643936916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <SRS0=vjBF=IX=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64195
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

From: Maciej W. Rozycki <macro@mips.com>

commit c7e814628df65f424fe197dde73bfc67e4a244d7 upstream.

Use 64-bit accesses for 64-bit floating-point general registers with
PTRACE_PEEKUSR, removing the truncation of their upper halves in the
FR=1 mode, caused by commit bbd426f542cb ("MIPS: Simplify FP context
access"), which inadvertently switched them to using 32-bit accesses.

The PTRACE_POKEUSR side is fine as it's never been broken and continues
using 64-bit accesses.

Fixes: bbd426f542cb ("MIPS: Simplify FP context access")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.15+
Patchwork: https://patchwork.linux-mips.org/patch/19334/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/ptrace.c   |    2 +-
 arch/mips/kernel/ptrace32.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -838,7 +838,7 @@ long arch_ptrace(struct task_struct *chi
 				break;
 			}
 #endif
-			tmp = get_fpr32(&fregs[addr - FPR_BASE], 0);
+			tmp = get_fpr64(&fregs[addr - FPR_BASE], 0);
 			break;
 		case PC:
 			tmp = regs->cp0_epc;
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -107,7 +107,7 @@ long compat_arch_ptrace(struct task_stru
 						addr & 1);
 				break;
 			}
-			tmp = get_fpr32(&fregs[addr - FPR_BASE], 0);
+			tmp = get_fpr64(&fregs[addr - FPR_BASE], 0);
 			break;
 		case PC:
 			tmp = regs->cp0_epc;
