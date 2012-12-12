Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2012 22:38:01 +0100 (CET)
Received: from ns1.pc-advies.be ([83.149.101.17]:36141 "EHLO
        spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6825730Ab2LLViBMwwED (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Dec 2012 22:38:01 +0100
Received: from wimvs by spo001.leaseweb.com with local (Exim 4.50)
        id 1Tiu01-0008Tj-Tf; Wed, 12 Dec 2012 22:37:53 +0100
Date:   Wed, 12 Dec 2012 22:37:53 +0100
From:   Wim Van Sebroeck <wim@iguana.be>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, linville@tuxdriver.com,
        linux-wireless@vger.kernel.org, linux-watchdog@vger.kernel.org,
        castet.matthieu@free.fr, biblbroks@sezampro.rs, m@bues.ch,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v2 00/15] watchdog/bcm47xx/bcma/ssb: add support for SoCs with PMU
Message-ID: <20121212213753.GC31853@spo001.leaseweb.com>
References: <1353975925-32056-1-git-send-email-hauke@hauke-m.de> <CACna6rwmfpNFAFZpvbt8GHzofC6UoyBC4oKF5rL=9xN5_=gYXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACna6rwmfpNFAFZpvbt8GHzofC6UoyBC4oKF5rL=9xN5_=gYXw@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-archive-position: 35276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wim@iguana.be
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi,

> > @Wim Could you give me an ACK on the "watchdog: bcm47xx_wdt.c:" patches
> >      so that John could take them trough the wireless-testing tree, or
> >      provide me with some feedback on what I should change.
> 
> Hi Wim,
> 
> Have you got a chance to look at that patches?
> 
> I've some additional bcma changes I wish to submit on top of this :)

Sorry, but family health issues have distracted me from kernel stuff the last months.
Things are better now.

Concerning these patches: The correct decision has been taken to split this allready up
into the bcma/ssb patches and do the watchdog patches later on. I will check the watchdog
part and react on it as soon as possible.

Kind regards,
Wim.
