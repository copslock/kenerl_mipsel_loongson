Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9V57bs21601
	for linux-mips-outgoing; Tue, 30 Oct 2001 21:07:37 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9V57Y021598
	for <linux-mips@oss.sgi.com>; Tue, 30 Oct 2001 21:07:34 -0800
Received: from drow by nevyn.them.org with local (Exim 3.32 #1 (Debian))
	id 15ynbY-0004gr-00; Wed, 31 Oct 2001 00:07:56 -0500
Date: Wed, 31 Oct 2001 00:07:56 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Toshiba TX3927 board boot problem.
Message-ID: <20011031000756.A18018@nevyn.them.org>
References: <20011030155533.A28550@dea.linux-mips.net> <20011031.115856.41626992.nemoto@toshiba-tops.co.jp> <20011031050637.B8456@dea.linux-mips.net> <20011031.133011.11593683.nemoto@toshiba-tops.co.jp> <20011031053142.A17909@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011031053142.A17909@dea.linux-mips.net>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Oct 31, 2001 at 05:31:42AM +0100, Ralf Baechle wrote:
> On Wed, Oct 31, 2001 at 01:30:11PM +0900, Atsushi Nemoto wrote:
> 
> > >>>>> On Wed, 31 Oct 2001 05:06:37 +0100, Ralf Baechle <ralf@oss.sgi.com> said:
> > ralf> I don't think there is much point in returning a version number
> > ralf> if there is nothing we could return a version number of.  Well,
> > ralf> maybe the fp emulation sw version or kernel version.  What would
> > ralf> you consider a sensible return value?
> > 
> > The reason of my request is that user-mode gdb reports error on "info
> > reg" command.  "info reg" command shows fsr and fir.
> > 
> > So, I don't care the return value.  I think "0" is enough for FPU-less
> > CPUs.
> 
> Ok, applied.

Thanks; returning 0 is the best GDB can expect here.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
