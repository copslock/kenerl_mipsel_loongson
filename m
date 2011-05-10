Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 May 2011 17:28:22 +0200 (CEST)
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:43563 "EHLO bues.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491819Ab1EJP2S (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 10 May 2011 17:28:18 +0200
Received: by bues.ch with esmtpsa (Exim 4.69)
        (envelope-from <m@bues.ch>)
        id 1QJor7-00016V-Ul; Tue, 10 May 2011 17:28:14 +0200
Subject: Re: [PATCH 1/5] ssb: Change fallback sprom to callback mechanism.
From:   Michael =?ISO-8859-1?Q?B=FCsch?= <m@bues.ch>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>, linux-mips@linux-mips.org,
        Michael Buesch <mb@bu3sch.de>, netdev@vger.kernel.org,
        Florian Fainelli <florian@openwrt.org>
In-Reply-To: <20110510152711.GA26759@linux-mips.org>
References: <1304771263-10937-1-git-send-email-hauke@hauke-m.de>
         <1304771263-10937-2-git-send-email-hauke@hauke-m.de>
         <BANLkTinV+cuTr2cPvR2pBDE_C-2J4KwWcA@mail.gmail.com>
         <20110510152711.GA26759@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 10 May 2011 17:28:06 +0200
Message-ID: <1305041286.29322.2.camel@maggie>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Content-Transfer-Encoding: 7bit
Return-Path: <m@bues.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29908
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m@bues.ch
Precedence: bulk
X-list: linux-mips

On Tue, 2011-05-10 at 16:27 +0100, Ralf Baechle wrote: 
> On Sat, May 07, 2011 at 07:24:18PM +0200, Jonas Gorski wrote:
> 
> > just some small small spelling nit-picks:
> 
> > > CC: Michael Buesch <mb@bu3sch.de>
> > > CC: netdev@vger.kernel.org
> > > CC: Florian Fainelli <florian@openwrt.org>
> > > Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> 
> Michael,
> 
> can I have an Ack for this patch assuming the raised spelling issues will
> get fixed?  Thanks,

I'd still prefer a platform-data based mechanism, but this would
be much more intrusive.
So yeah. ACK, for the time being.

-- 
Greetings Michael.
