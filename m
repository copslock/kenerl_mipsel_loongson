Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6DELDM15014
	for linux-mips-outgoing; Fri, 13 Jul 2001 07:21:13 -0700
Received: from mail.ivivity.com (user-vc8ftn3.biz.mindspring.com [216.135.246.227])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6DEL6V15009
	for <linux-mips@oss.sgi.com>; Fri, 13 Jul 2001 07:21:07 -0700
Received: from [192.168.1.169] (192.168.1.169 [192.168.1.169]) by mail.ivivity.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2448.0)
	id 3GNKV62P; Fri, 13 Jul 2001 10:20:52 -0400
Subject: Re: RFC: run-time defining serial ports
From: Marc Karasek <marc_karasek@ivivity.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <3B4E45D9.8DBE84E7@mvista.com>
References: <3B4E45D9.8DBE84E7@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 13 Jul 2001 10:20:05 -0400
Message-Id: <995034043.1803.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Good idea, I would take it a step further coming at it from a purely
embedded standpoint.  If a option to the kernel could be defined so that
the init code that brings the system up could setup things like the
serial port, etc. and then notify the kernel that the serial port has
been setup with parameters xyz.  All boot monitors (YAMON, PMON,
REDBOOT) initialize the serial port as part of there bootup for use as a
debug monitor, etc.  Why should we have to redo something that is
already taken care of.  Unless there is some case where you want to
reset it, maybe the baud rate is too slow or something.  

I think as linux moves more into the embedded space we will need to deal
with more issues like this.  Where the embedded requirements do not
match with those coming from the desktop/workstation world.  


On 12 Jul 2001 17:50:33 -0700, Jun Sun wrote:
> 
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
> 
> A by-product of this arrangement is that you can configure a kernel for
> multiple machines.
> 
> What do you think?
> 
> Jun
> 
> diff -Nru include/asm-mips/serial.h.orig include/asm-mips/serial.h
> --- include/asm-mips/serial.h.orig      Wed May 16 15:58:29 2001
> +++ include/asm-mips/serial.h   Thu Jul 12 17:06:05 2001
> @@ -271,3 +271,6 @@
>         AU1000_SERIAL_PORT_DEFNS        \
>         DDB5477_SERIAL_PORT_DEFNS
>  
> +#ifnef SERIAL_PORT_DFNS
> +#define RS_TABLE_SIZE          4
> +#endif
--
/*************************
Marc Karasek
Sr. Firmware Engineer
iVivity Inc.
marc_karasek@ivivity.com
(770) 986-8925
(770) 986-8926 Fax
*************************/
