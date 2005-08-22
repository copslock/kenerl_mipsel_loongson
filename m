Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Aug 2005 11:21:13 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:31005 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225341AbVHVKU5>; Mon, 22 Aug 2005 11:20:57 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j7MAQAf4006262;
	Mon, 22 Aug 2005 11:26:10 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j7MAQAdB006261;
	Mon, 22 Aug 2005 11:26:10 +0100
Date:	Mon, 22 Aug 2005 11:26:10 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050822102610.GB3780@linux-mips.org>
References: <20050820142723Z8225252-3678+7060@linux-mips.org> <Pine.LNX.4.61L.0508221013180.26914@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0508221013180.26914@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 22, 2005 at 10:18:01AM +0100, Maciej W. Rozycki wrote:

> > Log message:
> > 	MT bulletproofing; MT also uses the software interrupts.
> 
>  Well, since they use a different controller structure and different 
> functions, the user-visible name should be different too, shouldn't it?  
> To be original ;-) -- how about "MIPS-MT"?

Thought about but then it's still hammering at the same old bits which
now just have received a different use.

  Ralf
