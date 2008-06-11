Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2008 18:15:33 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:32490 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20021988AbYFKRPb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jun 2008 18:15:31 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5BHF9Tn023147;
	Wed, 11 Jun 2008 18:15:09 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5BHF2Ab022966;
	Wed, 11 Jun 2008 18:15:02 +0100
Date:	Wed, 11 Jun 2008 18:15:02 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Daniel Jacobowitz <drow@false.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] mips: Remove obsolete isa_slot_offset
Message-ID: <20080611171502.GC30400@linux-mips.org>
References: <Pine.LNX.4.55.0806091655480.26593@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0806091655480.26593@cliff.in.clinika.pl>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 09, 2008 at 05:19:53PM +0100, Maciej W. Rozycki wrote:

>  The isa_slot_offset variable and its __ISA_IO_base macro is not used
> anywhere anymore.  It does not look like a decent interface per today's
> standards either.  Remove both including all places of initialization.

Queued for 2.6.27, thanks.

   Ralf
