Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3MHhoqf006398
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 22 Apr 2002 10:43:50 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3MHhoCL006397
	for linux-mips-outgoing; Mon, 22 Apr 2002 10:43:50 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3MHhmqf006394
	for <linux-mips@oss.sgi.com>; Mon, 22 Apr 2002 10:43:48 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g3MHiHA10227;
	Mon, 22 Apr 2002 10:44:17 -0700
Date: Mon, 22 Apr 2002 10:44:17 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
   Wayne Gowcher <wgowcher@yahoo.com>, Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: Equivalent of ioperm / iopl in linux mips ?
Message-ID: <20020422104417.B10146@dea.linux-mips.net>
References: <Pine.GSO.4.21.0204221654140.17279-100000@vervain.sonytel.be> <Pine.GSO.3.96.1020422170125.7706H-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020422170125.7706H-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Apr 22, 2002 at 05:30:08PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 22, 2002 at 05:30:08PM +0200, Maciej W. Rozycki wrote:

>  Well, for Alpha ioperm/iopl functions check the system type in
> /proc/cpuinfo (we seem to have enough information there as well) and
> failing this they check a result of readlink of /etc/alpha_systype.  Then
> an appropriate region of /dev/mem is mmapped with per-page permissions set
> up as requested if ioperm is used (with a worse granularity, though) and
> subsequent in/out function invocations access the area as appropriate. 
> See sysdeps/unix/sysv/linux/alpha/ioperm.c in glibc for details -- it's a
> pretty clever solution with good performance and only a few trade-offs.

Thanks for volunteering ;)

  Ralf
