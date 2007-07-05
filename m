Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jul 2007 17:45:33 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:39128 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023062AbXGEQpa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Jul 2007 17:45:30 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l65GjTkI023372;
	Thu, 5 Jul 2007 17:45:29 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l65GjSMU023371;
	Thu, 5 Jul 2007 17:45:28 +0100
Date:	Thu, 5 Jul 2007 17:45:28 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: dead(?) MIPS config stuff
Message-ID: <20070705164528.GA23340@linux-mips.org>
References: <20070705144641.GA20210@linux-mips.org> <01dc01c7bf20$e03f6c20$10eca8c0@grendel> <20070705163658.GA22652@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070705163658.GA22652@linux-mips.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15621
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 05, 2007 at 05:36:58PM +0100, Ralf Baechle wrote:

> All this email was about were kernel configuration options that can't be
> enabled for some reason.  Of course these automated checkers such as
> Robert's make the assumption that the CONFIG_* preprocessor namespace
> is rserved for the Kconfig system.  In this particular case the reason
> is quite simple:
> 
> > arch/mips/kernel/process.c:54:#ifdef CONFIG_SMTC_IDLE_HOOK_DEBUG
> > arch/mips/Kconfig.debug:40:config CONFIG_SMTC_IDLE_HOOK_DEBUG
> 
> The kconfig system itself does prefix names with CONFIG_ so kconfig
> ends up defining CONFIG_CONFIG_SMTC_IDLE_HOOK_DEBUG (are we stuttuttering?)


From: Ralf Baechle <ralf@linux-mips.org>
Date: Thu, 5 Jul 2007 17:39:48 +0100
Subject: [MIPS] SMTC: Fix cut'n'paste bug in Kconfig.debug

This effectivly turned the SMTC_IDLE_HOOK_DEBUG debug option into a no-op.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 72d5c19..3efe117 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -37,7 +37,7 @@ config DEBUG_STACK_USAGE
 
 	  This option will slow down process creation somewhat.
 
-config CONFIG_SMTC_IDLE_HOOK_DEBUG
+config SMTC_IDLE_HOOK_DEBUG
 	bool "Enable additional debug checks before going into CPU idle loop"
 	depends on DEBUG_KERNEL && MIPS_MT_SMTC
 	help
