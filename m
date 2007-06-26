Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2007 14:29:18 +0100 (BST)
Received: from mail.blastwave.org ([147.87.98.10]:37260 "EHLO
	mail.blastwave.org") by ftp.linux-mips.org with ESMTP
	id S20022116AbXFZN3O (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Jun 2007 14:29:14 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail.blastwave.org (Postfix) with ESMTP id A97C0F94A;
	Tue, 26 Jun 2007 15:28:43 +0200 (MEST)
X-Virus-Scanned: amavisd-new at blastwave.org
Received: from mail.blastwave.org ([127.0.0.1])
	by localhost (enterprise.blastwave.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id mC8dw2py9FQB; Tue, 26 Jun 2007 15:28:40 +0200 (MEST)
Received: from aki.intern.liechtiag.ch (66-132.63-81.stat.fixnetdata.ch [81.63.132.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.blastwave.org (Postfix) with ESMTP id 18038F947;
	Tue, 26 Jun 2007 15:28:39 +0200 (MEST)
Date:	Tue, 26 Jun 2007 15:28:38 +0200
From:	Attila Kinali <attila@kinali.ch>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: au1550 ac97 driver
Message-Id: <20070626152838.4c925972.attila@kinali.ch>
In-Reply-To: <20070625131814.GA27621@roarinelk.homelinux.net>
References: <20070625150506.a0cd7f9b.attila@kinali.ch>
	<20070625131814.GA27621@roarinelk.homelinux.net>
Organization: SEELE
X-Mailer: Sylpheed 2.4.0rc (GTK+ 2.10.12; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <attila@kinali.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: attila@kinali.ch
Precedence: bulk
X-list: linux-mips

Moin Manuel,

On Mon, 25 Jun 2007 15:18:14 +0200
Manuel Lauss <mano@roarinelk.homelinux.net> wrote:

> I wrote experimental ALSA ASoC drivers for the Au1200 PSC in AC97
> and I2S mode.  From my limited understanding, the Au1550 PSCs are
> identical to the ones on the Au1200, so the drivers *should* work.
> on the 1550 (All the proper PSC base addresses are already in there;
> all you'd need to do is add code for your board)
> 
> An update to the dbdma api is required to get proper DMA ringbuffers.
> 
> If you're interested, I put 2 patches online:

Thanks a lot, i'll take a look at them.
But unfortunately, the AC97 subproject got preempted by
someething more important, so it will take a while until
i can give you some feedback.

			Attila Kinali

-- 
Praised are the Fountains of Shelieth, the silver harp of the waters,
But blest in my name forever this stream that stanched my thirst!
                         -- Deed of Morred
