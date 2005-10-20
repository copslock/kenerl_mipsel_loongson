Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 07:55:18 +0100 (BST)
Received: from mms1.broadcom.com ([216.31.210.17]:11530 "EHLO
	mms1.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S3465580AbVJTGy5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 07:54:57 +0100
Received: from 10.10.64.121 by mms1.broadcom.com with SMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Wed, 19 Oct 2005 23:54:45 -0700
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
Received: from mail-irva-8.broadcom.com ([10.10.64.221]) by
 mail-irva-1.broadcom.com (Post.Office MTA v3.5.3 release 223 ID#
 0-72233U7200L2200S0V35) with ESMTP id com for
 <linux-mips@linux-mips.org>; Wed, 19 Oct 2005 23:54:43 -0700
Received: from mon-irva-10.broadcom.com (mon-irva-10.broadcom.com
 [10.10.64.171]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id CAW10601; Wed, 19 Oct 2005 23:54:44 -0700 (PDT)
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-10.broadcom.com (8.9.1/8.9.1) with ESMTP
 id XAA28006 for <linux-mips@linux-mips.org>; Wed, 19 Oct 2005 23:54:43
 -0700 (PDT)
Received: from localhost.localdomain (ldt-sj3-054 [10.21.3.41]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 j9K6shov008668 for <linux-mips@linux-mips.org>; Wed, 19 Oct 2005
 23:54:43 -0700 (PDT)
Received: (from adi@localhost) by localhost.localdomain (8.11.6/8.9.3)
 id j9K6shw23921 for linux-mips@linux-mips.org; Wed, 19 Oct 2005
 23:54:43 -0700
Date:	Wed, 19 Oct 2005 23:54:43 -0700
From:	"Andrew Isaacson" <adi@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH 1/12]  sibyte-fixes
Message-ID: <20051020065443.GA23899@broadcom.com>
References: <20051020065320.GA23857@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <20051020065320.GA23857@broadcom.com>
User-Agent: Mutt/1.4.2.1i
X-WSS-ID: 6F49E0BF0684623602-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <adi@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@broadcom.com
Precedence: bulk
X-list: linux-mips

Fix typo in cpu_probe_sibyte

Signed-Off-By: Andy Isaacson <adi@broadcom.com>

 arch/mips/kernel/cpu-probe.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: lmo/arch/mips/kernel/cpu-probe.c
===================================================================
--- lmo.orig/arch/mips/kernel/cpu-probe.c	2005-10-19 22:34:08.000000000 -0700
+++ lmo/arch/mips/kernel/cpu-probe.c	2005-10-19 22:34:10.000000000 -0700
@@ -618,7 +618,7 @@
 	 * cache code which eventually will be folded into c-r4k.c.  Until
 	 * then we pretend it's got it's own cache architecture.
 	 */
-	c->options &= MIPS_CPU_4K_CACHE;
+	c->options &= ~MIPS_CPU_4K_CACHE;
 	c->options |= MIPS_CPU_SB1_CACHE;
 
 	switch (c->processor_id & 0xff00) {
