Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3PF2wb04036
	for linux-mips-outgoing; Wed, 25 Apr 2001 08:02:58 -0700
Received: from web11901.mail.yahoo.com (web11901.mail.yahoo.com [216.136.172.185])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f3PF2wM04033
	for <linux-mips@oss.sgi.com>; Wed, 25 Apr 2001 08:02:58 -0700
Message-ID: <20010425150258.11719.qmail@web11901.mail.yahoo.com>
Received: from [209.243.184.191] by web11901.mail.yahoo.com; Wed, 25 Apr 2001 08:02:58 PDT
Date: Wed, 25 Apr 2001 08:02:58 -0700 (PDT)
From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: serial console, have linefeed but no command prompt
To: linux-mips@oss.sgi.com
In-Reply-To: <3AE6A795.1080004@jungo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I am trying to bring up a mips based board using the
serial console outputing to a serial terminal.
Everything seems to boot OK, I see the various printk
messages of the kernel booting right up until the
execve calls in init/main.c init(). 
After this point the board stops printing to the
serial console, but if I hit return at the terminals
keyboard, the terminal's cursor moves down one line.
But I still have no command prompt.

Up until now I have been successfully booting the
board with the 2.2.13 kernel using nfs as the file
system. The problem kernel is my attempt at porting
2.4.0 test 9 to the same board, using the same nfs.

I suspect I have a setup problem with the serial
configuration in the kernel ( not the filesystem since
2.2.13 is OK ), maybe it's not selecting the right
terminal or not directing output correctly ? But I am
not sure how to fix it and would appreciate any help,
references to texts that would help me.

Wayne


__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - buy the things you want at great prices
http://auctions.yahoo.com/
