Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7NCYBo24572
	for linux-mips-outgoing; Thu, 23 Aug 2001 05:34:11 -0700
Received: from dea.linux-mips.net (u-161-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.161])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7NCY7d24567
	for <linux-mips@oss.sgi.com>; Thu, 23 Aug 2001 05:34:08 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f7NCVi325659
	for linux-mips@oss.sgi.com; Thu, 23 Aug 2001 14:31:44 +0200
Date: Thu, 23 Aug 2001 14:31:44 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: linux-mips@oss.sgi.com
Subject: Re: Patch: don't report rd found when none is there
Message-ID: <20010823143144.C25422@dea.linux-mips.net>
References: <20010823095133.A11435@galadriel.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010823095133.A11435@galadriel.physik.uni-konstanz.de>; from guido.guenther@gmx.net on Thu, Aug 23, 2001 at 09:51:33AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Aug 23, 2001 at 09:51:33AM +0200, Guido Guenther wrote:

> The current code in a/m/k/setup.c assigns __rd_start & __rd_end to
> initrd_start and initrd_end even when no ramdisk was added to the kernel
> image. This gives an "Initial ramdisk at:...." message even though no
> ramdisk is there. Attached patch fixes this. It furthermore prevents
> initrd_{start,end} being overriden(in case it gets set somewhere in the
> board specific code).

Applied,

  Ralf
