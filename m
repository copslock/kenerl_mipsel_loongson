Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3PIcLE12964
	for linux-mips-outgoing; Wed, 25 Apr 2001 11:38:21 -0700
Received: from web11903.mail.yahoo.com (web11903.mail.yahoo.com [216.136.172.187])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f3PIcLM12961
	for <linux-mips@oss.sgi.com>; Wed, 25 Apr 2001 11:38:21 -0700
Message-ID: <20010425183820.95445.qmail@web11903.mail.yahoo.com>
Received: from [209.243.184.191] by web11903.mail.yahoo.com; Wed, 25 Apr 2001 11:38:20 PDT
Date: Wed, 25 Apr 2001 11:38:20 -0700 (PDT)
From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: Re: serial console, have linefeed but no command prompt
To: linux-mips@oss.sgi.com
In-Reply-To: <3AE70886.AEEC48D3@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Pete, Scott,

Thanks for your input.

I tried booting with init=/bin/ash.static and with a
simple "hello world type app". None of them gave me
any output to the serial terminal. I also have console
defined as a boot param :

xxx console=ttyS0 xxx

I tried modifying my /etc/inittab as per Scott's
suggestion, but that also didn't give me any output.

my inittab was :

-----------------------

# Run gettys in standard runlevels
1:12345:respawn:/sbin/mingetty tty1
2:2345:respawn:/sbin/mingetty tty2
3:2345:respawn:/sbin/mingetty tty3
4:2345:respawn:/sbin/mingetty tty4
5:2345:respawn:/sbin/mingetty tty5
6:2345:respawn:/sbin/mingetty tty6

------------------

One further thing I tried was adding a printk( "a" );
in the serial interrupt handler, whenever I hit the
return key, it prints out the "a". So I know the
serial link still works and is at the correct baud
rate etc.

I can use gdb on the board to step through the code
and was thinking that if I knew the path of how the
kernel :

a, receives a key from the serial terminal
b, processes the key 
c, echoes it back to the serial trminal

I may be able to trace the problem. Does anyone know
roughly what functions to set breakpoints in to trace
program flow as shown above ?

Wayne



serial_outc( 

__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - buy the things you want at great prices
http://auctions.yahoo.com/
