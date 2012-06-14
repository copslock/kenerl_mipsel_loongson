Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2012 13:02:43 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:47657 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901172Ab2FNLCj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Jun 2012 13:02:39 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1Sf7oz-0007OC-00; Thu, 14 Jun 2012 13:02:37 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id 2DAF61BB7B0; Thu, 14 Jun 2012 13:02:28 +0200 (CEST)
Date:   Thu, 14 Jun 2012 13:02:28 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     David Daney <david.daney@cavium.com>
Cc:     Jim Faulkner <jfaulkne@ccs.neu.edu>, linux-mips@linux-mips.org
Subject: Re: booting linux-3.3 or linux 3.4 on an SGI O2?
Message-ID: <20120614110228.GA10493@alpha.franken.de>
References: <20120605190047.GA6263@alumni-linux.ccs.neu.edu>
 <4FCE593B.10808@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4FCE593B.10808@cavium.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 33636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
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

On Tue, Jun 05, 2012 at 12:08:43PM -0700, David Daney wrote:
> On 06/05/2012 12:00 PM, Jim Faulkner wrote:
> >Hi all, I haven't been able to boot any kernels after linux 3.2 on my
> >SGI O2.  I've tried linux-3.3.5 and linux-3.4.0, but neither would boot.
> >Unfortunately I don't have further information such as a kernel panic,
> >since I don't get any video output after the kernel is loaded.  I've
> >attached my linux-3.4 .config.  Anybody know what patches I might need
> >to get the latest kernels booting on this system?
> >
> 
> I have had problems as well.
> 
> Someone should configure a serial console and early printk to see if
> they can see what is happening.

Linux version 3.5.0-rc2 (tsbogend@solo.franken.de) (gcc version 4.3.1 (Debian 4.3.1-2) ) #1 Thu Jun 14 12:05:29 CEST 2012

this version (current git from two days ago) boots for me with serial console
up to a login prompt:

mips:~# cat /proc/cpuinfo 
system type		: SGI O2
processor		: 0
cpu model		: R5000 V2.1  FPU V1.0

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
