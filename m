Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2007 16:54:54 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:29876 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20022325AbXIMPyo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 13 Sep 2007 16:54:44 +0100
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1IVqyZ-0002tZ-BE; Thu, 13 Sep 2007 15:51:31 +0000
Message-ID: <46E95C7F.1050302@pobox.com>
Date:	Thu, 13 Sep 2007 11:51:27 -0400
From:	Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sb1250-mac.c: De-typedef, de-volatile, de-etc...
References: <Pine.LNX.4.64N.0709101310030.25038@blysk.ds.pg.gda.pl> <46E8B56E.7060705@pobox.com> <Pine.LNX.4.64N.0709131506040.31069@blysk.ds.pg.gda.pl> <20070913151452.GB29665@linux-mips.org>
In-Reply-To: <20070913151452.GB29665@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jgarzik@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgarzik@pobox.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Thu, Sep 13, 2007 at 03:13:06PM +0100, Maciej W. Rozycki wrote:
> 
>>  Hmm, works fine with linux-2.6.git#master.  I do not recall any recent 
>> activity with this driver -- I wonder what the difference is.  Let me 
>> see...
> 
> Hmm...  HEAD du jour has no differences for the sb1250-mac between lmo
> and kernel.org.

Net driver patches should apply on top of netdev-2.6.git#upstream, which 
is where changes to net drivers are queued for the next release.

The closer we get to the merge window, the greater the diff between 
netdev-2.6.git#upstream and linux-2.6.git#master, so 
linux-2.6.git#master is not a useful comparison.

	Jeff
