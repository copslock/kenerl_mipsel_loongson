Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2012 08:24:53 +0100 (CET)
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:46505 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815793Ab2KAHYt7eaXZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Nov 2012 08:24:49 +0100
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1TTp8y-00064F-00
        for linux-mips@linux-mips.org; Thu, 01 Nov 2012 07:24:48 +0000
Date:   Thu, 1 Nov 2012 03:24:48 -0400
To:     linux-mips@linux-mips.org
Subject: MIPS support in musl
Message-ID: <20121101072448.GA6105@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   Rich Felker <dalias@aerifal.cx>
X-archive-position: 34837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dalias@aerifal.cx
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

Hi all,

I would like to announce the MIPS port of musl, an MIT-licensed
implementation of the standard library for Linux (including dynamic
linker, threads, etc.) with focus on small size, correctness, and
robustness. More information on musl is available at the website,
http://www.musl-libc.org

At first the MIPS port was experimental, but as of the latest release
(0.9.7) it should be on par with the other ports. If there are
remaining MIPS-specific bugs anyone runs into, I'm happy to help debug
them, or just to help with usage issues. Currently, MIPS support is
limited to o32-hardfloat ABI (real fpu or kernel emulation). We hope
to have o32-softfloat and possibly n64 added in the next couple
release cycles.

To those of you on the list who helped with my earlier MIPS
syscall-ABI questions getting efficient inline-syscall support into
musl, thanks!

Rich Felker
