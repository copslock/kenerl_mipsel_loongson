Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4CLUIwJ013168
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 12 May 2002 14:30:18 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4CLUH6U013167
	for linux-mips-outgoing; Sun, 12 May 2002 14:30:17 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4CLUDwJ013163
	for <linux-mips@oss.sgi.com>; Sun, 12 May 2002 14:30:13 -0700
Received: by gandalf.physik.uni-konstanz.de (Postfix, from userid 501)
	id 4DFD18D35; Sun, 12 May 2002 23:31:52 +0200 (CEST)
Date: Sun, 12 May 2002 23:31:52 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: howto pass ramdisk loaddress to kernel
Message-ID: <20020512233152.A9766@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
References: <20020507123249.A9827@gandalf.physik.uni-konstanz.de> <20020507104538.GB795@paradigm.rfc822.org> <20020510203737.A5410@gandalf.physik.uni-konstanz.de> <20020511183808.GA7240@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020511183808.GA7240@paradigm.rfc822.org>; from flo@rfc822.org on Sat, May 11, 2002 at 08:38:08PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, May 11, 2002 at 08:38:08PM +0200, Florian Lohoff wrote:
> On Fri, May 10, 2002 at 08:37:37PM +0200, Guido Guenther wrote:
> > > I would do 1+3 - Give the address on the command line and let the ramdisk
> > > have a magic + length in the first 2 __u32.
> > I implemented (1) only since the kernel checks for a proper fs/gzip
> > magic anyway. I added this to the kernels at:
> 
> Ok ...
> 
> >  http://honk.physik.uni-konstanz.de/linux-mips/kernels/
> > Patch is at:
> >  http://honk.physik.uni-konstanz.de/linux-mips/kernel-patches/ramdisk-cmdline-2002-05-09.diff
> 
> I looked at the patch and it seems it does support all sub-archs - Is that
> correct ?
It doesn't refer to any subarchitecture specific details so it can be
used by any subarch, yes.
> 
> BTW: When we boot with tip we might also compress the kernel as gzip.
That's also on my todo list for arcboot/tip22 but I'd like to get
bootfloppies fixed first.
 -- Guido
