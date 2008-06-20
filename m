Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jun 2008 18:14:13 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:24279 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20041405AbYFTROE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jun 2008 18:14:04 +0100
Received: (qmail 32119 invoked from network); 20 Jun 2008 19:13:59 +0200
Received: from unknown (HELO ?192.168.0.197?) (192.168.0.197)
  by 192.168.0.1 with SMTP; 20 Jun 2008 19:13:59 +0200
Message-ID: <485BE557.8080004@roarinelk.homelinux.net>
Date:	Fri, 20 Jun 2008 19:13:59 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
Organization: Private
User-Agent: Thunderbird 2.0.0.14 (X11/20080620)
MIME-Version: 1.0
To:	Pierre Ossman <drzeus@drzeus.cx>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	sshtylyov@ru.mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] Alchemy: register mmc platform device for db1200/pb1200
 boards.
References: <20080609063521.GA8724@roarinelk.homelinux.net>	<20080609063702.GC8724@roarinelk.homelinux.net>	<20080612090206.GB21601@linux-mips.org>	<20080612101839.GC21601@linux-mips.org>	<20080612121828.GA24603@roarinelk.homelinux.net>	<20080612122646.GA9493@linux-mips.org>	<20080612154248.5c9c5c9d@mjolnir.drzeus.cx>	<20080612134729.GA20015@linux-mips.org>	<20080612135810.GA25352@roarinelk.homelinux.net>	<20080620174607.50ad6874@mjolnir.drzeus.cx>	<20080620161239.GA31688@roarinelk.homelinux.net> <20080620190340.5b1b31c9@mjolnir.drzeus.cx>
In-Reply-To: <20080620190340.5b1b31c9@mjolnir.drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Pierre Ossman wrote:
> On Fri, 20 Jun 2008 18:12:39 +0200
> Manuel Lauss <mano@roarinelk.homelinux.net> wrote:
> 
>> Hello Pierre,
>>
>> On Fri, Jun 20, 2008 at 05:46:07PM +0200, Pierre Ossman wrote:
>>> This patch does not apply against HEAD. Are you sure there aren't any
>>> dependencies on what Ralf has in his tree? If so, perhaps this should
>>> be in the MIPS tree.
>> It was broken by commit dab8c6deaf1d654d09c3de8bd4c286d424df255a which went
>> in this week; here's another updated version of [PATCH 2/8].
>>
> 
> The problem is still Ralf's DMA constants fix. Ralf, should I simply
> steal that patch from you?

Alternatively, Ralf could push patch 2/8 through the MIPS tree; the 
other MMC patches don't depend on it.  Worst case scenario is a that 
db1200 mmc won't work for a few revisions which would go unnoticed with 
99.9% probability, given the state of the rest of the au1000 code ;-)

Manuel Lauss
