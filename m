Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Dec 2017 09:41:41 +0100 (CET)
Received: from [128.1.224.119] ([128.1.224.119]:50498 "EHLO ringil.hmeau.com"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990491AbdLVIldoHaIG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Dec 2017 09:41:33 +0100
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by norbury.hmeau.com with esmtp (Exim 4.80 #3 (Debian))
        id 1eSItR-0002YG-RY; Fri, 22 Dec 2017 19:41:25 +1100
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1eSItL-00086B-Jv; Fri, 22 Dec 2017 19:41:19 +1100
Date:   Fri, 22 Dec 2017 19:41:19 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     James Hogan <james.hogan@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH] lib/mpi: Fix umul_ppmm() for MIPS64r6
Message-ID: <20171222084119.GC30924@gondor.apana.org.au>
References: <20171205233135.1763-1-james.hogan@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171205233135.1763-1-james.hogan@mips.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <herbert@gondor.apana.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: herbert@gondor.apana.org.au
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

On Tue, Dec 05, 2017 at 11:31:35PM +0000, James Hogan wrote:
> From: James Hogan <jhogan@kernel.org>
> 
> Current MIPS64r6 toolchains aren't able to generate efficient
> DMULU/DMUHU based code for the C implementation of umul_ppmm(), which
> performs an unsigned 64 x 64 bit multiply and returns the upper and
> lower 64-bit halves of the 128-bit result. Instead it widens the 64-bit
> inputs to 128-bits and emits a __multi3 intrinsic call to perform a 128
> x 128 multiply. This is both inefficient, and it results in a link error
> since we don't include __multi3 in MIPS linux.
> 
> For example commit 90a53e4432b1 ("cfg80211: implement regdb signature
> checking") merged in v4.15-rc1 recently broke the 64r6_defconfig and
> 64r6el_defconfig builds by indirectly selecting MPILIB. The same build
> errors can be reproduced on older kernels by enabling e.g. CRYPTO_RSA:
> 
> lib/mpi/generic_mpih-mul1.o: In function `mpihelp_mul_1':
> lib/mpi/generic_mpih-mul1.c:50: undefined reference to `__multi3'
> lib/mpi/generic_mpih-mul2.o: In function `mpihelp_addmul_1':
> lib/mpi/generic_mpih-mul2.c:49: undefined reference to `__multi3'
> lib/mpi/generic_mpih-mul3.o: In function `mpihelp_submul_1':
> lib/mpi/generic_mpih-mul3.c:49: undefined reference to `__multi3'
> lib/mpi/mpih-div.o In function `mpihelp_divrem':
> lib/mpi/mpih-div.c:205: undefined reference to `__multi3'
> lib/mpi/mpih-div.c:142: undefined reference to `__multi3'
> 
> Therefore add an efficient MIPS64r6 implementation of umul_ppmm() using
> inline assembly and the DMULU/DMUHU instructions, to prevent __multi3
> calls being emitted.
> 
> Fixes: 7fd08ca58ae6 ("MIPS: Add build support for the MIPS R6 ISA")
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-mips@linux-mips.org
> Cc: linux-crypto@vger.kernel.org

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
