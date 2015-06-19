Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Jun 2015 16:35:44 +0200 (CEST)
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:58378 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007468AbbFSOfnHNM7v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Jun 2015 16:35:43 +0200
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1Z5xON-00053T-00; Fri, 19 Jun 2015 14:35:39 +0000
Date:   Fri, 19 Jun 2015 10:35:39 -0400
From:   Rich Felker <dalias@libc.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Matthias Schiffer <mschiffer@universe-factory.net>,
        musl@lists.openwall.com, linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [musl] musl-libc/MIPS: detached thread exit broken since kernel
 commit 46e12c07b
Message-ID: <20150619143539.GU1173@brightrain.aerifal.cx>
References: <55837978.7020801@universe-factory.net>
 <20150619025032.GR1173@brightrain.aerifal.cx>
 <20150619100626.GB29960@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150619100626.GB29960@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dalias@aerifal.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47979
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

On Fri, Jun 19, 2015 at 12:06:26PM +0200, Ralf Baechle wrote:
> On Thu, Jun 18, 2015 at 10:50:32PM -0400, Rich Felker wrote:
> 
> > This is kernel ABI breakage that should be fixed -- people running old
> > kernel versions with old musl binaries might suffer a regression when
> > upgrading, and perhaps more importantly the failure mode is just
> > really bad. But I think we can also work around it on the userspace
> > side in musl by pointing the stack pointer at some rodata (or even at
> > pc, e.g. copying $25 to $sp) before making the syscall.
> 
> Just to be on the safe side, make sure it is something that's readable.  Core
> might me mapped execute-only, that is not readable and that is a feature
> which the affected kernels do support on suitable hardware.

How would that happen? Do you have ELF files with 3 PT_LOAD segments?
Normally there are two and their permissions are r-x and rw-.

Rich
