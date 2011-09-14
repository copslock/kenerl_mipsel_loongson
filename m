Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2011 16:50:21 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60912 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491144Ab1INOuR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Sep 2011 16:50:17 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p8EEoEwv011679;
        Wed, 14 Sep 2011 16:50:14 +0200
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p8EEoD16011676;
        Wed, 14 Sep 2011 16:50:13 +0200
Date:   Wed, 14 Sep 2011 16:50:13 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     post@pfrst.de, linux-mips@linux-mips.org,
        attilio.fiandrotti@gmail.com
Subject: Re: [PATCH] Impact video driver for SGI Indigo2
Message-ID: <20110914145012.GB9572@linux-mips.org>
References: <Pine.LNX.4.64.1109111200400.4146@Indigo2.Peter>
 <4E6F4FFB.7050704@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E6F4FFB.7050704@gentoo.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7173

On Tue, Sep 13, 2011 at 08:43:39AM -0400, Joshua Kinard wrote:

> I don't think IP26 will ever live.  I think the old R8000 TLB code was
> removed a few years ago, too, so to get such systems to work, someone needs
> to actually have one (I do), resurrect the old code, add in the TLB pieces
> (the Manual is available, so this isn't beyond impossible now), and test it.
>  But at 75MHz, these machines aren't exactly speed demons, compared even to
> an R10K I2.

The R8000 code was removed because it was unfinished work in progress.  I
wrote it without having access to hardware at the time.  If somebody was
submitted the code for inclusion in that shape I'd have to reject and
consequently I removed the R8000 code again.

I think we have sufficient knowledge about the R8000 to get it to work.
And if necessary I know the folks who did the IRIX kernel work back in
the dark ages.

  Ralf
