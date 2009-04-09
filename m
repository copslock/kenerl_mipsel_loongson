Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 16:15:23 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:54408 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20022124AbZDIPPP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Apr 2009 16:15:15 +0100
Received: (qmail 1200 invoked from network); 9 Apr 2009 17:15:14 +0200
Received: from scarran.roarinelk.net (192.168.0.242)
  by fnoeppeil48.netpark.at with SMTP; 9 Apr 2009 17:15:14 +0200
Date:	Thu, 9 Apr 2009 17:15:14 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Kevin Hickey <khickey@rmicorp.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH v3 2/5] Alchemy: Au1300 new interrupt controller
Message-ID: <20090409171514.1d3c1178@scarran.roarinelk.net>
In-Reply-To: <1239287278.5812.6.camel@kh-d820>
References: <1239233768-11927-1-git-send-email-khickey@rmicorp.com>
	<1239233768-11927-2-git-send-email-khickey@rmicorp.com>
	<1239233768-11927-3-git-send-email-khickey@rmicorp.com>
	<20090409120715.1f53f12c@scarran.roarinelk.net>
	<1239287278.5812.6.camel@kh-d820>
Organization: Private
X-Mailer: Claws Mail 3.7.1 (GTK+ 2.14.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Thu, 09 Apr 2009 09:27:58 -0500
Kevin Hickey <khickey@rmicorp.com> wrote:

> To address all of your comments, I wrote this code some time ago and
> have not had time to digest some of the changes that have been posted to
> the DB1200 interrupt code since then.  I have every intention of finding
> some time down the line to revisit this and merge it with the DB1200
> cascade code.  The controllers are very similar - in fact in my local
> tree I am using this same code on both platforms.
> 
> In the interest of time and schedule, I was hoping to have this version
> included in 2.6.30 so that I had something to build on for future
> updates and something to release other driver and peripheral patches
> against.

I see.  I don't have any objections against inclusion if you're going
to fix it later on.

Thanks!
	Manuel Lauss
