Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3LN7Ns20712
	for linux-mips-outgoing; Sat, 21 Apr 2001 16:07:23 -0700
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3LN7MM20709
	for <linux-mips@oss.sgi.com>; Sat, 21 Apr 2001 16:07:22 -0700
Received: from bilbo.physik.uni-konstanz.de [134.34.144.81] (8)
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 14r6TI-0003Gf-00; Sun, 22 Apr 2001 01:07:20 +0200
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 14r6TI-0000MX-00; Sun, 22 Apr 2001 01:07:20 +0200
Date: Sun, 22 Apr 2001 01:07:20 +0200
From: Guido Guenther <guido.guenther@gmx.net>
To: linux-mips@oss.sgi.com
Subject: loadable kernel modules
Message-ID: <20010422010720.A1386@bilbo.physik.uni-konstanz.de>
Mail-Followup-To: linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,
could someone enlighten me about the current status of loadable modules?
When using current cvs kernel & cvs binutils and Keith's
gcc-3.0-20010303 as crosstoolchain I'm no longer seeing the "symbol xy
with index 10 exceeds local_symtab_size..." but therefore I'm getting
lot's of unresolved symbols(e.g. printk) when trying to insmod a module.
Any help appreciated,
 -- Guido
