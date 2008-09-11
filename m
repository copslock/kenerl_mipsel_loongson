Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2008 17:21:46 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:39158 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20303448AbYIKQVm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 11 Sep 2008 17:21:42 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m8BGISvH018526;
	Thu, 11 Sep 2008 18:18:28 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m8BGHoKp018519;
	Thu, 11 Sep 2008 17:17:59 +0100
Date:	Thu, 11 Sep 2008 17:17:50 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Jeremy Fitzhardinge <jeremy@goop.org>
cc:	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ingo Molnar <mingo@elte.hu>,
	Alex Nixon <alex.nixon@citrix.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/3] Globally defining phys_addr_t
In-Reply-To: <48C941FA.50500@goop.org>
Message-ID: <Pine.LNX.4.55.0809111716260.17757@cliff.in.clinika.pl>
References: <48C8D76B.10901@goop.org> <Pine.LNX.4.64.0809111202560.1545@anakin>
 <48C941FA.50500@goop.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 11 Sep 2008, Jeremy Fitzhardinge wrote:

> > If I'm not mistaking, this is also true for some MIPS machines.
> >   
> 
> Nothing turns up in a grep over arch/mips and include/asm-mips.

 It's called phys_t for MIPS.  It's time to make it consistent probably.

  Maciej
