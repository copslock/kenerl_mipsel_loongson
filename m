Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Nov 2014 14:52:32 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:46015 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012660AbaKENwah8UUr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Nov 2014 14:52:30 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sA5DqTf8014025;
        Wed, 5 Nov 2014 14:52:29 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sA5DqS23014024;
        Wed, 5 Nov 2014 14:52:28 +0100
Date:   Wed, 5 Nov 2014 14:52:28 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP27: CONFIG_TRANSPARENT_HUGEPAGE triggers bus errors
Message-ID: <20141105135228.GA13785@linux-mips.org>
References: <54560D3B.8060602@gentoo.org>
 <5457CF0A.7020303@gmail.com>
 <5458272A.7050309@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5458272A.7050309@gentoo.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43875
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

On Mon, Nov 03, 2014 at 08:08:58PM -0500, Joshua Kinard wrote:

> I guess I could find a way to have the kernel trigger a non-fatal oops/dump the
> registers on a bus error and get a look at the cause register to see if that
> sheds any light on things.  Doesn't a SIGBUS on MIPS typically mean that an
> address wasn't aligned on a 32-bit boundary?  Or could it also mean other things?
> 
> I believe that the R10K is largely compatible with the R4K-style TLB setup, but
> Ralf or someone else more knowledge in that area will have to verify.  Maybe
> the R10k-family CPUs need their own TLB routines, or what currently exists
> needs modifications?  I have not tried to understand the whole TLB thing in
> MIPS yet, so that's a bit of voodoo to me.

Voodoo that normally works a lot better than the conventional code it replaced!

The R10000 TLB is basically the all dancing, all singing version of other
MIPS TLBs.  Noteworthy differences are that TLB hazards are handled in hardware
and that the R10000 automatically detects multiple matching TLB entries on a
TLB write in which case it will automatically invalidate the old entry before
writing the new entry.  It also is the only MIPS CPU to implement a c0_framemask
register but to my understanding of that functionality the only software
handling that register's functionality needs is initialization to zero essentially
disabling it.  The R10000 supports a maximum page size of 16M.

  Ralf
