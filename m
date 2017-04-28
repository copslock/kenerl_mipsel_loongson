Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2017 10:35:22 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:57538 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991960AbdD1IfMZ8Wnl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Apr 2017 10:35:12 +0200
Received: from localhost (unknown [195.77.54.9])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1C88A9C;
        Fri, 28 Apr 2017 08:35:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Crispin <john@phrozen.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3.18 41/47] MIPS: ralink: Cosmetic change to prom_init().
Date:   Fri, 28 Apr 2017 10:32:54 +0200
Message-Id: <20170428083039.996812102@linuxfoundation.org>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170428083038.327543269@linuxfoundation.org>
References: <20170428083038.327543269@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57807
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

From: John Crispin <john@phrozen.org>

commit 9c48568b3692f1a56cbf1935e4eea835e6b185b1 upstream.

Over the years the code has been changed various times leading to
argc/argv being defined in a different function to where we actually
use the variables. Clean this up by moving them to prom_init_cmdline().

Signed-off-by: John Crispin <john@phrozen.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14902/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ralink/prom.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/arch/mips/ralink/prom.c
+++ b/arch/mips/ralink/prom.c
@@ -24,8 +24,10 @@ const char *get_system_type(void)
 	return soc_info.sys_type;
 }
 
-static __init void prom_init_cmdline(int argc, char **argv)
+static __init void prom_init_cmdline(void)
 {
+	int argc;
+	char **argv;
 	int i;
 
 	pr_debug("prom: fw_arg0=%08x fw_arg1=%08x fw_arg2=%08x fw_arg3=%08x\n",
@@ -54,14 +56,11 @@ static __init void prom_init_cmdline(int
 
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
