Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7CBgiRw002862
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 12 Aug 2002 04:42:44 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7CBgiIv002861
	for linux-mips-outgoing; Mon, 12 Aug 2002 04:42:44 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7CBgdRw002852
	for <linux-mips@oss.sgi.com>; Mon, 12 Aug 2002 04:42:40 -0700
Received: from merry.physik.uni-konstanz.de (merry.physik.uni-konstanz.de [134.34.144.91])
	by gandalf.physik.uni-konstanz.de (Postfix) with ESMTP
	id CD2D98D35; Mon, 12 Aug 2002 13:45:01 +0200 (CEST)
Received: from agx by merry.physik.uni-konstanz.de with local (Exim 3.35 #1 (Debian))
	id 17eDd7-00082T-00; Mon, 12 Aug 2002 13:45:01 +0200
Date: Mon, 12 Aug 2002 13:45:01 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Ladislav Michl <ladis@psi.cz>
Cc: linux-mips@oss.sgi.com
Subject: GIO bus ids on different machines
Message-ID: <20020812114501.GA30885@merry>
Mail-Followup-To: Ladislav Michl <ladis@psi.cz>, linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,
/proc/gio gives weird results on the SGI systems I could check:
- busid 0x04 in slot GFX for Indy with XL(newport) card
- busid 0x04 in slot GFX for an Indy *without* any graphics hardware
- busid 0x3f in slot GFX and 0x04 in EXP0 for a I2 with a single XZ
  board
- busid 0x3f in slot GFX and 0x04 in EXP0 for a I2 *without* any graphics
  hardware
- busid 0x3f in slot GFX and 0x00 in EXP0 for a I2 with an Elan as
  primary and XZ as secondary card
What worries me most is that it doesn't seem to matter if there's
hardware in a GIO slot or not - it reports the same busid - which screws
the GIO bus handling in the X-server completely.
 -- Guido
