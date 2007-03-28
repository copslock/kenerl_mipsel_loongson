Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2007 16:23:02 +0100 (BST)
Received: from mail.blastwave.org ([147.87.98.10]:44258 "EHLO
	mail.blastwave.org") by ftp.linux-mips.org with ESMTP
	id S20023079AbXC1PXA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Mar 2007 16:23:00 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail.blastwave.org (Postfix) with ESMTP id 0EDCAF98D;
	Wed, 28 Mar 2007 17:22:28 +0200 (MEST)
X-Virus-Scanned: amavisd-new at blastwave.org
Received: from mail.blastwave.org ([127.0.0.1])
	by localhost (enterprise.blastwave.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id iVCguldp+BTy; Wed, 28 Mar 2007 17:22:18 +0200 (MEST)
Received: from unknown (66-132.63-81.stat.fixnetdata.ch [81.63.132.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.blastwave.org (Postfix) with ESMTP id F2A97F97B;
	Wed, 28 Mar 2007 17:22:17 +0200 (MEST)
Date:	Wed, 28 Mar 2007 17:22:16 +0200
From:	Attila Kinali <attila@kinali.ch>
To:	Markus Gothe <markus.gothe@27m.se>
Cc:	linux-mips@linux-mips.org
Subject: Re: Power loss and system time when not having a battery backed RTC
Message-Id: <20070328172216.06552898.attila@kinali.ch>
In-Reply-To: <460A8014.1020100@27m.se>
References: <20070328163914.b7187fcb.attila@kinali.ch>
	<460A8014.1020100@27m.se>
Organization: NERV
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.10.6; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <attila@kinali.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: attila@kinali.ch
Precedence: bulk
X-list: linux-mips

N'abend,

On Wed, 28 Mar 2007 16:47:48 +0200
Markus Gothe <markus.gothe@27m.se> wrote:

> Attila Kinali wrote:
> > How do you handle this issue with the back jumps, if you cannot
> > stick in a batter backed RTC?

> Be creative or use the battery, you could for example set a timestamp
> in a file at shutdown and use it to set the date on power up, alas
> this would be incorrect, so go for the battery.

We cannot stick in a battery as there is not enough space
in the housing of the print (to be exact, we don't have enough
height).

I already thought about storing the last known time somewhere
in the flash. But unfortunately the device can be unplugged
suddenly w/o correct shutdown (actualy this is the normal case).
The only way around this i could came up with was to periodically
store the current time. But this is then a trade off between
jump back period length and how long the flash will last the
continous writes, with no sweet spot that looks good.


Tack och ha det sa bra

				Attila Kinali
-- 
Praised are the Fountains of Shelieth, the silver harp of the waters,
But blest in my name forever this stream that stanched my thirst!
                         -- Deed of Morred
