Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Jun 2015 04:50:53 +0200 (CEST)
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:58364 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27005162AbbFSCuudTbaS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Jun 2015 04:50:50 +0200
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1Z5mO0-0003PN-00; Fri, 19 Jun 2015 02:50:32 +0000
Date:   Thu, 18 Jun 2015 22:50:32 -0400
From:   Rich Felker <dalias@libc.org>
To:     Matthias Schiffer <mschiffer@universe-factory.net>
Cc:     musl@lists.openwall.com, linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [musl] musl-libc/MIPS: detached thread exit broken since kernel
 commit 46e12c07b
Message-ID: <20150619025032.GR1173@brightrain.aerifal.cx>
References: <55837978.7020801@universe-factory.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55837978.7020801@universe-factory.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dalias@aerifal.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dalias@libc.org
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

On Fri, Jun 19, 2015 at 04:07:52AM +0200, Matthias Schiffer wrote:
> Hi,
> I've come across the issue that applications with detached threads
> (using pthread_detach or a pthread_attr_t with
> pthread_attr_setdetachstate) will segfault using musl-libc on MIPS as
> soon as the detached thread exits. As far as I can tell, the underlying
> issue is the following:
> 
> To clean up after itself, the finishing thread will call __unmapself,
> which will unmap the thread's own stack and call the exit syscall
> directly after that, without accessing the now unmapped stack.
> 
> This worked fine in 2012, when pthread support for MIPS was implemented
> in musl. It seems to have been broken by kernel commit 46e12c07b "MIPS:
> O32 / 32-bit: Always copy 4 stack arguments." (also in 2012) which made
> the kernel unconditionally copy 4 stack arguments, even when the syscall
> doesn't even use the arguments.
> 
> I guess this would be reasonably easy to fix up in musl, but let's also
> get the linux-mips people's opinions, as that commit obviously broke the
> kernel ABI...

This is kernel ABI breakage that should be fixed -- people running old
kernel versions with old musl binaries might suffer a regression when
upgrading, and perhaps more importantly the failure mode is just
really bad. But I think we can also work around it on the userspace
side in musl by pointing the stack pointer at some rodata (or even at
pc, e.g. copying $25 to $sp) before making the syscall.

Rich
