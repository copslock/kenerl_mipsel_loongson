Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 21:05:23 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:40689 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012164AbaJVTFQog6LB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Oct 2014 21:05:16 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s9MJ5FtJ015947;
        Wed, 22 Oct 2014 21:05:15 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s9MJ5F11015946;
        Wed, 22 Oct 2014 21:05:15 +0200
Date:   Wed, 22 Oct 2014 21:05:15 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Single MIPS kernel
Message-ID: <20141022190515.GC12502@linux-mips.org>
References: <20141022083437.GB18581@linux-mips.org>
 <5447EFB5.4090009@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5447EFB5.4090009@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43501
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

On Wed, Oct 22, 2014 at 10:56:05AM -0700, David Daney wrote:

> Another reason is that the protocol between the bootloader and the kernel
> varies by platform.  So you would have to have several different entry
> points, one for each booting protocol.
> 
> I am not sure how the bootloaders would know which entry point to use.

That's where I foresaw the needs for the ISA style platform probe right
at the kernel entry point before fanning out to a platform-specific
entry point.

Since we already support compressed kernels I'm wondering if relocation
might also be performed by the compression wrapper along with the
hardware probe.  That would leave the vmlinux itself untouched and
the wrapper could be installed on the target.

It's just that all this for the sake of a unified kernel images seems
way to painful!

  Ralf
