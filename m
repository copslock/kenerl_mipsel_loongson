Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2010 14:24:43 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:60323 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492979Ab0LANYk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Dec 2010 14:24:40 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oB1DOciE002341;
        Wed, 1 Dec 2010 13:24:38 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oB1DObIB002339;
        Wed, 1 Dec 2010 13:24:37 GMT
Date:   Wed, 1 Dec 2010 13:24:37 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     naveen yadav <yad.naveen@gmail.com>
Cc:     kernelnewbies@nl.linux.org,
        linux-arm-kernel@lists.arm.linux.org.uk, linux-mips@linux-mips.org
Subject: Re: Change of Default kernel page size i.e 4KB
Message-ID: <20101201132437.GA32555@linux-mips.org>
References: <AANLkTi=4gtEC9fZyvc9g6uHecvjPrr0dDc==KsDOvq2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AANLkTi=4gtEC9fZyvc9g6uHecvjPrr0dDc==KsDOvq2Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 01, 2010 at 01:50:13PM +0530, naveen yadav wrote:

> Cc: kernelnewbies@nl.linux.org,
> 	linux-arm-kernel-request@lists.arm.linux.org.uk,
                        ^^^^^^^^ WTF?
> 	linux-mips@linux-mips.org

> I have few drivers and very big application running on ARM and MIPS target.
> I want to check the performance by changing the page size ie.
> 
> 8K, 16K, 32K etc.
> 
> Is it possile, If yes then what all care i need to take .

For MIPS: Rebuild kernel with support for the new kernel size.  Few MIPS
cores.  Note that the `odd´ page sizes, that those that aren't a power
of 4 are only supported by Cavium while all MIPS III and newer processors
support even `even´ sizes 4KB, 16KB and 64KB.

Aside of rebuilding the kernel you also need a suitable userland; older
versions of binutils will produce binaries that only run
for 4kB page sizes.

For ARM the page size is fixed at 4kB which will simplify your benchmarking
efforts ;)

Performance gains very much depends on the workload but in general larger
sizes are beneficial except maybe for systems with very little memory.

  Ralf
