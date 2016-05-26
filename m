Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 May 2016 21:23:33 +0200 (CEST)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:53170 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27034947AbcEZTXcH8NG6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 May 2016 21:23:32 +0200
Received: from raspberrypi.musicnaut.iki.fi (85-76-130-131-nat.elisa-mobile.fi [85.76.130.131])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 0277B1888F1;
        Thu, 26 May 2016 22:23:30 +0300 (EEST)
Date:   Thu, 26 May 2016 22:23:30 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Aaro Koskinen <aaro.koskinen@nokia.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: THP broken on OCTEON?
Message-ID: <20160526192330.GA17985@raspberrypi.musicnaut.iki.fi>
References: <20160523151346.GA23204@ak-desktop.emea.nsn-net.net>
 <20160525134152.GG23204@ak-desktop.emea.nsn-net.net>
 <57473996.7030705@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57473996.7030705@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53668
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

Hi,

On Thu, May 26, 2016 at 10:59:50AM -0700, David Daney wrote:
> On 05/25/2016 06:41 AM, Aaro Koskinen wrote:
> >On Mon, May 23, 2016 at 06:13:46PM +0300, Aaro Koskinen wrote:
> >>I'm getting kernel crashes (see below) reliably when building Perl in
> >>parallel (make -j16) on OCTEON EBH5600 board (8 cores, 4 GB RAM) with
> >>Linux 4.6.
> >>
> >>It seems that CONFIG_TRANSPARENT_HUGEPAGE has something to do with the
> >>issue - disabling it makes build go through fine.
> >
> >Seems to be also reproducible on MIPS64/Malta/QEMU (UP, 2 GB RAM). This
> >happened during Perl's Configure script on the first try:
> 
> Are you sure this failure is THP related?

We have used MIPS64 Malta QEMU for regular package builds many months,
and it has never failed with THP disabled. With THP enabled builds
fail reliably.

> Also, what is the source of your rootfs (compilers, tools etc.)?

Compiler is mainline GCC 4.9.3 and binutils 2.26. The whole rootfs is
compiled from scratch (64-bit ABI).

On ER Pro, I use O32 userspace and kernel compiled with GCC 6.1.0.

> Will a similar config fail this way on OCTEON booted with numcores=1?

Yes, just tested with ER Pro using single core, and also with just "make"
without any parallel threads. And it failed with SIGSEGV this time:

[  744.268063] 
do_page_fault(): sending SIGSEGV to miniperl for invalid read access from 000000000000000c
[  744.277418] epc = 00000000004ca8e8 in miniperl[400000+19e000]
[  744.283202] ra  = 00000000004c9e8c in miniperl[400000+19e000]
[  744.289005] 

A.
