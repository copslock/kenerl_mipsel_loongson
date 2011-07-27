Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jul 2011 16:56:50 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:53631 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491133Ab1G0O4q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Jul 2011 16:56:46 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p6REuiju015671;
        Wed, 27 Jul 2011 15:56:44 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p6REuhED015668;
        Wed, 27 Jul 2011 15:56:43 +0100
Date:   Wed, 27 Jul 2011 15:56:43 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>,
        alsa-devel@vger.kernel.org, Liam Girdwood <lrg@ti.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH V5 2/3] ASoC: Add a DB1x00 AC97 machine driver
Message-ID: <20110727145643.GA15347@linux-mips.org>
References: <1311594287-31576-1-git-send-email-manuel.lauss@googlemail.com>
 <1311594287-31576-3-git-send-email-manuel.lauss@googlemail.com>
 <20110726143955.GH7285@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110726143955.GH7285@opensource.wolfsonmicro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19767

On Tue, Jul 26, 2011 at 03:39:55PM +0100, Mark Brown wrote:

> On Mon, Jul 25, 2011 at 01:44:46PM +0200, Manuel Lauss wrote:
> > Add a machine driver suitable for the AC97 part on the DB1000/DB1500/DB1100
> > boards.
> > 
> > Run-tested on DB1500.
> > 
> > Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> 
> Since you've got both arch/ and sound/ changes in here I need an ack
> from the MIPS maintainers for this one before I can apply it.

Ack, ack, ack...

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
