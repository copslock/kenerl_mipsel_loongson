Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6DD0Q612364
	for linux-mips-outgoing; Fri, 13 Jul 2001 06:00:26 -0700
Received: from dea.waldorf-gmbh.de (u-18-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.18])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6DCxdV12315
	for <linux-mips@oss.sgi.com>; Fri, 13 Jul 2001 05:59:43 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6DBhPw01469;
	Fri, 13 Jul 2001 13:43:25 +0200
Date: Fri, 13 Jul 2001 13:43:25 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: RFC: run-time defining serial ports
Message-ID: <20010713134324.D1378@bacchus.dhis.org>
References: <3B4E45D9.8DBE84E7@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B4E45D9.8DBE84E7@mvista.com>; from jsun@mvista.com on Thu, Jul 12, 2001 at 05:50:33PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 12, 2001 at 05:50:33PM -0700, Jun Sun wrote:

> As more and more boards are added to Linux-mips tree, many places are getting
> crowdier and uglier, including serial.h.  The same thing is true for PPC and
> other architectures.
> 
> It turns out an easy solution is to let every board sets the serial port
> definitions at run-time through calling early_serial_setup() routine.
> 
> An easy fix for now is to give a default table size when no serial definition
> is given, which at least reserves some slots in the rs_table array.  See the
> patch below.
> 
> A better solution is probably to provide a config option to define the serial
> table size.

It's needed; I have machines here with upto 11 serial interfaces on a lowly
R4700 box; Origins may have _many_ more.

> A by-product of this arrangement is that you can configure a kernel for
> multiple machines.
> 
> What do you think?

  Ralf
