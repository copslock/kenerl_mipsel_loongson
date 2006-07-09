Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Jul 2006 19:40:50 +0100 (BST)
Received: from frigate.technologeek.org ([62.4.21.148]:19913 "EHLO
	frigate.technologeek.org") by ftp.linux-mips.org with ESMTP
	id S8133350AbWGISkl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 9 Jul 2006 19:40:41 +0100
Received: by frigate.technologeek.org (Postfix, from userid 1000)
	id 1D5DA1465D70; Sun,  9 Jul 2006 20:40:44 +0200 (CEST)
From:	Julien BLACHE <jblache@debian.org>
To:	linux-mips@linux-mips.org
Cc:	debian-mips@lists.debian.org
Subject: Re: [PATCH] IP22: fix serial console hangs
References: <87irm6naxt.fsf@frigate.technologeek.org>
	<20060709175841.GB24958@deprecation.cyrius.com>
Date:	Sun, 09 Jul 2006 20:40:44 +0200
In-Reply-To: <20060709175841.GB24958@deprecation.cyrius.com> (Martin
	Michlmayr's message of "Sun, 9 Jul 2006 19:58:41 +0200")
Message-ID: <87y7v2liz7.fsf@frigate.technologeek.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <jblache@debian.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jblache@debian.org
Precedence: bulk
X-list: linux-mips

Martin Michlmayr <tbm@cyrius.com> wrote:

> * Julien BLACHE <jblache@debian.org> [2006-07-09 15:51]:
>> The patch below fixes serial console hangs as seen on IP22
>> machines. Typically, while booting, the machine hangs for ~1 minute
>
> Thanks for tracking this down.  You've to send the patch to
> rmk+serial@arm.linux.org.uk and linux-serial@vger.kernel.org
> though.

Done.

JB.

-- 
 Julien BLACHE <jblache@debian.org>  |  Debian, because code matters more 
 Debian & GNU/Linux Developer        |       <http://www.debian.org>
 Public key available on <http://www.jblache.org> - KeyID: F5D6 5169 
 GPG Fingerprint : 935A 79F1 C8B3 3521 FD62 7CC7 CD61 4FD7 F5D6 5169 
