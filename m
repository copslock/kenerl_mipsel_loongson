Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2017 15:34:45 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:33606 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992289AbdCPOcjz4aL0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Mar 2017 15:32:39 +0100
Received: from localhost (unknown [183.98.136.252])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A1A92B8A;
        Thu, 16 Mar 2017 14:32:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Crispin <john@phrozen.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.9 11/44] MIPS: ralink: Cosmetic change to prom_init().
Date:   Thu, 16 Mar 2017 23:29:36 +0900
Message-Id: <20170316142926.456049294@linuxfoundation.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170316142925.994282609@linuxfoundation.org>
References: <20170316142925.994282609@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57342
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Crispin <john@phrozen.org>

commit 9c48568b3692f1a56cbf1935e4eea835e6b185b1 upstream.

Over the years the code has been changed various times leading to
argc/argv being defined in a different function to where we actually
use the variables. Clean this up by moving them to prom_init_cmdline().

Signed-off-by: John Crispin <john@phrozen.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14902/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ralink/prom.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/arch/mips/ralink/prom.c
+++ b/arch/mips/ralink/prom.c
@@ -30,8 +30,10 @@ const char *get_system_type(void)
 	return soc_info.sys_type;
 }
 
-static __init void prom_init_cmdline(int argc, char **argv)
+static __init void prom_init_cmdline(void)
 {
+	int argc;
+	char **argv;
 	int i;
 
 	pr_debug("prom: fw_arg0=%08x fw_arg1=%08x fw_arg2=%08x fw_arg3=%08x\n",
@@ -60,14 +62,11 @@ static __init void prom_init_cmdline(int
 
 void __init prom_init(void)
 {
-	int argc;
-	char **argv;
-
 	prom_soc_init(&soc_info);
 
 	pr_info("SoC Type: %s\n", get_system_type());
 
-	prom_init_cmdline(argc, argv);
+	prom_init_cmdline();
 }
 
 void __init prom_free_prom_memory(void)
