Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2PL6Bg24349
	for linux-mips-outgoing; Sun, 25 Mar 2001 13:06:11 -0800
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2PL6AM24346
	for <linux-mips@oss.sgi.com>; Sun, 25 Mar 2001 13:06:10 -0800
Received: from bilbo.physik.uni-konstanz.de [134.34.144.81] (8)
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 14hHiD-0005SM-00; Sun, 25 Mar 2001 23:06:09 +0200
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 14hHiC-0000sw-00; Sun, 25 Mar 2001 23:06:08 +0200
Date: Sun, 25 Mar 2001 23:06:08 +0200
From: Guido Guenther <guido.guenther@gmx.net>
To: linux-mips@oss.sgi.com
Subject: current cvs kernel doesn't work with egcs 1.1.2/binutils 2.8.1
Message-ID: <20010325230608.A2867@bilbo.physik.uni-konstanz.de>
Mail-Followup-To: linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

it fails with an unaligned access in emulate_load_store_insn (368)
on an Indy/R4600 while doing:
 kmem_cache_create -> down -> __down -> add_wait_queue 
 -> __add_wait_queue -> list_add -> __list_add
it works with the gcc 3.0/binutils 2.11.90 from oss though.
 -- Guido
