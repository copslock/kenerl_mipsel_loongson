Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBHLXPV00989
	for linux-mips-outgoing; Mon, 17 Dec 2001 13:33:25 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBHLXKo00986
	for <linux-mips@oss.sgi.com>; Mon, 17 Dec 2001 13:33:21 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBHKWnr30567;
	Mon, 17 Dec 2001 18:32:49 -0200
Date: Mon, 17 Dec 2001 18:32:49 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Florian Lohoff <flo@rfc822.org>
Cc: Keith Owens <kaos@melbourne.sgi.com>,
   Karsten Merker <karsten@excalibur.cologne.de>, linux-mips@oss.sgi.com
Subject: Re: No bzImage target for MIPS
Message-ID: <20011217183249.A2081@dea.linux-mips.net>
References: <20011215093101.A256@excalibur.cologne.de> <20472.1008407699@ocs3.intra.ocs.com.au> <20011215124604.GE23167@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011215124604.GE23167@paradigm.rfc822.org>; from flo@rfc822.org on Sat, Dec 15, 2001 at 01:46:04PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Dec 15, 2001 at 01:46:04PM +0100, Florian Lohoff wrote:

> > target, like elf, srec and bin.  To that end, I looked at moving
> > elf2ecoff and addinitrd to an arch independent directory so everybody
> > could use those tools, alas both contain mips specific code.  Any idea
> > how much work is required to make elf2ecoff and addinitrd into generic
> > utilities?  Is it worth the effort or should they stay as mips only?
> 
> Last i had a look elf2ecoff and addinitrd were not really nice
> recovering from toolchain problems like pages of null between sections
> which was a common fault a couple months back. This lead to addinitrd
> not beeing able to attach a ramdisk that the kernel would be able to
> find it. 
> 
> BTW: Shouldn't objcopy be able to convert an ELF into an ECOFF ?

In theory yes, in practice that was found to be so problematic that we
just gave up and use those NetBSD tools.

  Ralf
