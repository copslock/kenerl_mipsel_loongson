Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jul 2007 15:57:16 +0100 (BST)
Received: from mail.blastwave.org ([147.87.98.10]:24555 "EHLO
	mail.blastwave.org") by ftp.linux-mips.org with ESMTP
	id S20021779AbXGFO5L (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Jul 2007 15:57:11 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail.blastwave.org (Postfix) with ESMTP id 48825F949;
	Fri,  6 Jul 2007 16:56:41 +0200 (MEST)
X-Virus-Scanned: amavisd-new at blastwave.org
Received: from mail.blastwave.org ([127.0.0.1])
	by localhost (enterprise.blastwave.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zl2ZaRQHtqlC; Fri,  6 Jul 2007 16:56:34 +0200 (MEST)
Received: from aki.intern.liechtiag.ch (66-132.63-81.stat.fixnetdata.ch [81.63.132.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.blastwave.org (Postfix) with ESMTP id 39192F8B4;
	Fri,  6 Jul 2007 16:56:34 +0200 (MEST)
Date:	Fri, 6 Jul 2007 16:56:33 +0200
From:	Attila Kinali <attila@kinali.ch>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Au1550 OSS sound driver
Message-Id: <20070706165633.6fa0e688.attila@kinali.ch>
In-Reply-To: <20070706144043.GA23569@linux-mips.org>
References: <20070706144043.GA23569@linux-mips.org>
Organization: SEELE
X-Mailer: Sylpheed 2.4.0rc (GTK+ 2.10.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <attila@kinali.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15637
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: attila@kinali.ch
Precedence: bulk
X-list: linux-mips

Hoi Ralf,

On Fri, 6 Jul 2007 15:40:43 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> Does anybody have convincing arguments why I should *NOT* delete this
> driver?  It's sitting since ages in the lmo repositories, as an OSS
> driver isn't in the shape to be merged upstream, so doesn't receive
> testing by the autobuilders, I don't think I've seen any testers.

I tried to get it working a week or two ago. Yes, that code is rotten
and needs some handwork to even get it compiling. I couldn't get
it working after 3 days after which i have been interrupted by more
important work. 

> Volunters to rewrite this for ALSA?

Manuel Lauss did some work using the ALSA ASoC system.
See 20070625131814.GA27621@roarinelk.homelinux.net 
(subject: Re: au1550 ac97 driver) from a few days ago
on this ml.

				Attila Kinali

-- 
Praised are the Fountains of Shelieth, the silver harp of the waters,
But blest in my name forever this stream that stanched my thirst!
                         -- Deed of Morred
