Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 May 2010 16:57:05 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42302 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491185Ab0EaO5C (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 31 May 2010 16:57:02 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4VEuw2h024226;
        Mon, 31 May 2010 15:56:58 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4VEuw0d024224;
        Mon, 31 May 2010 15:56:58 +0100
Date:   Mon, 31 May 2010 15:56:58 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: [PATCH 0/6] mips: diverse Makefile updates
Message-ID: <20100531145657.GC22741@linux-mips.org>
References: <20100530141939.GA22153@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100530141939.GA22153@merkur.ravnborg.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, May 30, 2010 at 04:19:39PM +0200, Sam Ravnborg wrote:

> This patchset does the following:
> - introduce arch/mips/Kbuild
> - use -Werror on all core-y files of the mips kernel
> - introduce a distributed way to specify platform definitions
> - refactor a few Makefiles
> - clean up cleaning 
> 
> Ralf asked in private mail if I could try to implement
> a working varient of a suggestion I made some time ago.
> The idea was to move platform specific definitions to
> dedicated platfrom files.
> 
> This is implmented in the third patch.
> 
> The idea is to move the platform definitions from arch/mips/Makefile
> to arch/mips/<platform>/Platfrom
> 
> The content of this file is used in arch/mips/Makefile
> and arch/mips/Kbuild.
> 
> On top of this is a few patches that refactor the
> boot and boot/compressed Makefiles so they are more
> kbuild conformant.
> This beautify the output when we build a kernel.

This will need some extra work on the remaining platforms so is 2.6.36
material so I queued the entire series for 2.6.36.  The queue tree is
at

   git://ftp.linux-mips.org/pub/scm/linux-queue.git

And of course a big thanks for your work!

  Ralf
