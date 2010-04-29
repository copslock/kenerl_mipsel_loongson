Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Apr 2010 09:37:26 +0200 (CEST)
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:37057 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491196Ab0D2HhX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Apr 2010 09:37:23 +0200
Received: id: bigeasy by Chamillionaire.breakpoint.cc with local
        (easymta 1.00 BETA 1)
        id 1O7OJF-0002B1-SK; Thu, 29 Apr 2010 09:37:21 +0200
Date:   Thu, 29 Apr 2010 09:37:21 +0200
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mips/traps: use CKSEG1ADDR for uncache handler
Message-ID: <20100429073721.GA8353@Chamillionaire.breakpoint.cc>
References: <20100427205330.GA1390@Chamillionaire.breakpoint.cc>
 <1272469522.26380.15.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1272469522.26380.15.camel@localhost>
X-Key-Id: FE3F4706
X-Key-Fingerprint: FFDA BBBB 3563 1B27 75C9  925B 98D5 5C1C FE3F 4706
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <sebastian@breakpoint.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sebastian@breakpoint.cc
Precedence: bulk
X-list: linux-mips

* Wu Zhangjin | 2010-04-28 23:45:22 [+0800]:

>Just tested it in 32bit and 64bit kernel on my YeeLoong netbook, both of
>them work well.
The interresting part is what happens on IP27.

>BTW: there is another patch[1] sent to this mailing list Yesterday,
>differ from your method, it tries to provide a TO_UNCAC() for 32bit
>kernel, but seems yours is lighter.

I haven't seen much users of TO_UNCAC() in tree so I wasn't sure what
the parameter of TO_UNCAC() can/should be.

>Regards,
>	Wu Zhangjin
>

Sebastian
