Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2017 15:09:31 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:49952 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991359AbdCPOJXS-1sc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Mar 2017 15:09:23 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2GE9JWl023909;
        Thu, 16 Mar 2017 15:09:19 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2GE9I9b023908;
        Thu, 16 Mar 2017 15:09:18 +0100
Date:   Thu, 16 Mar 2017 15:09:18 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: ARCS can't load CONFIG_DEBUG_LOCK_ALLOC kernel
Message-ID: <20170316140918.GH5512@linux-mips.org>
References: <8b2d7473-ba4d-f2c9-27e7-b1a30b95c4f8@gentoo.org>
 <a639551b-4338-e1fb-0cc7-e6ea34b94c2c@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a639551b-4338-e1fb-0cc7-e6ea34b94c2c@gentoo.org>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57333
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

On Wed, Mar 15, 2017 at 11:50:44PM -0400, Joshua Kinard wrote:

> On 03/15/2017 16:11, Joshua Kinard wrote:
> > I've reported in the past that turning on CONFIG_DEBUG_LOCK_ALLOC produces a
> > kernel that can't boot on several SGI platforms.  It turns out that using
> > arcload (Stan's bootloader originally written for IP30), I can get some
> > debugging out on why.  I am still puzzled, but maybe this information can be
> > interpreted by someone else into something meaningful?
> > 
> > All addresses printed out of arcload are physical address.
> > 
> > ARCS Memory Map as printed by some debugging I added to the arcload binary:
> > 
> > 0x00000000 - 0x00001000 ExceptionBlock
> > 0x00001000 - 0x00002000 SystemParameterBlock
> > 0x00002000 - 0x00004000 FirmwarePermanent
> > 0x20004000 - 0x20f00000 FreeMemory***
> > 0x20f00000 - 0x21000000 FirmwareTemporary
> > 0x21000000 - 0x5fff0000 FreeMemory
> > 0x5fff0000 - 0x5ffff000 LoadedProgram
> > 0x5ffff000 - 0x60000000 FreeMemory
> > 0x60000000 - 0xa0000000 FirmwarePermanent
> 
> So it turns out I can get away, on Octane at least, by changing the load
> address from 0x20004000 to an arbitrary value in the other FreeMemory segment
> from 0x21000000 - 0x5fff0000.  Specifically, using 0x21004000 appears to work
> without any ill effects.
> 
> The 0x20004000 value is the address used by IRIX to load (with symon, it
> becomes 0x200800000 instead).  I'll have to try this on the IP27 later on as
> well.  On Octane, CONFIG_DEBUG_LOCK_ALLOC didn't toss up any major locking
> issues yet.  Probably need to hammer the disks with bonnie++ or such.  At least
> I can get back to the BRIDGE/PCI mess now...

I'm wondering where the ARC stack is on kernel entry if maybe the
ARC stack has corrupted the kernel?  If possible, can you get your
kernel or a test program to compute a checksum over itself to see
if it has been corrupted?

Let me repeat my ARC(S) mantra again, ARC(S) is broken, ARC(S) lies.
Trust is futile.  Even if ARC(S) claims something is free I'd rather
not rely on it.

  Ralf
