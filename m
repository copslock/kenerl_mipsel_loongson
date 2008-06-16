Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2008 01:21:41 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:44275 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20043313AbYFPAVj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Jun 2008 01:21:39 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m5G0LYJR016522;
	Mon, 16 Jun 2008 02:21:34 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m5G0LK8P016510;
	Mon, 16 Jun 2008 01:21:20 +0100
Date:	Mon, 16 Jun 2008 01:21:19 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Daniel Jacobowitz <drow@false.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] sb1250: Initialize io_map_base
In-Reply-To: <20080611171931.GD30400@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0806160113230.11995@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0806091659570.26593@cliff.in.clinika.pl>
 <20080611171931.GD30400@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 11 Jun 2008, Ralf Baechle wrote:

> I split the two siamese twins since the one is only a cleanup while the
> other is 2.6.26 / -stable stuff.

 Both are clean-ups in principle -- if unset .io_map_base is currently
initialized from mips_io_port_base in ioport_map_pci().  Though if you
want to fulfil the promise put there for the -stable branch too...

  Maciej
