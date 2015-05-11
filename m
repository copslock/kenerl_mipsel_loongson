Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2015 21:12:11 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:36560 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013155AbbEKTMJxYLsr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2015 21:12:09 +0200
Received: from akpm3.mtv.corp.google.com (unknown [216.239.45.95])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D701CB8E;
        Mon, 11 May 2015 19:12:04 +0000 (UTC)
Date:   Mon, 11 May 2015 12:12:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Eric B Munson <emunson@akamai.com>
Cc:     Shuah Khan <shuahkh@osg.samsung.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 0/3] Allow user to request memory to be locked on page
 fault
Message-Id: <20150511121204.2af73429ad3c29b6d67f1345@linux-foundation.org>
In-Reply-To: <20150511143618.GA30570@akamai.com>
References: <1431113626-19153-1-git-send-email-emunson@akamai.com>
        <20150508124203.6679b1d35ad9555425003929@linux-foundation.org>
        <20150508200610.GB29933@akamai.com>
        <20150508131523.f970d13a213bca63bd6f2619@linux-foundation.org>
        <20150511143618.GA30570@akamai.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
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

On Mon, 11 May 2015 10:36:18 -0400 Eric B Munson <emunson@akamai.com> wrote:

> On Fri, 08 May 2015, Andrew Morton wrote:
> ...
>
> > 
> > Why can't the application mmap only those parts of the file which it
> > wants and mlock those?
> 
> There are a number of problems with this approach.  The first is it
> presumes the program will know what portions are needed a head of time.
> In many cases this is simply not true.  The second problem is the number
> of syscalls required.  With my patches, a single mmap() or mlockall()
> call is needed to setup the required locking.  Without it, a separate
> mmap call must be made for each piece of data that is needed.  This also
> opens up problems for data that is arranged assuming it is contiguous in
> memory.  With the single mmap call, the user gets a contiguous VMA
> without having to know about it.  mmap() with MAP_FIXED could address
> the problem, but this introduces a new failure mode of your map
> colliding with another that was placed by the kernel.
> 
> Another use case for the LOCKONFAULT flag is the security use of
> mlock().  If an application will be using data that cannot be written
> to swap, but the exact size is unknown until run time (all we have a
> build time is the maximum size the buffer can be).  The LOCKONFAULT flag
> allows the developer to create the buffer and guarantee that the
> contents are never written to swap without ever consuming more memory
> than is actually needed.

What application(s) or class of applications are we talking about here?

IOW, how generally applicable is this?  It sounds rather specialized.
