Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jan 2013 08:17:20 +0100 (CET)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:42658 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816635Ab3AKHRQzZ6rv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Jan 2013 08:17:16 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id E219A19BC9B;
        Fri, 11 Jan 2013 09:17:15 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id MIy6BqOafCwK; Fri, 11 Jan 2013 09:17:15 +0200 (EET)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp5.welho.com (Postfix) with SMTP id 9136B5BC005;
        Fri, 11 Jan 2013 09:17:14 +0200 (EET)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Fri, 11 Jan 2013 09:17:10 +0200
Date:   Fri, 11 Jan 2013 09:17:10 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: 3.8-rc3: yet another MIPS build failure
Message-ID: <20130111071710.GE12712@blackmetal.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi,

Commit d3ce88431892b703b04769566338a89eda6b0477 (MIPS: Fix modpost
error in modules attepting to use virt_addr_valid()) broke the 64-bit
MIPS build:

  LD      init/built-in.o
kernel/built-in.o: In function `memory_bm_free':
snapshot.c:(.text+0x3c76c): undefined reference to `__virt_addr_valid'
snapshot.c:(.text+0x3c800): undefined reference to `__virt_addr_valid'
kernel/built-in.o: In function `snapshot_write_next':
(.text+0x3e094): undefined reference to `__virt_addr_valid'
kernel/built-in.o: In function `snapshot_write_next':
(.text+0x3e468): undefined reference to `__virt_addr_valid'
make[4]: *** [vmlinux] Error 1

A quick workaround is to compile ioremap.c always, but it adds ~2KB
unused code for 64-bit-only kernels...

A.
