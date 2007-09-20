Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 05:15:16 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:4530 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20023257AbXITEO5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Sep 2007 05:14:57 +0100
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1IYDOF-0003TL-7N; Thu, 20 Sep 2007 04:11:47 +0000
Message-ID: <46F1F302.4050905@pobox.com>
Date:	Thu, 20 Sep 2007 00:11:46 -0400
From:	Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NET_SB1250_MAC: Rename to SB1250_MAC
References: <Pine.LNX.4.64N.0709141158010.1926@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0709141158010.1926@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jgarzik@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgarzik@pobox.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
>  Rename NET_SB1250_MAC to SB1250_MAC to follow the convention.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---
>  The NET prefix seems to be used mainly for device groups (NET_ISA, 
> NET_VENDOR_*, etc.) rather than single drivers and adds no information.  I 
> suggest it to be removed.
> 
>  Depends on "patch-netdev-2.6.23-rc6-20070913-sb1250-mac-kconfig-0".

applied
