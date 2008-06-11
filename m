Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2008 18:19:54 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:12426 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20021578AbYFKRTw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jun 2008 18:19:52 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5BHJVam024840;
	Wed, 11 Jun 2008 18:19:31 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5BHJVTr024833;
	Wed, 11 Jun 2008 18:19:31 +0100
Date:	Wed, 11 Jun 2008 18:19:31 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Daniel Jacobowitz <drow@false.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] sb1250: Initialize io_map_base
Message-ID: <20080611171931.GD30400@linux-mips.org>
References: <Pine.LNX.4.55.0806091659570.26593@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0806091659570.26593@cliff.in.clinika.pl>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 09, 2008 at 05:20:03PM +0100, Maciej W. Rozycki wrote:

>  Correctly initialize io_map_base for the SB1250 PCI controller as
> required for proper iomap support.  Based on a proposal from Daniel
> Jacobowitz.

Applied.

>  This is the second half of a set of two changes resulting from my
> investigation of how proper iomap support should be done for the SB1250 in
> response to a report from Daniel.  This patch has to be applied on top of
> the first half.  Tested successfully with a SWARM board and a pair of

I split the two siamese twins since the one is only a cleanup while the
other is 2.6.26 / -stable stuff.

  Ralf
