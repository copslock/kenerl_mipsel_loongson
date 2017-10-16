Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2017 18:14:33 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:36616 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992135AbdJPQOZz6wgC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Oct 2017 18:14:25 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EA7C4BD5;
        Mon, 16 Oct 2017 16:14:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 08/28] MIPS: math-emu: Remove pr_err() calls from fpu_emu()
Date:   Mon, 16 Oct 2017 18:12:01 +0200
Message-Id: <20171016160923.943399112@linuxfoundation.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171016160923.478701091@linuxfoundation.org>
References: <20171016160923.478701091@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60411
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit ca8eb05b5f332a9e1ab3e2ece498d49f4d683470 upstream.

The FPU emulator includes 2 calls to pr_err() which are triggered by
invalid instruction encodings for MIPSr6 cmp.cond.fmt instructions.
These cases are not kernel errors, merely invalid instructions which are
already handled by delivering a SIGILL which will provide notification
that something failed in cases where that makes sense.

In cases where that SIGILL is somewhat expected & being handled, for
example when crashme happens to generate one of the affected bad
encodings, the message is printed with no useful context about what
triggered it & spams the kernel log for no good reason.

Remove the pr_err() calls to make crashme run silently & treat the bad
encodings the same way we do others, with a SIGILL & no further kernel
log output.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: f8c3c6717a71 ("MIPS: math-emu: Add support for the CMP.condn.fmt R6 instruction")
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/17253/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/math-emu/cp1emu.c |    2 --
 1 file changed, 2 deletions(-)

--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -2360,7 +2360,6 @@ dcopuop:
 					break;
 				default:
 					/* Reserved R6 ops */
-					pr_err("Reserved MIPS R6 CMP.condn.S operation\n");
 					return SIGILL;
 				}
 			}
@@ -2434,7 +2433,6 @@ dcopuop:
 					break;
 				default:
 					/* Reserved R6 ops */
-					pr_err("Reserved MIPS R6 CMP.condn.D operation\n");
 					return SIGILL;
 				}
 			}
