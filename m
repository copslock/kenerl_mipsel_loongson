Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 05:11:09 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:28295 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20023181AbXITELA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Sep 2007 05:11:00 +0100
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1IYDNP-0003Sf-Oe; Thu, 20 Sep 2007 04:10:56 +0000
Message-ID: <46F1F2CE.7020300@pobox.com>
Date:	Thu, 20 Sep 2007 00:10:54 -0400
From:	Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sb1250-mac.c: De-typedef, de-volatile, de-etc...
References: <Pine.LNX.4.64N.0709101310030.25038@blysk.ds.pg.gda.pl> <46E8B56E.7060705@pobox.com> <Pine.LNX.4.64N.0709131506040.31069@blysk.ds.pg.gda.pl> <20070913151452.GB29665@linux-mips.org> <46E95C7F.1050302@pobox.com> <Pine.LNX.4.64N.0709141135290.1926@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0709141135290.1926@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jgarzik@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16564
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
> On Thu, 13 Sep 2007, Jeff Garzik wrote:
> 
>> Net driver patches should apply on top of netdev-2.6.git#upstream, which is
>> where changes to net drivers are queued for the next release.
> 
>  I can see Andrew has done some changes to the patch and applied it 
> anyway, but here's a version I generated against your tree.  Please feel 
> free to choose either.
> 
>  You may be pleased (or less so) to hear that the version of sb1250-mac.c 
> in your tree does not even build (because of 
> 42d53d6be113f974d8152979c88e1061b953bd12) and the patch below does not 
> address it.  I ran out of time in the evening, but I will send you a fix 
> shortly.  To be honest I think even with bulk changes it may be worth 
> checking whether they do not break stuff. ;-)

hrm.  I cannot get this to apply on top of linux-2.6.git, 
netdev-2.6.git#upstream (prior to net-2.6.24 rebase) or 
netdev-2.6.git#upstream (after net-2.6.24 rebase)

ACK the changes
