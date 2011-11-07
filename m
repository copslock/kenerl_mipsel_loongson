Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2011 22:19:06 +0100 (CET)
Received: from cantor2.suse.de ([195.135.220.15]:43107 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904246Ab1KGVTB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Nov 2011 22:19:01 +0100
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx2.suse.de (Postfix) with ESMTP id E3C6B8891E;
        Mon,  7 Nov 2011 22:19:00 +0100 (CET)
Received: by sepie.suse.cz (Postfix, from userid 10020)
        id 762BE764AC; Mon,  7 Nov 2011 22:19:00 +0100 (CET)
Date:   Mon, 7 Nov 2011 22:19:00 +0100
From:   Michal Marek <mmarek@suse.cz>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Arnaud Lacombe <lacombar@gmail.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH] Kbuild: append missing-syscalls to the default target
 list
Message-ID: <20111107211900.GB6264@sepie.suse.cz>
References: <1314234210-11090-1-git-send-email-lacombar@gmail.com>
 <4E69FEC9.2080204@suse.cz>
 <CACqU3MUFyn_jh2pN4GLENqcGVUzAwcMJUR_WLY2EtqOhMheceQ@mail.gmail.com>
 <20111101232233.GA32441@sepie.suse.cz>
 <20111107204448.GA9949@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20111107204448.GA9949@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mmarek@suse.cz
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6059

On Mon, Nov 07, 2011 at 08:44:49PM +0000, Ralf Baechle wrote:
> 5f7efb4c6da9f90cb306923ced2a6494d065a595 breaks 64-bit MIPS builds that
> have 32-bit binary compatibility enabled, for example ip27_defconfig
> or cavium-octeon_defconfig:
> 
>   CC      arch/mips/kernel/asm-offsets.s
> In file included from include/linux/bitops.h:22:0,
>                  from include/linux/kernel.h:17,
>                  from include/linux/cache.h:4,
>                  from include/linux/time.h:7,
>                  from include/linux/stat.h:60,
>                  from include/linux/compat.h:10,
>                  from arch/mips/kernel/asm-offsets.c:11:

Wild guess - does this patch help?


diff --git a/Kbuild b/Kbuild
index 4caab4f..77c191a 100644
--- a/Kbuild
+++ b/Kbuild
@@ -94,7 +94,7 @@ targets += missing-syscalls
 quiet_cmd_syscalls = CALL    $<
       cmd_syscalls = $(CONFIG_SHELL) $< $(CC) $(c_flags)
 
-missing-syscalls: scripts/checksyscalls.sh $(offsets-file) FORCE
+missing-syscalls: scripts/checksyscalls.sh $(offsets-file) $(bounds-file) FORCE
 	$(call cmd,syscalls)
 
 # Keep these two files during make clean


If not, please attach logs of make V=1 with clean Linus' tree and with
5f7efb4c6da9f90cb306923ced2a6494d065a595 reverted.

Michal
