Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3PHRUf08803
	for linux-mips-outgoing; Wed, 25 Apr 2001 10:27:30 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3PHRTM08800
	for <linux-mips@oss.sgi.com>; Wed, 25 Apr 2001 10:27:29 -0700
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f3PHMu029286;
	Wed, 25 Apr 2001 10:22:56 -0700
Message-ID: <3AE70886.AEEC48D3@mvista.com>
Date: Wed, 25 Apr 2001 10:25:26 -0700
From: Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en, bg
MIME-Version: 1.0
To: Wayne Gowcher <wgowcher@yahoo.com>
CC: linux-mips@oss.sgi.com
Subject: Re: serial console, have linefeed but no command prompt
References: <20010425150258.11719.qmail@web11901.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Wayne Gowcher wrote:
> 
> I am trying to bring up a mips based board using the
> serial console outputing to a serial terminal.
> Everything seems to boot OK, I see the various printk
> messages of the kernel booting right up until the
> execve calls in init/main.c init().
> After this point the board stops printing to the
> serial console, but if I hit return at the terminals
> keyboard, the terminal's cursor moves down one line.
> But I still have no command prompt.
> 
> Up until now I have been successfully booting the
> board with the 2.2.13 kernel using nfs as the file
> system. The problem kernel is my attempt at porting
> 2.4.0 test 9 to the same board, using the same nfs.
> 
> I suspect I have a setup problem with the serial
> configuration in the kernel ( not the filesystem since
> 2.2.13 is OK ), maybe it's not selecting the right
> terminal or not directing output correctly ? But I am
> not sure how to fix it and would appreciate any help,
> references to texts that would help me.

I would suggest you first start by loading ash.static or some other
statically compiled shell (boot with "init=/bin/bash or
init=/bin/ash.static, depending on what shell you have) and then go from
there.  If even that doesn't work, try cross compiling a static hello
world and load that as the init (something like "init=/bin/hello").  

What does you /etc/inittab look like?

Pete
