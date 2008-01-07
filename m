Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jan 2008 17:05:31 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:5866 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28574341AbYAGRF3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 Jan 2008 17:05:29 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m07H57p7012998;
	Mon, 7 Jan 2008 17:05:07 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m07H57VF012997;
	Mon, 7 Jan 2008 17:05:07 GMT
Date:	Mon, 7 Jan 2008 17:05:07 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] SNI_RM: collected changes
Message-ID: <20080107170507.GA12962@linux-mips.org>
References: <20080104223107.4D570C2EF2@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080104223107.4D570C2EF2@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 04, 2008 at 11:31:07PM +0100, Thomas Bogendoerfer wrote:

> - EISA support for non PCI RMs (RM200 and RM400-xxx). The major part
>   is the splitting of the EISA and onboard ISA of the RM200, which
>   makes the EISA bus on the RM200 look like on other RMs.
> - 64bit kernel support
> - system type detection is now common for big and little endian (thanks
>   Ralf)
> - moved sniprom code to arch/mips/fw
> - added call_o32 function to arch/mips/fw/lib, which uses a private
>   stack for calling prom functions
> - fix problem with isa interrupts, which makes using pit clockevent
>   possible
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
> 
> This is 2.6.25 material and replaces [PATCH] SNI_RM: EISA support for 
> A20R/RM200

I dropped this into my -queue and -mm trees.

  Ralf
