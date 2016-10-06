Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Oct 2016 10:38:24 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:36047 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990518AbcJFIiRO05po (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Oct 2016 10:38:17 +0200
Received: from localhost (unknown [62.214.2.210])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8510A78D;
        Thu,  6 Oct 2016 08:38:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.7 054/141] MIPS: fix uretprobe implementation
Date:   Thu,  6 Oct 2016 10:28:10 +0200
Message-Id: <20161006074451.077939925@linuxfoundation.org>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161006074448.608056610@linuxfoundation.org>
References: <20161006074448.608056610@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55345
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

4.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>

commit db06068a4fd44a57b642b369d2a295b8448f6b65 upstream.

arch_uretprobe_hijack_return_addr should replace the return address for
a call with a trampoline address.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Fixes: 40e084a506eb ('MIPS: Add uprobes support.')
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14298/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/uprobes.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kernel/uprobes.c
+++ b/arch/mips/kernel/uprobes.c
@@ -257,7 +257,7 @@ unsigned long arch_uretprobe_hijack_retu
 	ra = regs->regs[31];
 
 	/* Replace the return address with the trampoline address */
-	regs->regs[31] = ra;
+	regs->regs[31] = trampoline_vaddr;
 
 	return ra;
 }
