Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Mar 2009 14:03:34 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:45749 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20027338AbZC1ODT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 28 Mar 2009 14:03:19 +0000
Received: (qmail 15654 invoked from network); 28 Mar 2009 15:01:54 +0100
Received: from scarran.roarinelk.net (192.168.0.242)
  by fnoeppeil48.netpark.at with SMTP; 28 Mar 2009 15:01:54 +0100
Date:	Sat, 28 Mar 2009 15:03:20 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/6] Alchemy updates for 2.6.30
Message-ID: <20090328150320.37bfd6be@scarran.roarinelk.net>
In-Reply-To: <1237999773-5174-1-git-send-email-mano@roarinelk.homelinux.net>
References: <1237999773-5174-1-git-send-email-mano@roarinelk.homelinux.net>
Organization: Private
X-Mailer: Claws Mail 3.7.1 (GTK+ 2.14.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hallo Ralf,

> #5    I dislike the alchemy/common/platform.c file because it makes passing
>       platform data to drivers ugly (the platdata struct and the consumer
>       are in different files) and I also don't like the fact that every
>       conceivable piece of alchemy hardware has a driver registered whether
>       I like it or not.  To not change existing behaviour, the platform.c
>       file is now invoked by the board Makefiles instead of the one in common/.
> 
> #6    Adds more complete DB1200 support (see patch for more info).

Please ignore patches 5 and 6.  I'm working on a better solution for
the problem #5 is supposed to fix,  and #6 depends on a patch to the
8250 driver which has not received any feedback.

Thanks!

	Manuel Lauss
