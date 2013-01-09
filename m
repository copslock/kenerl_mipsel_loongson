Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jan 2013 13:45:49 +0100 (CET)
Received: from ns1.pc-advies.be ([83.149.101.17]:42127 "EHLO
        spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6817030Ab3AIMps1rmad (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Jan 2013 13:45:48 +0100
Received: from wimvs by spo001.leaseweb.com with local (Exim 4.50)
        id 1Tsv2G-0008Ju-SJ; Wed, 09 Jan 2013 13:45:36 +0100
Date:   Wed, 9 Jan 2013 13:45:36 +0100
From:   Wim Van Sebroeck <wim@iguana.be>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, linville@tuxdriver.com,
        linux-wireless@vger.kernel.org, linux-watchdog@vger.kernel.org,
        castet.matthieu@free.fr, biblbroks@sezampro.rs, m@bues.ch,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v3 00/11] watchdog/bcm47xx/bcma/ssb: add support for SoCs with PMU
Message-ID: <20130109124536.GG10667@spo001.leaseweb.com>
References: <1354729568-19993-1-git-send-email-hauke@hauke-m.de> <CACna6rzcYReMs1ZxKuMDjAte+3bX_rjvd3Jd7265tgkMF2E-oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACna6rzcYReMs1ZxKuMDjAte+3bX_rjvd3Jd7265tgkMF2E-oA@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-archive-position: 35398
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

Hi Rafal,

this will probably be done after I reviewed the v2 watchdog part first.

Kind regards,
Wim.

> 2012/12/5 Hauke Mehrtens <hauke@hauke-m.de>:
> > This patch series improves the functions for setting the watchdog
> > driver in ssb amd bcma. It also makes ssb and bcma register a platform
> > device which could be used by a watchdog driver to better set the times
> > where the system should restart. The patches for the watchdog driver
> > will be send later and were removed in v3.
> >
> > This code is currently based on the wireless-testing/master tree by
> > John Linville.
> >
> > v3:
> >  * Remove changes done to the watchdog driver so John could pull this
> >    into wireless-testing, this sill works with the old watchdog driver.
> >    The patches changing the watchdog driver will be send later.
> >    This was done to get this into 3.8 because Wim Van Sebroeck is
> >    neither giving an Ack or a Nack on these patches and we want to do
> >    more changes to bcma/ssb on top of these.
> 
> Your changes are already in Linus's tree, do you plan to re-send
> watchdog patches dropped in V3 through linux-watchdog? Can you take
> care of this?
> 
> -- 
> Rafał
