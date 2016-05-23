Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2016 20:52:30 +0200 (CEST)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:40047 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027124AbcEWSw2aKxE9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 May 2016 20:52:28 +0200
Received: from raspberrypi.musicnaut.iki.fi (85-76-130-131-nat.elisa-mobile.fi [85.76.130.131])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 1358B188C99;
        Mon, 23 May 2016 21:52:27 +0300 (EEST)
Date:   Mon, 23 May 2016 21:52:26 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Joshua Kinard <kumba@gentoo.org>, linux-mips@linux-mips.org,
        "Hill, Steven" <Steven.Hill@cavium.com>
Subject: Re: THP broken on OCTEON?
Message-ID: <20160523185226.GA1253@raspberrypi.musicnaut.iki.fi>
References: <20160523151346.GA23204@ak-desktop.emea.nsn-net.net>
 <20160523152007.GB28729@linux-mips.org>
 <57432E02.9000008@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57432E02.9000008@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53619
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

On Mon, May 23, 2016 at 09:21:22AM -0700, David Daney wrote:
> On 05/23/2016 08:20 AM, Ralf Baechle wrote:
> >On Mon, May 23, 2016 at 06:13:46PM +0300, Aaro Koskinen wrote:
> >>I'm getting kernel crashes (see below) reliably when building Perl in
> >>parallel (make -j16) on OCTEON EBH5600 board (8 cores, 4 GB RAM) with
> >>Linux 4.6.
> >>
> >>It seems that CONFIG_TRANSPARENT_HUGEPAGE has something to do with the
> >>issue - disabling it makes build go through fine.
> >>
> >>Any ideas?
> >
> >I thought it was working except on SGI Origin 200/2000 aka IP27 where
> >Joshua Kinard (added to cc) was hitting issues as well.
> >
> >Joshua, does that similar to the issues you were hitting?
> 
> There is nothing OCTEON specific in the THP code, or huge pages in general.
> 
> That said, we have seen other THP related failures, and have never been able
> to find the cause.
> 
> If someone can come up with a reproducible test case that triggers quickly,
> we can run it in our simulator and easily find the problem.

Trying to build Perl is a reliable reproducer. Is that too heavyweight
for your simulator?

I was able to reproduce this also on EdgeRouter Pro, but there the kernel
does not fail, only compiler dies with SIGBUS:

[  315.095264] Data bus error, epc == 0000000000a801c4, ra == 0000000000a80624

And without THP the build is fine.

I also tried CN68XX board with 16 GB RAM and also there I get SIGBUS failure
instead of Machine Check.

A.
