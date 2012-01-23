Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2012 14:33:07 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:33338 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903735Ab2AWNc4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 Jan 2012 14:32:56 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id q0NDWsvO010812;
        Mon, 23 Jan 2012 14:32:54 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id q0NDWqDT010811;
        Mon, 23 Jan 2012 14:32:52 +0100
Date:   Mon, 23 Jan 2012 14:32:52 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-mips@linux-mips.org,
        Jayachandran C <jayachandranc@netlogicmicro.com>,
        David VomLehn <dvomlehn@cisco.com>
Subject: Re: [PATCH] mips: fix netlogic defconfigs for coverage builds
Message-ID: <20120123133252.GA10454@linux-mips.org>
References: <1327262566-2676-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1327262566-2676-1-git-send-email-paul.gortmaker@windriver.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sun, Jan 22, 2012 at 03:02:46PM -0500, Paul Gortmaker wrote:

> The toolchain prefix will most likely be site specific and is
> not guaranteed to always be "mips-linux-gnu-", so simply don't
> specify one.  A quick "git grep" shows this to be consistent
> amongst other cross compiled targets.
> 
> Similarly, the site specific initramfs source location should not
> be used, since that won't exist for most people, and it prevents
> them from doing coverage builds on the defconfigs, such as those
> done in linux-next and run routinely by many others.

I ran into that issue as well.  My build script does something like

  sed -i -e s@^CONFIG_CROSS_COMPILE=\"[^\"]*\"\$@CONFIG_CROSS_COMPILE=\"\"@
  sed -i -e s@^CONFIG_INITRAMFS_SOURCE=\"[^\"]*\"\$@CONFIG_INITRAMFS_SOURCE=\"\"@
  sed -i -e s/^CONFIG_DEBUG_INFO=y\$/#\ CONFIG_DEBUG_INFO\ is\ not\ set/

to patch up two two annoying settings and the last one to make the compiler
run a little quicker and increase chances for a hit in ccache.

But for benefit of the rest of the world I've applied tihs patch and will
also patch up powertv_defconfig which now is the last CONFIG_CROSS_COMPILE
user.

Thanks!

  Ralf
