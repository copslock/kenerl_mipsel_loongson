Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Apr 2017 10:10:59 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:58776 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993930AbdDPIHPt0zDO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Apr 2017 10:07:15 +0200
Received: from localhost (LFbn-1-12060-104.w90-92.abo.wanadoo.fr [90.92.122.104])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 57A49258;
        Sun, 16 Apr 2017 08:07:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Redfearn <matt.redfearn@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.10 25/29] MIPS: IRQ Stack: Fix erroneous jal to plat_irq_dispatch
Date:   Sun, 16 Apr 2017 10:04:42 +0200
Message-Id: <20170416080230.069716108@linuxfoundation.org>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170416080227.593797230@linuxfoundation.org>
References: <20170416080227.593797230@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57704
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

4.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@imgtec.com>

commit c25f8064c1d5731a2ce5664def890140dcdd3e5c upstream.

Commit dda45f701c9d ("MIPS: Switch to the irq_stack in interrupts")
changed both the normal and vectored interrupt handlers. Unfortunately
the vectored version, "except_vec_vi_handler", was incorrectly modified
to unconditionally jal to plat_irq_dispatch, rather than doing a jalr to
the vectored handler that has been set up. This is ok for many platforms
which set the vectored handler to plat_irq_dispatch anyway, but will
cause problems with platforms that use other handlers.

Fixes: dda45f701c9d ("MIPS: Switch to the irq_stack in interrupts")
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15110/
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/genex.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -329,7 +329,7 @@ NESTED(except_vec_vi_handler, 0, sp)
 	PTR_ADD sp, t0, t1
 
 2:
-	jal	plat_irq_dispatch
+	jalr	v0
 
 	/* Restore sp */
 	move	sp, s1
