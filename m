Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6PLX7n00793
	for linux-mips-outgoing; Wed, 25 Jul 2001 14:33:07 -0700
Received: from myth1.Stanford.EDU (myth1.Stanford.EDU [171.64.15.14])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6PLX3O00787
	for <linux-mips@oss.sgi.com>; Wed, 25 Jul 2001 14:33:03 -0700
Received: (from johnd@localhost)
	by myth1.Stanford.EDU (8.11.1/8.11.1) id f6PLWqH29366;
	Wed, 25 Jul 2001 14:32:52 -0700 (PDT)
Date: Wed, 25 Jul 2001 14:32:52 -0700 (PDT)
From: "John D. Davis" <johnd@Stanford.EDU>
To: Debian MIPS list <debian-mips@lists.debian.org>,
   SGI MIPS list <linux-mips@oss.sgi.com>
Subject: Replacing the Console driver
Message-ID: <Pine.GSO.4.31.0107251427180.21227-100000@myth1.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I am modifying the linux kernel to be able to be run by a simulator.  I
need to modify the console driver and interrupt handler.  I have been
going through the various files, console.*, tty.* and the serial files to
see how to interface to the console.  I have also read some kernel korner
articles, but they seem a little out of date.  Is there any other
recommended documentation on the console driver and how it works on an
indy? I am trying to sort out the low-level interfaces from the
higher-level ones.  I just need to change the low-level interface from
using the hardware to using the simulator interface.

thanks,
john
