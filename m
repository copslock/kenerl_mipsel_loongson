Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Mar 2006 23:20:19 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:59329 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133793AbWCWXUK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 23 Mar 2006 23:20:10 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k2NNUAC3005947;
	Thu, 23 Mar 2006 23:30:10 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k2NNU8LL005945;
	Thu, 23 Mar 2006 23:30:08 GMT
Date:	Thu, 23 Mar 2006 23:30:08 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	eric@egaulin.com
Cc:	linux-mips@linux-mips.org
Subject: Re: insmod: ELF file not for this architecture
Message-ID: <20060323233008.GA4030@linux-mips.org>
References: <7f0c7cce0603231337g3d6534c9p@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f0c7cce0603231337g3d6534c9p@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 23, 2006 at 04:37:56PM -0500, Eric Gaulin wrote:

> I built linux 2.6.11 with amd patch for Alchemy Au1200 and also built the
> mae-driver.ko. When i load the driver i get this error "insmod: ELF file not
> for this architecture". I was told on #elinux irc channel tha i need to
> enable ELF support in my kernel configuration! There is no such option!

Good and correct advice but yet besides the point, so let's sort this out.

The #elinux guys were speaking about the CONFIG_BINFMT_ELF option which
needs to be enabled for the kernel to execute ELF applications.  Note
I'm saying applications, not kernel modules.  For Linux/MIPS all
applications use the ELF format, so there is no point in ever disabling
this option and so all the default configuration files included with the
kernel have this option set.

Now, what does your error message actually mean?  First of all it's an
error message which seems to come from the old modutils, so you seem to
be using Linux 2.4 kernel.  Nice fossil, btw ;-)  And the message simply
indicates you're trying to load a non-MIPS binary into a MIPS system.
Chances are you build your module using the host instead of the cross
compiler - something like that.  Try ``file mae-driver.ko´´.

For Linux/MIPS specific advice you may want to drop by in #mipslinux.

  Ralf
