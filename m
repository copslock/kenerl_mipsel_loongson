Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9V47Qo20148
	for linux-mips-outgoing; Tue, 30 Oct 2001 20:07:26 -0800
Received: from dea.linux-mips.net (a1as08-p246.stg.tli.de [195.252.188.246])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9V47L020145
	for <linux-mips@oss.sgi.com>; Tue, 30 Oct 2001 20:07:21 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f9V46bB08579;
	Wed, 31 Oct 2001 05:06:37 +0100
Date: Wed, 31 Oct 2001 05:06:37 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: carstenl@mips.com, ahennessy@mvista.com, ajob4me@21cn.com,
   linux-mips@oss.sgi.com
Subject: Re: Toshiba TX3927 board boot problem.
Message-ID: <20011031050637.B8456@dea.linux-mips.net>
References: <3BDDF193.B6405A7F@mvista.com> <3BDE62B4.BE7A1885@mips.com> <20011030155533.A28550@dea.linux-mips.net> <20011031.115856.41626992.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011031.115856.41626992.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Wed, Oct 31, 2001 at 11:58:56AM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Oct 31, 2001 at 11:58:56AM +0900, Atsushi Nemoto wrote:

> ralf> So here is a preliminiary version of my patch.  Still untested
> ralf> and needs to be applied to mips64 also.
> 
> Thank you.  This patch works fine for me.
> 
> One request: with this patch, a ptrace call for FPC_EIR returns error
> on FPU-less CPUs.  The call can be handled without error (as for other
> FP registers).

I don't think there is much point in returning a version number if there is
nothing we could return a version number of.  Well, maybe the fp emulation
sw version or kernel version.  What would you consider a sensible return
value?

  Ralf
