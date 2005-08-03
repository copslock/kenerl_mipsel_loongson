Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Aug 2005 19:14:18 +0100 (BST)
Received: from pasta.sw.starentnetworks.com ([IPv6:::ffff:12.33.234.10]:43991
	"EHLO pasta.sw.starentnetworks.com") by linux-mips.org with ESMTP
	id <S8225540AbVHCSN7>; Wed, 3 Aug 2005 19:13:59 +0100
Received: from cortez.sw.starentnetworks.com (cortez.sw.starentnetworks.com [12.33.233.12])
	by pasta.sw.starentnetworks.com (Postfix) with ESMTP id 538981496D7
	for <linux-mips@linux-mips.org>; Wed,  3 Aug 2005 14:17:08 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17137.2596.203177.705324@cortez.sw.starentnetworks.com>
Date:	Wed, 3 Aug 2005 14:17:08 -0400
From:	Dave Johnson <djohnson+linuxmips@sw.starentnetworks.com>
To:	linux-mips@linux-mips.org
Subject: modules fail to load for 64bit kernel with 32bit ELF format
X-Mailer: VM 7.07 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Return-Path: <djohnson@sw.starentnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: djohnson+linuxmips@sw.starentnetworks.com
Precedence: bulk
X-list: linux-mips


Building for 64bit kernel with 32bit ELF format produces the correct
object files for loading, but attempting to load them produces
ENOEXEC.

This is because the object file is failing ELF header checks in
load_module().

Elf_Ehdr in include/asm-mips/module.h is being defined as Elf64_Ehdr
based on CONFIG_MIPS64 instead of CONFIG_BUILD_ELF64.

elf_check_arch() also needs some fixing in include/asm-mips/elf.h as
it too is invoked from load_module(), however elf_check_arch() is also
used in binfmt_elf*.c.

Simply changing the defines produces loads of warnings due to casting
pointers around in module.c. Any suggestions on the best way to fix
this?

-- 
Dave Johnson
Starent Networks
