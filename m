Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 May 2012 23:32:59 +0200 (CEST)
Received: from charlotte.tuxdriver.com ([70.61.120.58]:52896 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903681Ab2EOVcw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 May 2012 23:32:52 +0200
Received: from uucp by smtp.tuxdriver.com with local-rmail (Exim 4.63)
        (envelope-from <linville@tuxdriver.com>)
        id 1SUPMM-0002Lb-SJ; Tue, 15 May 2012 17:32:46 -0400
Received: from linville-8530p.local (linville-8530p.local [127.0.0.1])
        by linville-8530p.local (8.14.4/8.14.4) with ESMTP id q4FLG63g004864;
        Tue, 15 May 2012 17:16:07 -0400
Received: (from linville@localhost)
        by linville-8530p.local (8.14.4/8.14.4/Submit) id q4FLG5FC004863;
        Tue, 15 May 2012 17:16:05 -0400
Date:   Tue, 15 May 2012 17:16:05 -0400
From:   "John W. Linville" <linville@tuxdriver.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     zajec5@gmail.com, b43-dev@lists.infradead.org,
        linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        arend@broadcom.com, m@bues.ch, ralf@linux-mips.org
Subject: Re: [PATCH 0/8] ssb/bcma/bcm47xx: extend boardinfo and sprom
Message-ID: <20120515211605.GH24572@tuxdriver.com>
References: <1335657853-23925-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1335657853-23925-1-git-send-email-hauke@hauke-m.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linville@tuxdriver.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sun, Apr 29, 2012 at 02:04:05AM +0200, Hauke Mehrtens wrote:
> This patch series fixes the boardinfo for ssb based devices by removing 
> board_rev from the struct, this should be fetched from sprom. In 
> addition a boardinfo struct was added to bcma.
> The pci sprom parsing code was extended for bcma to provide all 
> attributes needed by brcmsmac and that code was also copied to ssb.
> 
> This is based on wireless-testing/master.
> 
> Hauke Mehrtens (8):
>   ssb: remove rev from boardinfo
>   MIPS: bcm47xx: refactor fetching board data
>   bcma: add boardinfo struct
>   MIPS: bcm47xx: read baordrev without prefix from sprom
>   ssb/bcma: fill attribute alpha2 from sprom
>   ssb: fill board_rev attribute from sprom
>   bcma: read out some additional sprom attributes
>   bcma/ssb: parse new attributes from sprom

I'd still like to see an ACK from Ralf on the mips stuff?

-- 
John W. Linville		Someday the world will need a hero, and you
linville@tuxdriver.com			might be all we have.  Be ready.
