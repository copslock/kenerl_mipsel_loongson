Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jul 2010 20:44:55 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:39795 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492560Ab0GWSov (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Jul 2010 20:44:51 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o6NIinIk031697;
        Fri, 23 Jul 2010 19:44:49 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o6NIimPH031695;
        Fri, 23 Jul 2010 19:44:48 +0100
Date:   Fri, 23 Jul 2010 19:44:48 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wolfgang Grandegger <wg@grandegger.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v3] mips/alchemy: add basic support for the GPR board
Message-ID: <20100723184448.GB17634@linux-mips.org>
References: <1279185683-21037-1-git-send-email-wg@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1279185683-21037-1-git-send-email-wg@grandegger.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 15, 2010 at 11:21:23AM +0200, Wolfgang Grandegger wrote:

> From: Wolfgang Grandegger <wg@denx.de>
> 
> This patch adds basic support for the General Purpose Router (GPR)
> board from Trapeze ITS.
> 
> Signed-off-by: Wolfgang Grandegger <wg@denx.de>
> ---
> 
> Something went wrong with my previous "git send-email", please ignore.

It even triggers a bug in Patchwork - it doens't handle subject-less
patches very gracefully.

+static void gpr_power_off(void)
+{
+       printk(KERN_ALERT "It's now safe to remove power\n");

My favorite line to delete from kernel patches.  Messages to the user
belong into userspace.

+	while (1)
+		asm volatile (".set mips3 ; wait ; .set mips0");
+}
+
+static void gpr_power_off(void)
+{
[..]
+	while (1)
+		asm volatile (".set mips3 ; wait ; .set mips0");
+}

Call cpu_wait() instead of open coding the WAIT instruction.  This avoids
certain restrictions of the WAIT instruction.

I've sorted that and also updated the defconfig file.  As is due to
other changes make gpr_defconfig did configure a kernel for IP22.  The
changed kconfig behaviour is worse than useless!

Queued for 2.6.36,

  Ralf
