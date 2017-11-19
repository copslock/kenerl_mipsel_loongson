Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Nov 2017 15:32:18 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:54718 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992314AbdKSObp4bD0i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Nov 2017 15:31:45 +0100
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9371F408;
        Sun, 19 Nov 2017 14:31:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 3.18 26/38] MIPS: End asm function prologue macros with .insn
Date:   Sun, 19 Nov 2017 15:29:42 +0100
Message-Id: <20171119142923.179912441@linuxfoundation.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171119142921.807414664@linuxfoundation.org>
References: <20171119142921.807414664@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61008
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>


[ Upstream commit 08889582b8aa0bbc01a1e5a0033b9f98d2e11caa ]

When building a kernel targeting a microMIPS ISA, recent GNU linkers
will fail the link if they cannot determine that the target of a branch
or jump is microMIPS code, with errors such as the following:

    mips-img-linux-gnu-ld: arch/mips/built-in.o: .text+0x542c:
    Unsupported jump between ISA modes; consider recompiling with
    interlinking enabled.
    mips-img-linux-gnu-ld: final link failed: Bad value

or:

    ./arch/mips/include/asm/uaccess.h:1017: warning: JALX to a
    non-word-aligned address

Placing anything other than an instruction at the start of a function
written in assembly appears to trigger such errors. In order to prepare
for allowing us to follow function prologue macros with an EXPORT_SYMBOL
invocation, end the prologue macros (LEAD, NESTED & FEXPORT) with a
.insn directive. This ensures that the start of the function is marked
as code, which always makes sense for functions & safely prevents us
from hitting the link errors described above.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14508/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/include/asm/asm.h |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/arch/mips/include/asm/asm.h
+++ b/arch/mips/include/asm/asm.h
@@ -54,7 +54,8 @@
 		.align	2;				\
 		.type	symbol, @function;		\
 		.ent	symbol, 0;			\
-symbol:		.frame	sp, 0, ra
+symbol:		.frame	sp, 0, ra;			\
+		.insn
 
 /*
  * NESTED - declare nested routine entry point
@@ -63,8 +64,9 @@ symbol:		.frame	sp, 0, ra
 		.globl	symbol;				\
 		.align	2;				\
 		.type	symbol, @function;		\
-		.ent	symbol, 0;			 \
-symbol:		.frame	sp, framesize, rpc
+		.ent	symbol, 0;			\
+symbol:		.frame	sp, framesize, rpc;		\
+		.insn
 
 /*
  * END - mark end of function
@@ -86,7 +88,7 @@ symbol:
 #define FEXPORT(symbol)					\
 		.globl	symbol;				\
 		.type	symbol, @function;		\
-symbol:
+symbol:		.insn
 
 /*
  * ABS - export absolute symbol
