Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3RFeGv23202
	for linux-mips-outgoing; Fri, 27 Apr 2001 08:40:16 -0700
Received: from web11902.mail.yahoo.com (web11902.mail.yahoo.com [216.136.172.186])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f3RFeFM23199
	for <linux-mips@oss.sgi.com>; Fri, 27 Apr 2001 08:40:15 -0700
Message-ID: <20010427154015.6297.qmail@web11902.mail.yahoo.com>
Received: from [209.243.184.191] by web11902.mail.yahoo.com; Fri, 27 Apr 2001 08:40:15 PDT
Date: Fri, 27 Apr 2001 08:40:15 -0700 (PDT)
From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: load_elf_binary problems ?
To: linux-mips@oss.sgi.com
In-Reply-To: <20010425150258.11719.qmail@web11901.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Dear All,

I have a problem with load_elf_binary() stalling my
linux 2.4.0-test9 kernel. Through the use of printk's
I have traced program flow all the way up to a call to
clear_user( (void *) elf_bss, nbyte ), called from
binfmt_elf.c padzero(). A printk immediately after
this fucntion call never gets printed out to the
serial console.

I said stall above because although the machine
appears to "hang", it will still print out to the
serial console on receiving a character over the
serial port - I have a printk( "+" ) in the serial
interrupt.

I looked into clear_user() and see that it makes a
call to " __bzero ". From a preliminary search on the
web I think __bzero is a library function and so not
defined in the kernel ( tried searching kernel sources
too ).

If __bzero is a library function, my first thoughts
would be to suspect it and the library that contains
it. But I have successfully compiled and ran a
2.4.0-test9 kernel for ANOTHER mips development board
using the same compiler libraries etc. The variable in
this case seems to be my port not the supporting
tools.

What I would like to know are :

a, are there any docs explaining __bzero, or could
someone explain what it does.

b, does anyone have any idea why clear_user would hang
like this ? eg not set up memory correctly etc etc

c, any tips for looking into the problem and tracking
down the cause

TIA

Wayne

__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - buy the things you want at great prices
http://auctions.yahoo.com/
