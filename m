Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2006 19:40:04 +0000 (GMT)
Received: from allen.werkleitz.de ([80.190.251.108]:4039 "EHLO
	allen.werkleitz.de") by ftp.linux-mips.org with ESMTP
	id S3458570AbWBATjq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Feb 2006 19:39:46 +0000
Received: from p54be9954.dip0.t-ipconnect.de ([84.190.153.84] helo=void.local)
	by allen.werkleitz.de with esmtpsa (TLS-1.0:DHE_RSA_3DES_EDE_CBC_SHA1:24)
	(Exim 4.60)
	(envelope-from <js@linuxtv.org>)
	id 1F4NuF-0007hI-U9; Wed, 01 Feb 2006 20:44:49 +0100
Received: from js by void.local with local (Exim 3.35 #1 (Debian))
	id 1F4NuF-0005oL-00; Wed, 01 Feb 2006 20:44:43 +0100
Date:	Wed, 1 Feb 2006 20:44:43 +0100
From:	Johannes Stezenbach <js@linuxtv.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Message-ID: <20060201194443.GB21871@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Daniel Jacobowitz <dan@debian.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
References: <20060131171508.GB6341@linuxtv.org> <Pine.LNX.4.64N.0601311724340.31371@blysk.ds.pg.gda.pl> <20060201164423.GA4891@nevyn.them.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201164423.GA4891@nevyn.them.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: 84.190.153.84
Subject: Re: gdb vs. gdbserver with -mips3 / 32bitmode userspace
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Return-Path: <js@linuxtv.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@linuxtv.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 01, 2006, Daniel Jacobowitz wrote:
> All of this code is flat-out wrong, as far as I'm concerned.  I have a
> project underway which will fix it, as a nice side effect.
> 
> GDB is trying to do something confusing, but admirable, here.  When
> you're running on a 64-bit system the full 64 bits are always there:
> even if the binary only uses half of them (is this true in Linux?  I
> don't remember if the relevant control bits get fudged, it's been a
> while; it's definitely true on some other systems).  Thus it's possible
> for a bogus instruction to corrupt the top half of a register, leading
> to otherwise inexplicable problems.
> 
> So if the remote stub knows about 64-bit registers, it should report
> them to GDB, and GDB should accept and display them, and still handle
> 32-bit frames.  If the remote stub doesn't, then there's no option but
> to report the 32-bit registers.
> 
> Really, GDB ought to (and soon will I hope) autodetect which ones were
> sent.

If I understand this correctly, gdbserver should check the
register size supported by the OS, and communicate this to gdb?

I'm using a Linux kernel with CONFIG_32BIT, and if I understand
the ptrace interface correctly, the registers as seen through
ptrace are 32bit then, even though the CPU has 64bit registers.

(I have no idea if the cp0 status suggested by others in this
thread reflect CONFIG_32BIT vs. CONFIG_64BIT on Linux.)


Anyway, is a better workaround _now_ for gdb-6.[34] than the patch
to mips_register_type()?


Thanks,
Johannes
