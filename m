Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Oct 2010 12:36:47 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:55796 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490949Ab0JYKgo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Oct 2010 12:36:44 +0200
Received: by wyf22 with SMTP id 22so3299494wyf.36
        for <multiple recipients>; Mon, 25 Oct 2010 03:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=3w0YjTSWAa4CrtmKg1ff7ExyyhB7owe0ROZzqWjGy5o=;
        b=DQJ3yR1P4R7ClFBwR+0nonX7/JlqXsVo/wyGTBkCDfqvb1GSw9jigVTKbb0mZVkJVi
         Gq/3pu9eWtIalfzCleRDoFrZKbAOEVGk7L3SN3nbDuv5A7OgtpOjOgjhLQUPANdxMiCd
         wASVYtJvqgLAE0lhlQCsTO7790pBcSKygIpig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=MWkNMI1g+VTxFWqjdamaw0yIUw/6bpZUhoauUlTIMQ3munfwCnsFPA2/jDqjtf2x43
         Re26/ugqhcnC3rZGbDSg4pxjO+7i25K2xvhD63Jymia56KmroNCjlU0KegfAL2MkKkhm
         zkUyCedM4s7IQaXVwEzaGZiBlFJgq+mC28kBg=
Received: by 10.216.150.166 with SMTP id z38mr176360wej.6.1288002998625;
        Mon, 25 Oct 2010 03:36:38 -0700 (PDT)
Received: from localhost.localdomain (178-191-1-3.adsl.highway.telekom.at [178.191.1.3])
        by mx.google.com with ESMTPS id x28sm4050103weq.40.2010.10.25.03.36.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Oct 2010 03:36:37 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH] MIPS: Alchemy: fix build with SERIAL_8250=n
Date:   Mon, 25 Oct 2010 12:36:32 +0200
Message-Id: <1288002992-15585-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.3.2
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

In commit 7d172bfefb72a8dae56beff326299c5e21f6f6db I introduced platform
PM methods which call a function of the 8250 driver;  this patch works
around link failures when the kernel isn't built with 8250 support.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/common/platform.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 3691630..9e7814d 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -27,6 +27,7 @@
 static void alchemy_8250_pm(struct uart_port *port, unsigned int state,
 			    unsigned int old_state)
 {
+#ifdef CONFIG_SERIAL_8250
 	switch (state) {
 	case 0:
 		if ((__raw_readl(port->membase + UART_MOD_CNTRL) & 3) != 3) {
@@ -49,6 +50,7 @@ static void alchemy_8250_pm(struct uart_port *port, unsigned int state,
 		serial8250_do_pm(port, state, old_state);
 		break;
 	}
+#endif
 }
 
 #define PORT(_base, _irq)					\
-- 
1.7.3.2
