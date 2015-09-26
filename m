Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Sep 2015 22:57:47 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:56763 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009053AbbIZU5HDJSPg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 26 Sep 2015 22:57:07 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 18F7EB3D;
        Sat, 26 Sep 2015 20:57:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.2 018/134] MIPS: CPS: use 32b accesses to GCRs
Date:   Sat, 26 Sep 2015 13:54:30 -0700
Message-Id: <20150926205312.900382098@linuxfoundation.org>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <20150926205311.819185658@linuxfoundation.org>
References: <20150926205311.819185658@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49376
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

4.2-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit 90996511187d6282db6d02d3f97006b4dbb5c457 upstream.

Commit b677bc03d757 ("MIPS: cps-vec: Use macros for various arithmetics
and memory operations") replaced various load & store instructions
through cps-vec.S with the PTR_L & PTR_S macros. However it was somewhat
overzealous in doing so for CM GCR accesses, since the bit width of the
CM doesn't necessarily match that of the CPU. The registers accessed
(GCR_CL_COHERENCE & GCR_CL_ID) should be safe to simply always access
using 32b instructions, so do so in order to avoid issues when using a
32b CM with a 64b CPU.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Cc: James Hogan <james.hogan@imgtec.com>
Patchwork: https://patchwork.linux-mips.org/patch/10864/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/cps-vec.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -152,7 +152,7 @@ dcache_done:
 
 	/* Enter the coherent domain */
 	li	t0, 0xff
-	PTR_S	t0, GCR_CL_COHERENCE_OFS(v1)
+	sw	t0, GCR_CL_COHERENCE_OFS(v1)
 	ehb
 
 	/* Jump to kseg0 */
@@ -302,7 +302,7 @@ LEAF(mips_cps_boot_vpes)
 	PTR_L	t0, 0(t0)
 
 	/* Calculate a pointer to this cores struct core_boot_config */
-	PTR_L	t0, GCR_CL_ID_OFS(t0)
+	lw	t0, GCR_CL_ID_OFS(t0)
 	li	t1, COREBOOTCFG_SIZE
 	mul	t0, t0, t1
 	PTR_LA	t1, mips_cps_core_bootcfg
