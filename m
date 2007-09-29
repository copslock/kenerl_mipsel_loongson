Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Sep 2007 06:18:21 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:2193 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20022757AbXI2FSM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 29 Sep 2007 06:18:12 +0100
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1IbUfK-0007e7-UT; Sat, 29 Sep 2007 05:15:00 +0000
Message-ID: <46FDDF52.1020607@pobox.com>
Date:	Sat, 29 Sep 2007 01:14:58 -0400
From:	Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sb1250-mac.c: De-typedef, de-volatile, de-etc...
References: <Pine.LNX.4.64N.0709101310030.25038@blysk.ds.pg.gda.pl> <46E8B56E.7060705@pobox.com> <Pine.LNX.4.64N.0709131506040.31069@blysk.ds.pg.gda.pl> <20070913151452.GB29665@linux-mips.org> <46E95C7F.1050302@pobox.com> <Pine.LNX.4.64N.0709141135290.1926@blysk.ds.pg.gda.pl> <46F1F2CE.7020300@pobox.com> <Pine.LNX.4.64N.0709201354320.30788@blysk.ds.pg.gda.pl> <46F2A779.2040904@pobox.com> <Pine.LNX.4.64N.0709201829290.30788@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0709201829290.30788@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jgarzik@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgarzik@pobox.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
>  Remove typedefs, volatiles and convert kmalloc()/memset() pairs to
> kcalloc().  Also reformat the surrounding clutter.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---
> On Thu, 20 Sep 2007, Jeff Garzik wrote:
> 
>> Remove the "linux-" prefix.
> 
>  Hmm, it looks like a bad application of `sed' by myself.  Sorry for the 
> noise.
> 
>   Maciej

applied
