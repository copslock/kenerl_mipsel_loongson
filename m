Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 14:51:18 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47557 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011268AbbATNvQnujt0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Jan 2015 14:51:16 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id t0KDpF3A007931;
        Tue, 20 Jan 2015 14:51:15 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id t0KDpFWN007930;
        Tue, 20 Jan 2015 14:51:15 +0100
Date:   Tue, 20 Jan 2015 14:51:15 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Matt Turner <mattst88@gmail.com>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Add R16000 detection
Message-ID: <20150120135114.GG1205@linux-mips.org>
References: <54BC5E43.8060606@gentoo.org>
 <CAEdQ38H=bHCYm21LrA=EoENRj8jwKU2jk3u36s+hqfzU0VYQSQ@mail.gmail.com>
 <54BDA7A6.1040506@gentoo.org>
 <CAEdQ38HrwAWmPEFd6V+yxL5pMV-0Wa24Ly_bDPM6qbQD=i5jOQ@mail.gmail.com>
 <54BDD5DA.6070405@gentoo.org>
 <CAEdQ38GHvbbSF0k0mQTAjMd8hn0D0Bg0hE2LHptxpkQV_gohGQ@mail.gmail.com>
 <54BDE881.3090907@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54BDE881.3090907@gentoo.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Jan 20, 2015 at 12:32:49AM -0500, Joshua Kinard wrote:

> I see what you're getting at, but I disagree with the reasoning.  The code
> reads clearer when it's explicitly stated the way it is, rather than fudging
> things and treating an R14K as an R12K for a minor gain of a few cycles.
> 
> And since I know there's something "weird" about the R14K right now, one of
> those case statements might be needed down the road to do something a little
> bit differently for R14K versus R12K and such (maybe in the TLB code, if I can
> ever wrap my head around that).
> 
> In the end, it's Ralf's call on accepting it.

The way the code of current_cpu_type() is written, gcc can know that it
may only return certain values.  Which for example means that a system has
an R1x0000 but not a MIPS32 processor.  It then case use that knowledge to
eleminate all dead case and if () statements.

The scheme is not fine grained enough to differenciate between R10000, R12000,
R14000.  That's possible but that's where madness lies.  See __get_cpu_type()
in include/asm/cpu-type.h for details.

We have a number of processors types that need no or very little special
support code yet have special code to distinguish them.  R2000/R3000, R4000/
R4400 are examples.  Sometimes we distinguish them just to make sure the
expected name is displayed in /proc/cpuinfo.

  Ralf
