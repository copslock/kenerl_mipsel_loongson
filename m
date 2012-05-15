Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 May 2012 23:56:04 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48394 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903705Ab2EOV4A (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 15 May 2012 23:56:00 +0200
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.5/8.14.3) with ESMTP id q4FLtt52007959;
        Tue, 15 May 2012 23:55:55 +0200
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.5/8.14.5/Submit) id q4FLtpIx007958;
        Tue, 15 May 2012 23:55:51 +0200
Date:   Tue, 15 May 2012 23:55:51 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "John W. Linville" <linville@tuxdriver.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, zajec5@gmail.com,
        b43-dev@lists.infradead.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org, arend@broadcom.com, m@bues.ch
Subject: Re: [PATCH 0/8] ssb/bcma/bcm47xx: extend boardinfo and sprom
Message-ID: <20120515215551.GA16397@linux-mips.org>
References: <1335657853-23925-1-git-send-email-hauke@hauke-m.de>
 <20120515211605.GH24572@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120515211605.GH24572@tuxdriver.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, May 15, 2012 at 05:16:05PM -0400, John W. Linville wrote:

> On Sun, Apr 29, 2012 at 02:04:05AM +0200, Hauke Mehrtens wrote:
> > This patch series fixes the boardinfo for ssb based devices by removing 
> > board_rev from the struct, this should be fetched from sprom. In 
> > addition a boardinfo struct was added to bcma.
> > The pci sprom parsing code was extended for bcma to provide all 
> > attributes needed by brcmsmac and that code was also copied to ssb.
> > 
> > This is based on wireless-testing/master.
> > 
> > Hauke Mehrtens (8):
> >   ssb: remove rev from boardinfo
> >   MIPS: bcm47xx: refactor fetching board data
> >   bcma: add boardinfo struct
> >   MIPS: bcm47xx: read baordrev without prefix from sprom
> >   ssb/bcma: fill attribute alpha2 from sprom
> >   ssb: fill board_rev attribute from sprom
> >   bcma: read out some additional sprom attributes
> >   bcma/ssb: parse new attributes from sprom
> 
> I'd still like to see an ACK from Ralf on the mips stuff?

Sorry, I'm awfully backloged.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
