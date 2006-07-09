Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Jul 2006 19:37:29 +0100 (BST)
Received: from frigate.technologeek.org ([62.4.21.148]:18633 "EHLO
	frigate.technologeek.org") by ftp.linux-mips.org with ESMTP
	id S8133348AbWGIShU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 9 Jul 2006 19:37:20 +0100
Received: by frigate.technologeek.org (Postfix, from userid 1000)
	id 8F7461465D70; Sun,  9 Jul 2006 20:37:22 +0200 (CEST)
From:	Julien BLACHE <jblache@debian.org>
To:	Kumba <kumba@gentoo.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] IP22: fix serial console hangs
References: <87irm6naxt.fsf@frigate.technologeek.org>
	<44B13F02.5020002@gentoo.org>
Date:	Sun, 09 Jul 2006 20:37:21 +0200
In-Reply-To: <44B13F02.5020002@gentoo.org> (kumba@gentoo.org's message of
	"Sun, 09 Jul 2006 13:38:10 -0400")
Message-ID: <877j2mmxpa.fsf@frigate.technologeek.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <jblache@debian.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jblache@debian.org
Precedence: bulk
X-list: linux-mips

Kumba <kumba@gentoo.org> wrote:

Hi,

> Out of curiosity, don't suppose you've seen the oops on IP22 that can
> sometimes be triggered by closing the serial client on another box?

Haven't seen this one, no. I'm using a hardware console on the serial
line most of the time (though I still haven't found the proper
configuration and it's hardly usable for anything advanced making use
of terminal features).

> Haven't investigated it too much, but I've seen the odd case on Indy
> and IP28 (which also uses the zilog driver) where shutting down my
> serial client or sometimes rebooting the system running the client
> oopses the driver.  I suspect some rogue data gets passed that zilog
> doesn't know how to handle properly.

It looks a bit like the serial driver crash on reboot which Martin
Michlmayr fixed a couple of months back by backporting fixes from the
sunzilog driver. But I think this one made its way into the kernel, so
it must be something else.

JB.

-- 
 Julien BLACHE <jblache@debian.org>  |  Debian, because code matters more 
 Debian & GNU/Linux Developer        |       <http://www.debian.org>
 Public key available on <http://www.jblache.org> - KeyID: F5D6 5169 
 GPG Fingerprint : 935A 79F1 C8B3 3521 FD62 7CC7 CD61 4FD7 F5D6 5169 
