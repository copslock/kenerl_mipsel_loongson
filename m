Received:  by oss.sgi.com id <S553925AbRBXBym>;
	Fri, 23 Feb 2001 17:54:42 -0800
Received: from sovereign.org ([209.180.91.170]:6272 "EHLO lux.homenet")
	by oss.sgi.com with ESMTP id <S553720AbRBXByT>;
	Fri, 23 Feb 2001 17:54:19 -0800
Received: (from jfree@localhost)
	by lux.homenet (8.11.2/8.11.2/Debian 8.11.2-1) id f1N8GPH05776
	for linux-mips@oss.sgi.com; Fri, 23 Feb 2001 01:16:25 -0700
From:   Jim Freeman <jfree@sovereign.org>
Date:   Fri, 23 Feb 2001 01:16:25 -0700
To:     linux-mips@oss.sgi.com
Subject: Redundant Configure.help entries?
Message-ID: <20010223011625.A5748@sovereign.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

mips.cvs/Documentation/Configure.help has redundant
CONFIG_DDB5074 entries ??

	Support for NEC DDB Vrc-5074
	CONFIG_DDB5074
	  This enables support for the VR5000-based NEC DDB Vrc-5074
	  evaluation board.

	Support for NEC DDB Vrc-5476
	CONFIG_DDB5476
	  This enables support for the R5432-based NEC DDB Vrc-5476
	  evaluation board.

	  Features : kernel debugging, serial terminal, NFS root fs, on-board
	  ether port (with a patch to tulip driver), IDE controller,
	  PS2 keyboard, PS2 mouse, etc.

	  TODO : USB, Compact-PCI interface.

	Support for MIPS Atlas board
	CONFIG_DDB5074
	  This enables support for the QED R5231-based MIPS Atlas evaluation
	  board.

	Support for MIPS Malta board
	CONFIG_DDB5074
	  This enables support for the VR5000-based MIPS Malta evaluation
	  board.
