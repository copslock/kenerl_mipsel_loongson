Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Sep 2014 21:29:36 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:37587 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009005AbaIOT1MSmUWS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Sep 2014 21:27:12 +0200
Received: from localhost (c-24-22-230-10.hsd1.wa.comcast.net [24.22.230.10])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EA1A3B20;
        Mon, 15 Sep 2014 19:27:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 3.16 065/158] MIPS: smp-mt: Fix link error when PROC_FS=n
Date:   Mon, 15 Sep 2014 12:25:04 -0700
Message-Id: <20140915192544.845153571@linuxfoundation.org>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <20140915192542.872134685@linuxfoundation.org>
References: <20140915192542.872134685@linuxfoundation.org>
User-Agent: quilt/0.63-1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42584
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

3.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 7d907fa1c6ccb64c7f64cc7d3dcc7f6fe30a67b4 upstream.

Commit d6d3c9afaab4 (MIPS: MT: proc: Add support for printing VPE and TC
ids) causes a link error when CONFIG_PROC_FS=n:

arch/mips/built-in.o: In function `proc_cpuinfo_notifier_init':
smp-mt.c: undefined reference to `register_proc_cpuinfo_notifier'

This is fixed by adding an ifdef around the procfs handling code
in smp-mt.c.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Reported-by: Markos Chandras <markos.chandras@imgtec.com>
Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/7244/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/smp-mt.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -288,6 +288,7 @@ struct plat_smp_ops vsmp_smp_ops = {
 	.prepare_cpus		= vsmp_prepare_cpus,
 };
 
+#ifdef CONFIG_PROC_FS
 static int proc_cpuinfo_chain_call(struct notifier_block *nfb,
 	unsigned long action_unused, void *data)
 {
@@ -309,3 +310,4 @@ static int __init proc_cpuinfo_notifier_
 }
 
 subsys_initcall(proc_cpuinfo_notifier_init);
+#endif
