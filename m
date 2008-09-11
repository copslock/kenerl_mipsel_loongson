Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2008 17:15:58 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:8950 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20188998AbYIKQPx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 11 Sep 2008 17:15:53 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m8BGFpsm018501;
	Thu, 11 Sep 2008 18:15:51 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m8BGFg4E018497;
	Thu, 11 Sep 2008 17:15:51 +0100
Date:	Thu, 11 Sep 2008 17:15:42 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
cc:	ralf@linux-mips.org, Linux MIPS Org <linux-mips@linux-mips.org>
Subject: Re: [PATCH] rb532: do not use phys_t
In-Reply-To: <200809111755.41730.florian@openwrt.org>
Message-ID: <Pine.LNX.4.55.0809111712190.17757@cliff.in.clinika.pl>
References: <200809111755.41730.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 11 Sep 2008, Florian Fainelli wrote:

> MIPS include types.h says that using phys_t is bad, which in
> fact is an unsigned long, so use an unsigned long directly.

 That is bad indeed.  A physical address might not fit in unsigned long.  
Actually the upstream is apparently adopting phys_addr_t for this purpose 
right now, so you might consider waiting with your patch till the thing 
settles down.  Note that by using a generic type you take away semantics 
which will make future adjustments more difficult.

  Maciej
