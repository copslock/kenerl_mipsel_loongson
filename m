Received:  by oss.sgi.com id <S553700AbQJUUai>;
	Sat, 21 Oct 2000 13:30:38 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:37135 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553663AbQJUUaP>;
	Sat, 21 Oct 2000 13:30:15 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 6C1297D9; Sat, 21 Oct 2000 22:30:13 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id BCF1F900C; Sat, 21 Oct 2000 22:29:04 +0200 (CEST)
Date:   Sat, 21 Oct 2000 22:29:04 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: oops in lance initialization / diskboot
Message-ID: <20001021222904.C4004@paradigm.rfc822.org>
References: <20001021212318.C3619@paradigm.rfc822.org> <00d301c03b9b$d5ce2340$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <00d301c03b9b$d5ce2340$0deca8c0@Ulysses>; from kevink@mips.com on Sat, Oct 21, 2000 at 10:16:43PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Oct 21, 2000 at 10:16:43PM +0200, Kevin D. Kissell wrote:
> I've seen this sort of problem on other platforms with
> other bootloaders, but I'll bet good money that the
> reason is the same - if the boot monitor listens to
> the ethernet, it will have set up some number of
> buffer descriptors in memory.   There's a class of
> loader bug whereing it launches the application,
> in this case the Linux kernel, without shutting down
> the LAN controller.  The first broadcast packet that
> comes across the wire then corrupts some hunk of
> memory that Linux thought it had control over.   Note
> that your "address" is a fragment of an ASCII string.
> The only 100% solution is to fix the bootloader.  Can
> you shut off the Lance in delo?

Probably - The problem is that i cant with the PROM. So i 
have to copy the lance init/search thing from the kernel
if i wanted to ...

But from the source i see that the driver assumes the Lance
is inactive and starts with setting up DMA instead of first
resetting the Card. I'll try that first.

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
