Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2003 17:37:41 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:57085 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225240AbTDNQhk>;
	Mon, 14 Apr 2003 17:37:40 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h3EGauS15864;
	Mon, 14 Apr 2003 09:36:56 -0700
Date: Mon, 14 Apr 2003 09:36:56 -0700
From: Jun Sun <jsun@mvista.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: [patch] Board bus error handler clean-ups
Message-ID: <20030414093656.G12846@mvista.com>
References: <Pine.GSO.3.96.1030414144912.24742D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1030414144912.24742D-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Apr 14, 2003 at 03:10:02PM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Mon, Apr 14, 2003 at 03:10:02PM +0200, Maciej W. Rozycki wrote:
> Hello,
> 
>  Here is a patch that replaces the current temporary hack for board bus
> error handler initializers with the proper approach allowing platforms to
> install them dynamically, similarly to timer initializers.  It also
> trivially changes the names to follow other patterns. 
> 
>  As a side effect it nukes zillions of empty functions for platforms that
> don't have extra bus error functionality. 
> 
>  OK to apply?
> 
>   Maciej
> 
<snip>

Hew!  This patch makes me breath much better. :)  Thanks.

Jun
