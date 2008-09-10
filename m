Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Sep 2008 19:51:42 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:46317 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S20094575AbYIJSvk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 Sep 2008 19:51:40 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m8ABoMAA020671;
	Wed, 10 Sep 2008 13:50:25 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m8ABoK6N020670;
	Wed, 10 Sep 2008 13:50:20 +0200
Date:	Wed, 10 Sep 2008 13:50:20 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@paralogos.com>
Cc:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	ths@networkno.de, linux-mips@linux-mips.org,
	michael@free-electrons.com
Subject: Re: [PATCH 1/1] mips: clear IV bit in CP0 cause if the CPU doesn't
	support divec
Message-ID: <20080910115020.GA19935@linux-mips.org>
References: <1220948125-3550-1-git-send-email-thomas.petazzoni@free-electrons.com> <48C7AB71.8090106@paralogos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48C7AB71.8090106@paralogos.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 10, 2008 at 01:11:45PM +0200, Kevin D. Kissell wrote:

> I think it's important to know whether it's U-Boot or Linux that's confused.
> As Thomas Bogendoerfer pointed out, it's not good practice to flip bits  
> whose
> use is unknown to the kernel.  If in fact the CPU in question does  
> support IV,
> was correctly identified as such by U-Boot, but isn't recognized by the MIPS
> Linux kernel, then we ought to fix Linux to recognize the CPU.  If it  
> doesn't
> support IV, but U-Boot thought it did, then U-Boot is broken and ought to
> be fixed.  If you you're stuck with a broken U-Boot for some reason, then
> there ought to be some platform-specific place to put a hack.

What happened is this:

        if (cpu_has_divec) {
                if (cpu_has_mipsmt) {
                        unsigned int vpflags = dvpe();
                        set_c0_cause(CAUSEF_IV);
			evpe(vpflags);
		} else
                        set_c0_cause(CAUSEF_IV);
	}

but include/asm-mips/mach-qemu/cpu-feature-overrides.h was defining
cpu_has_divec as 0.  It should have been either undefined (for runtime
probing) or 1.  Iow, it was a platform specific bug.

With the large number of wild pre-MIPS32/64 architecture variants around I
feel a little uneasy to just zero the field unless I know that bit 23
really is the IV bit on a particular processor.  Just as an example, the
RM7000 has the IV bit on bit 24, not bit 23 like MIPS32 and the
functionality also differs a little.

  Ralf
