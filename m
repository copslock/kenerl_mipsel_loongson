Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9V4WBD20722
	for linux-mips-outgoing; Tue, 30 Oct 2001 20:32:11 -0800
Received: from dea.linux-mips.net (a1as08-p246.stg.tli.de [195.252.188.246])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9V4W7020719
	for <linux-mips@oss.sgi.com>; Tue, 30 Oct 2001 20:32:07 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f9V4Vh917943;
	Wed, 31 Oct 2001 05:31:43 +0100
Date: Wed, 31 Oct 2001 05:31:42 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: carstenl@mips.com, ahennessy@mvista.com, ajob4me@21cn.com,
   linux-mips@oss.sgi.com
Subject: Re: Toshiba TX3927 board boot problem.
Message-ID: <20011031053142.A17909@dea.linux-mips.net>
References: <20011030155533.A28550@dea.linux-mips.net> <20011031.115856.41626992.nemoto@toshiba-tops.co.jp> <20011031050637.B8456@dea.linux-mips.net> <20011031.133011.11593683.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011031.133011.11593683.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Wed, Oct 31, 2001 at 01:30:11PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Oct 31, 2001 at 01:30:11PM +0900, Atsushi Nemoto wrote:

> >>>>> On Wed, 31 Oct 2001 05:06:37 +0100, Ralf Baechle <ralf@oss.sgi.com> said:
> ralf> I don't think there is much point in returning a version number
> ralf> if there is nothing we could return a version number of.  Well,
> ralf> maybe the fp emulation sw version or kernel version.  What would
> ralf> you consider a sensible return value?
> 
> The reason of my request is that user-mode gdb reports error on "info
> reg" command.  "info reg" command shows fsr and fir.
> 
> So, I don't care the return value.  I think "0" is enough for FPU-less
> CPUs.

Ok, applied.

  Ralf
