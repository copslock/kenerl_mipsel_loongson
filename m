Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAO1RSB26972
	for linux-mips-outgoing; Fri, 23 Nov 2001 17:27:28 -0800
Received: from holomorphy (mail@holomorphy.com [216.36.33.161])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAO1RPo26968
	for <linux-mips@oss.sgi.com>; Fri, 23 Nov 2001 17:27:25 -0800
Received: from wli by holomorphy with local (Exim 3.31 #1 (Debian))
	id 167Qf0-0003BM-00
	for <linux-mips@oss.sgi.com>; Fri, 23 Nov 2001 16:27:10 -0800
Date: Fri, 23 Nov 2001 16:27:10 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-mips@oss.sgi.com
Subject: advice on dz.c
Message-ID: <20011123162710.D1048@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Organization: The Domain of Holomorphy
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

startup() in the 2.4.14 dz.c appears to either not terminate or to
bring down the kernel on a DecStation 5000/200. The 2.4.5 dz.c when
put it in its place appears to work properly, modulo some strangeness
in terminal emulation at runtime.

Unfortunately, attempts to isolate what difference creates the problem
failed to reveal the true cause of this. The kernel appears to die
immediately after restore_flags(). This appears unusual to me as the
changes are largely cosmetic.

I also tried extending the extent of the code over which interrupts
are disabled, to no avail. After extending it to what apparently was
the entire extent of the driver's ->open code the kernel died somewhere
between enabling interrupts again and the printk immediately after
the return to tty_open(). It did not appear that the driver was
re-entered at this point, as printk's for the other entry points
failed to trigger.


I am interested in suggestions as to what code changes I should make
in order to bring this driver into a more robust state so that I myself
can repair the code for use on one of my own personal machines.


Thanks,
Bill
