Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4D1qiW14517
	for linux-mips-outgoing; Sat, 12 May 2001 18:52:44 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4D1qiF14514
	for <linux-mips@oss.sgi.com>; Sat, 12 May 2001 18:52:44 -0700
Received: from galt.foobazco.org (galt.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP id AFDF7F1A9
	for <linux-mips@oss.sgi.com>; Sat, 12 May 2001 18:51:36 -0700 (PDT)
Received: by galt.foobazco.org (Postfix, from userid 1014)
	id 64B301F42B; Sat, 12 May 2001 18:52:11 -0700 (PDT)
Date: Sat, 12 May 2001 18:52:11 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: linux-mips@oss.sgi.com
Subject: SGI O2 Port
Message-ID: <20010512185211.C3092@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

I'd like to encourage anyone interested in an SGI O2 port to try my
current CVS tree.  I have successfully reached userland with this
tree.  If you have an O2, please try this and let me know how it goes,
then send patches for all the broken stuff.

Note: This is a 64-bit port.  You will need a mips64 toolchain to
compile.

Known problems:

- Without CONFIG_UNCACHED, the PCI devices don't work properly
- Userland console I/O is very slow and seems unreliable
- Onboard ethernet isn't yet supported; you'll need a PCI one
- Serial console only at this time
- The disks probably work, but I haven't really tested them

Links

Boot log: http://foobazco.org/~wesolows/o2.txt
Toolchain: ftp://oss.sgi.com/pub/linux/mips/mips-linux/simple/crossdev
Sources: :pserver:cvs@cvs.foobazco.org:/g/cvs mod linux pass cvs

Thanks: 

- Harald Koerfgen, for starting the 32-bit port.  Some of his code
still remains.

- Nick Brisebois, for the loan of an O2, assistance with
documentation, and lots of other stuff.

- The usual suspects, for providing the basis for all this.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"Nothing motivates a man more than to see his boss put
	 in an honest day's work." -- The fortune file
