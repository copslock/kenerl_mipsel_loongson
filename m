Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4AIa6wJ013345
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 10 May 2002 11:36:06 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4AIa6kV013344
	for linux-mips-outgoing; Fri, 10 May 2002 11:36:06 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4AIa2wJ013341
	for <linux-mips@oss.sgi.com>; Fri, 10 May 2002 11:36:02 -0700
Received: by gandalf.physik.uni-konstanz.de (Postfix, from userid 501)
	id 67ABB8D35; Fri, 10 May 2002 20:37:37 +0200 (CEST)
Date: Fri, 10 May 2002 20:37:37 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: howto pass ramdisk loaddress to kernel
Message-ID: <20020510203737.A5410@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
References: <20020507123249.A9827@gandalf.physik.uni-konstanz.de> <20020507104538.GB795@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020507104538.GB795@paradigm.rfc822.org>; from flo@rfc822.org on Tue, May 07, 2002 at 12:45:38PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,
On Tue, May 07, 2002 at 12:45:38PM +0200, Florian Lohoff wrote:
> On Tue, May 07, 2002 at 12:32:49PM +0200, Guido Guenther wrote:
> > My question is now: how do i properly pass the initrd's memory address
> > to the kernel? Choices are:
> > 1) on the commandline: rd_start=0x...
> > 2) a bootparameter block like on i386 or sparc in head.S
> > 3) rely on the kernel to identify if a radisk has
> >   been loaded by a magic number
> > 
> > I'd prefer (1) but it seems none of the other arches does this. Is there
> > a reason for that? If not could we just introduce a new kernel
> > commandline parameter rd_start which has a memory address as a
> > parameter. Ralf, would you let this into the kernel?
> 
> I would do 1+3 - Give the address on the command line and let the ramdisk
> have a magic + length in the first 2 __u32.
I implemented (1) only since the kernel checks for a proper fs/gzip
magic anyway. I added this to the kernels at:
 http://honk.physik.uni-konstanz.de/linux-mips/kernels/
Patch is at:
 http://honk.physik.uni-konstanz.de/linux-mips/kernel-patches/ramdisk-cmdline-2002-05-09.diff
Regards,
 -- Guido
