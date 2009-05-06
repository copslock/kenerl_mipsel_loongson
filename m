Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2009 18:13:53 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:55295 "EHLO
	roarinelk.homelinux.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024451AbZEFRNq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2009 18:13:46 +0100
Received: (qmail 15776 invoked by uid 1000); 6 May 2009 19:13:45 +0200
Date:	Wed, 6 May 2009 19:13:45 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	David VomLehn <dvomlehn@cisco.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] mips:powertv: Make kernel command line size
	configurable (resend)
Message-ID: <20090506171345.GA15719@roarinelk.homelinux.net>
References: <20090504225719.GA22417@cuplxvomd02.corp.sa.net> <20090506163518.GA19624@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090506163518.GA19624@linux-mips.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Wed, May 06, 2009 at 05:35:18PM +0100, Ralf Baechle wrote:
> On Mon, May 04, 2009 at 03:57:19PM -0700, David VomLehn wrote:
> 
> > Most platforms can get by perfectly well with the default command line size,
> > but some platforms need more. This patch allows the command line size to
> > be configured for those platforms that need it. The default remains 256
> > characters.
> > 
> > Signed-off-by: David VomLehn <dvomlehn@cisco.com>
> 
> How big of a command line do you need?  For no scientific reason other
> than there not being any obvious need for a larger size MIPS is using 256
> and I think unless you're asking for a huge number it will be better to
> just raise that constant.

FWIW, I like this change.  For my uses, 512 has been enough for >2 years
now.

	Manuel Lauss
