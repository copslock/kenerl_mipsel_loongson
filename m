Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 May 2010 21:30:21 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:39056 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491848Ab0EXTaO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 May 2010 21:30:14 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1OGdLm-0007A6-00; Mon, 24 May 2010 21:30:10 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id 6AEE91D441; Mon, 24 May 2010 21:29:45 +0200 (CEST)
Date:   Mon, 24 May 2010 21:29:45 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Tom McAvaney <tjmcavaney@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: SGI Indy - HAL2 digital audio
Message-ID: <20100524192945.GA8306@alpha.franken.de>
References: <AANLkTilyX-Aaxbpok3qh_qr-VGbVyL5ltNkqVZsvuzmU@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTilyX-Aaxbpok3qh_qr-VGbVyL5ltNkqVZsvuzmU@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Sun, May 23, 2010 at 10:04:59PM +1000, Tom McAvaney wrote:
> Perhaps as a first step, can someone confirm whether pcm digital audio
> is working on the HAL2?

analog input and output is all what works right now with HAL2. The DMA
portion for digital input/ouput would be very similair, but what's
missing is programming of the interface chip.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
