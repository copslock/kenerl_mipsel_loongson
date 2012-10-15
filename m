Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2012 19:45:21 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36661 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823034Ab2JORpQPO83Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Oct 2012 19:45:16 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q9FHjEZc025663;
        Mon, 15 Oct 2012 19:45:14 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q9FHjB9U025662;
        Mon, 15 Oct 2012 19:45:11 +0200
Date:   Mon, 15 Oct 2012 19:45:11 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Suprasad Mutalik Desai <suprasad.desai@gmail.com>
Cc:     "Steven J. Hill" <sjhill@mips.com>, linux-mips@linux-mips.org,
        Chris Dearman <chris@mips.com>,
        John Crispin <blogic@openwrt.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] MIPS: kspd: Remove kspd support.
Message-ID: <20121015174511.GA20197@linux-mips.org>
References: <1349821203-23083-1-git-send-email-sjhill@mips.com>
 <20121010073826.GB6740@linux-mips.org>
 <CAJMXqXYQC6L3iS92p9R7FuQkuwJWN7SEZy2+E_v-0UKTp7SaSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJMXqXYQC6L3iS92p9R7FuQkuwJWN7SEZy2+E_v-0UKTp7SaSw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34700
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Oct 10, 2012 at 02:36:22PM +0530, Suprasad Mutalik Desai wrote:

>  AFAIK, the "CONFIG_MIPS_VPE_APSP_API" was used to get the console dump of
> the SP program running on the VPE1 (usually a bare-iron program compiled
> with MIPS provided toolchain) . This option was useful on the MALTA
> platform during the initial evaluation of the APRP or APSP mode.

kspd has never been a brilliant thing - it's running in an essentially
random thread / file context so it's just coincidence something is working
at all.  Also syscalls from inside the kernel are frowned upon these days
and are being eleminated.

Another issue was that the provided toolchain you mentioned was the SDE
toolchain along with its libraries.  The SDE toolchain uses different
values for all its constants which requires a compat layer.  That should
rather stay outside the kernel but as it was, it was burried inside kspd.c.

If somebody fixed up kspd I absolutely don't mind resurrecting it but as
it was, the sole feedback I ever had was from various other kernel
developers.  NOT A SINGLE USER.  EVER.  So I quite liked the nuclear
solution for kspd.

My suggestion would be to convert the old kspd into some communication
facility where the bare metal code talks through the rtlx with a userspace
daemon which then does the actual I/O operations.  That also solved the
ABI issue - as it was, kspd had no concept of which ABI to use.

And probably not even the bare metal code should have or it ends up
carrying half a libc along ...

> Now if this support is removed then is there any alternative provided by
> MIPS ?.

You have to ask MIPS.  I'm only the God of Revenge that rips patches into
bits and removes kernel features ;-)

  Raf
