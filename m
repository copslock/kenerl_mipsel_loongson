Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2015 19:59:18 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35750 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027478AbbEKRzvCIuOY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2015 19:55:51 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4AD52BC1;
        Mon, 11 May 2015 17:55:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Cassel <niklass@axis.com>, paul.burton@imgtec.com,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.0 25/72] MIPS: smp-cps: cpu_set FPU mask if FPU present
Date:   Mon, 11 May 2015 10:54:31 -0700
Message-Id: <20150511175437.868135533@linuxfoundation.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <20150511175437.112151861@linuxfoundation.org>
References: <20150511175437.112151861@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47323
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

4.0-stable review patch.  If anyone has any objections, please let me know.

------------------


From: Niklas Cassel <niklas.cassel@axis.com>

Commit 90db024f140d0d6ad960cc5f090e3c8ed890ca55 upstream.

If we have an FPU, enroll ourselves in the FPU-full mask.
Matching the MT_SMP and CMP implementations of smp_setup.

Signed-off-by: Niklas Cassel <niklass@axis.com>
Cc: paul.burton@imgtec.com
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/8948/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kernel/smp-cps.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -88,6 +88,12 @@ static void __init cps_smp_setup(void)
 
 	/* Make core 0 coherent with everything */
 	write_gcr_cl_coherence(0xff);
+
+#ifdef CONFIG_MIPS_MT_FPAFF
+	/* If we have an FPU, enroll ourselves in the FPU-full mask */
+	if (cpu_has_fpu)
+		cpu_set(0, mt_fpu_cpumask);
+#endif /* CONFIG_MIPS_MT_FPAFF */
 }
 
 static void __init cps_prepare_cpus(unsigned int max_cpus)
