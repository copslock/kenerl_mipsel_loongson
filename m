Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jan 2015 14:16:27 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:52574 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011445AbbAZNQZHC8VM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Jan 2015 14:16:25 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id t0QDGM4h030733;
        Mon, 26 Jan 2015 14:16:22 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id t0QDGMhC030732;
        Mon, 26 Jan 2015 14:16:22 +0100
Date:   Mon, 26 Jan 2015 14:16:22 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Joshua Kinard <kumba@gentoo.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Display CPU byteorder in /proc/cpuinfo
Message-ID: <20150126131621.GB31322@linux-mips.org>
References: <54BCC827.3020806@gentoo.org>
 <54BEDF3C.6040105@gmail.com>
 <54BF12B9.8000507@gentoo.org>
 <alpine.LFD.2.11.1501210347180.28301@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1501210347180.28301@eddie.linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45484
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

On Mon, Jan 26, 2015 at 08:06:35AM +0000, Maciej W. Rozycki wrote:

> On Tue, 20 Jan 2015, Joshua Kinard wrote:
> 
> > > Userspace C code doesn't need this as it has its own standard ways of
> > > determining endianness.
> > > 
> > > If you need to know as a user you can do:
> > > 
> > >    readelf -h /bin/sh | grep Data | cut -d, -f2
> 
>  I tend to use `file /sbin/init' if I need to check it for some reason -- 
> less typing. ;)
> 
> > This would only tell you the endianness of the userland binary, not of the
> > kernel.  While they should be one and the same (otherwise, you're not going to
> > get very far anyways), they are, technically, distinctly different properties.
> 
>  Well, several MIPS processors can reverse the user-mode endianness via 
> the CP0.Status.RE bit; though as you may be aware it has never been 
> implemented for Linux.  Otherwise it would obviously have to be a 
> per-process property (and execve(2) could flip it back).

As posted previously that was why I removed it from /proc/cpuinfo.  And
yes, I had a simple prototype to use the RE feature.  Even in the limited
form I had it was impressively ugly and it became clear it would never
be upstreamable.

Right now MIPS is not making much use of sysfs.  Endian information and
other runtime CPU configuration probably should go there.  Detecting the
size and associativity of cache lines, changing the cache line size, more
control over VPEs in multithreaded kernels come to mind.

>  What you may find more interesting, we actually used to include this 
> information in /proc/cpuinfo, long ago, and I believe it was removed for 
> the very reason of the existence of this reverse-endianness feature.  
> Which I find sort of weak an argument given that we don't support this 
> stuff anyway, but given the simple ways to extract this information from 
> elsewhere (/proc/config.gz is another candidate place) I have doubts if 
> having it in /proc/cpuinfo adds any value too.  Not that I'd object it 
> strongly either though.
> 
>  See:
> 
> commit 874124ebb6309433a2e1acf1deb95baa1c34db0b
> Author: Ralf Baechle <ralf@linux-mips.org>
> Date:   Sun Dec 2 11:34:32 2001 +0000
> 
>     Merge with Linux 2.4.15.
> 
> -- which actually makes me wonder what happened here as Linus's 2.4.15 
> change does not include any of this stuff.  Only 2.4.19 does, 8 months 
> later -- a CVS to GIT conversion problem?

In those days I only sent patches upstream very rarely because committing
to CVS was easy - but extracting patches, breaking the up in useful patches
and submitting them upstream was so painful.  Honestly, the CVS archive
only began to be really useful after it was converted to git!

The conversion to git is as accurate as I possibly could do it and includes
the entire tarball and patch history as well as the linux-2.0 repository.
Linux 2.0 lived in a separate repository because it was created for
around 2.1.73 when it became clear that 2.2 was still going to take a
long time.  The conversion was done custom conversion tools due to the
limitations of the tools that were available at the time.

  Ralf
