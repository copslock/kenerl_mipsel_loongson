Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g75AfGRw003622
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 5 Aug 2002 03:41:16 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g75AfGBQ003621
	for linux-mips-outgoing; Mon, 5 Aug 2002 03:41:16 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft18-f80.dialo.tiscali.de [62.246.18.80])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g75Af8Rw003612
	for <linux-mips@oss.sgi.com>; Mon, 5 Aug 2002 03:41:10 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g75AfsP06441;
	Mon, 5 Aug 2002 12:41:54 +0200
Date: Mon, 5 Aug 2002 12:41:54 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@oss.sgi.com
Subject: Re: [patch] 2.4: Revert interface removal
Message-ID: <20020805124154.B6365@dea.linux-mips.net>
References: <Pine.GSO.3.96.1020805105624.18894C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020805105624.18894C-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Aug 05, 2002 at 11:05:40AM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Aug 05, 2002 at 11:05:40AM +0200, Maciej W. Rozycki wrote:

>  A recent change to include/asm-mips/scatterlist.h broke
> drivers/scsi/dec_esp.c.  Since 2.4.19 is not the proper version to remove
> interfaces, I'm going to check in the following patch to the 2.4 branch to
> revert the change (with a slightly sanitized type for the dvma_address
> member). 
> 
>  Any objections?

Sorry for simply removing the structure, that was an accident.  The
question why the use of struct mmu_sglist still hasn't been replaced by
newer interfaces stays ...

So please go ahead and commit your patch.

  Ralf
