Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Jan 2003 14:15:24 +0000 (GMT)
Received: from p508B5ED1.dip.t-dialin.net ([IPv6:::ffff:80.139.94.209]:31454
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225262AbTAaOPX>; Fri, 31 Jan 2003 14:15:23 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0VEFJY14573;
	Fri, 31 Jan 2003 15:15:19 +0100
Date: Fri, 31 Jan 2003 15:15:19 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Jason Ormes <jormes@wideopenwest.com>
Cc: linux-mips@linux-mips.org
Subject: Re: compiling mips64 problem
Message-ID: <20030131151519.B14518@linux-mips.org>
References: <002801c2c8a6$a41f3470$4437e183@fermi.win.fnal.gov> <20030131105003.B31631@linux-mips.org> <200301310814.51628.jormes@wideopenwest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301310814.51628.jormes@wideopenwest.com>; from jormes@wideopenwest.com on Fri, Jan 31, 2003 at 08:14:51AM -0600
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 31, 2003 at 08:14:51AM -0600, Jason Ormes wrote:

> I went into the linux folder and did a make menuconfig.  I changed the cpu 
> selection to mips64 and went to the kernel hacking section and turned on the 
> are you using a cross compiler option.  exited and saved.
> 
> commands used after that were
> 
> make ARCH=mips64 dep
> make ARCH=mips64 all

make ARCH=mips64 menuconfig

  Ralf
