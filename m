Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2007 04:58:51 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:8644 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20022686AbXIMD6n (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 13 Sep 2007 04:58:43 +0100
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1IVfqg-0007xC-NQ; Thu, 13 Sep 2007 03:58:41 +0000
Message-ID: <46E8B56E.7060705@pobox.com>
Date:	Wed, 12 Sep 2007 23:58:38 -0400
From:	Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sb1250-mac.c: De-typedef, de-volatile, de-etc...
References: <Pine.LNX.4.64N.0709101310030.25038@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0709101310030.25038@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jgarzik@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16487
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
>  Per your request, Andrew, a while ago.  It builds, runs, passes 
> checkpatch.pl and sparse.  No semantic changes.
> 
>  Please apply,
> 
>   Maciej

ACK, but patch does not apply cleanly to netdev-2.6.git#upstream (nor -mm)
