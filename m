Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9J6brn17747
	for linux-mips-outgoing; Thu, 18 Oct 2001 23:37:53 -0700
Received: from dea.linux-mips.net (a1as03-p59.stg.tli.de [195.252.186.59])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9J6boD17744
	for <linux-mips@oss.sgi.com>; Thu, 18 Oct 2001 23:37:51 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f9J6bd327148;
	Fri, 19 Oct 2001 08:37:39 +0200
Date: Fri, 19 Oct 2001 08:37:39 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Peter Andersson <peter@dark-past.mine.nu>
Cc: linux-mips@oss.sgi.com
Subject: Re: Linux 2.4 kernel with sound support
Message-ID: <20011019083739.A26998@dea.linux-mips.net>
References: <5.1.0.14.0.20011016193856.00a518e0@192.168.1.5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.1.0.14.0.20011016193856.00a518e0@192.168.1.5>; from peter@dark-past.mine.nu on Tue, Oct 16, 2001 at 07:42:38PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Oct 16, 2001 at 07:42:38PM +0200, Peter Andersson wrote:

> Does anyone know where i can find a mips linux 2.4 kernel with audio 
> support? I am running an sgi indy with a R5000 processor, but kernels 
> compiled for R4400 works great.

R4x00 / R5000 difference are very minor.  A sound driver only exists in
ALSA but that one is for a pretty dated kernel; somebody is currently
trying himself on updating it for a current kernel.

  Ralf
