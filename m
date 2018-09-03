Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2018 19:38:36 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:39488 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994248AbeICRicfBTjO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Sep 2018 19:38:32 +0200
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A9780BAE;
        Mon,  3 Sep 2018 17:38:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@mips.com>,
        Paul Burton <paul.burton@mips.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-fsdevel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 4.18 099/123] MIPS: Correct the 64-bit DSP accumulator register size
Date:   Mon,  3 Sep 2018 18:57:23 +0200
Message-Id: <20180903165723.697586429@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65911
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

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@mips.com>

commit f5958b4cf4fc38ed4583ab83fb7c4cd1ab05f47b upstream.

Use the `unsigned long' rather than `__u32' type for DSP accumulator
registers, like with the regular MIPS multiply/divide accumulator and
general-purpose registers, as all are 64-bit in 64-bit implementations
and using a 32-bit data type leads to contents truncation on context
saving.

Update `arch_ptrace' and `compat_arch_ptrace' accordingly, removing
casts that are similarly not used with multiply/divide accumulator or
general-purpose register accesses.

Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: e50c0a8fa60d ("Support the MIPS32 / MIPS64 DSP ASE.")
Patchwork: https://patchwork.linux-mips.org/patch/19329/
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org # 2.6.15+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/processor.h |    2 +-
 arch/mips/kernel/ptrace.c         |    2 +-
 arch/mips/kernel/ptrace32.c       |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -141,7 +141,7 @@ struct mips_fpu_struct {
 
 #define NUM_DSP_REGS   6
 
-typedef __u32 dspreg_t;
+typedef unsigned long dspreg_t;
 
 struct mips_dsp_state {
 	dspreg_t	dspr[NUM_DSP_REGS];
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -856,7 +856,7 @@ long arch_ptrace(struct task_struct *chi
 				goto out;
 			}
 			dregs = __get_dsp_regs(child);
-			tmp = (unsigned long) (dregs[addr - DSP_BASE]);
+			tmp = dregs[addr - DSP_BASE];
 			break;
 		}
 		case DSP_CONTROL:
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -142,7 +142,7 @@ long compat_arch_ptrace(struct task_stru
 				goto out;
 			}
 			dregs = __get_dsp_regs(child);
-			tmp = (unsigned long) (dregs[addr - DSP_BASE]);
+			tmp = dregs[addr - DSP_BASE];
 			break;
 		}
 		case DSP_CONTROL:
