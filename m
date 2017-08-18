Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 15:19:26 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:42163 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994907AbdHRNSznDcC9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Aug 2017 15:18:55 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 2D9291A1E24;
        Fri, 18 Aug 2017 15:18:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (unknown [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 10ED51A1DCA;
        Fri, 18 Aug 2017 15:18:50 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Bo Hu <bohu@google.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>, linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 1/6] MIPS: math-emu: CMP.Sxxx.<D|S>: Prevent occurences of SIGILL crashes
Date:   Fri, 18 Aug 2017 15:17:30 +0200
Message-Id: <1503062286-27030-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1503062286-27030-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1503062286-27030-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

Fix CMP.Sxxx.<D|S> SIGILL crashes by fixing main switch/case statement
in fpu_emul() function so that inadvertent fall-troughs are prevented.

Consider, let's say, CMP.SAF.S instruction when one of inputs is zero
and another input is a signalling NaN. The desired output is zero, and
the exception flag "invalid operation" set. For such case, the main
portion of the implementation is within "d_fmt" case of the main
"switch/case" statement in fpu_emul() function. The execution will
follow one of "if-else" branches that doesn't contain "goto cop1scr;"
statement, and will therefore reach the end of "d_fmt" case. It will
subsequently fall through to the next case, "l_fmt". After follwoing
similar pattern, the execution will fall through the next case,
"default". The "default" branch contains "return SIGILL;" statement
only. This means that the caller application wil crash with "illegal
instruction" message.

It is obvious that above described fall-throughs are unnecessary and
harmfull. This patch rectifies that behavior by providing "break;"
statements at the end of cases "d_fmt_ and "l_fmt".

There are 22 instructions affected by this problem:

CMP.<SAF|SEQ|SLE|SLT|SNE|SOR|SUEQ|SULE|SULT|SUN|SUNE>.<D|S>.

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 arch/mips/math-emu/cp1emu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index f08a7b4..520a5ac 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -2394,6 +2394,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			break;
 			}
 		}
+		break;
 	}
 
 	case l_fmt:
@@ -2468,6 +2469,8 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			break;
 			}
 		}
+		break;
+
 	default:
 		return SIGILL;
 	}
-- 
2.7.4
