Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Feb 2015 09:37:37 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:51442 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012970AbbBIIgm54HBX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Feb 2015 09:36:42 +0100
Received: from localhost (unknown [113.28.134.59])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A9F96AD2;
        Mon,  9 Feb 2015 08:36:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@openwrt.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.18 11/39] MIPS: IRQ: Fix disable_irq on CPU IRQs
Date:   Mon,  9 Feb 2015 16:33:54 +0800
Message-Id: <20150209083329.302299905@linuxfoundation.org>
X-Mailer: git-send-email 2.3.0
In-Reply-To: <20150209083328.753647350@linuxfoundation.org>
References: <20150209083328.753647350@linuxfoundation.org>
User-Agent: quilt/0.63-1
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45773
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

From: Felix Fietkau <nbd@openwrt.org>

commit a3e6c1eff54878506b2dddcc202df9cc8180facb upstream.

If the irq_chip does not define .irq_disable, any call to disable_irq
will defer disabling the IRQ until it fires while marked as disabled.
This assumes that the handler function checks for this condition, which
handle_percpu_irq does not. In this case, calling disable_irq leads to
an IRQ storm, if the interrupt fires while disabled.

This optimization is only useful when disabling the IRQ is slow, which
is not true for the MIPS CPU IRQ.

Disable this optimization by implementing .irq_disable and .irq_enable

Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/8949/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/irq_cpu.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/mips/kernel/irq_cpu.c
+++ b/arch/mips/kernel/irq_cpu.c
@@ -56,6 +56,8 @@ static struct irq_chip mips_cpu_irq_cont
 	.irq_mask_ack	= mask_mips_irq,
 	.irq_unmask	= unmask_mips_irq,
 	.irq_eoi	= unmask_mips_irq,
+	.irq_disable	= mask_mips_irq,
+	.irq_enable	= unmask_mips_irq,
 };
 
 /*
@@ -92,6 +94,8 @@ static struct irq_chip mips_mt_cpu_irq_c
 	.irq_mask_ack	= mips_mt_cpu_irq_ack,
 	.irq_unmask	= unmask_mips_irq,
 	.irq_eoi	= unmask_mips_irq,
+	.irq_disable	= mask_mips_irq,
+	.irq_enable	= unmask_mips_irq,
 };
 
 void __init mips_cpu_irq_init(void)
