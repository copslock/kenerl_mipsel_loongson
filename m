Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5HBWunC015886
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 17 Jun 2002 04:32:56 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5HBWuIc015885
	for linux-mips-outgoing; Mon, 17 Jun 2002 04:32:56 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from kopretinka (mail@p030.as-l025.contactel.cz [212.65.234.30])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5HBWmnC015881
	for <linux-mips@oss.sgi.com>; Mon, 17 Jun 2002 04:32:50 -0700
Received: from ladis by kopretinka with local (Exim 3.35 #1 (Debian))
	id 17Juky-0000EG-00
	for <linux-mips@oss.sgi.com>; Mon, 17 Jun 2002 13:33:12 +0200
Date: Mon, 17 Jun 2002 13:33:11 +0200
To: linux-mips@oss.sgi.com
Subject: DBE/IBE handling incompatibility
Message-ID: <20020617113311.GA839@kopretinka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Ladislav Michl <ladis@psi.cz>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,

i'd like to release GIO64 bus support. Before doing so DBE/IBE handling
should be done in the same fashion for both mips and mips64 (*). Currently
mips is using handler in handler via dbe_board_handler and ibe_board_handler 
which are not used anywhere while mips64 is using BUILD_HANDLER macro defined
in include/asm-mips64/exception.h (see arch/mips64/sgi-ip27/ip27-dbe-glue.S)
Unfortunately I have nearly zero knowledge of MIPS assembler, so I'm
unable to code mips way same as mips64 is... Help from someone more
experienced will be greatly appreciated :-)

(*) How GIO device detection works? each IP22 machine contains three GIO bus
slots. GIO device provides information about itself in first (three) word(s)
of address space it occupies. The only way how to detect GIO card is
trying to read word from it's base address. If DBE exception is generated 
then there is definitely no card present, otherwise read value encodes 
information about device.

	ladis
