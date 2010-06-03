Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jun 2010 14:04:04 +0200 (CEST)
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:34946 "EHLO
        opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491771Ab0FCMD7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jun 2010 14:03:59 +0200
Received: from rakim.wolfsonmicro.main (lumison.wolfsonmicro.com [87.246.78.27])
        by opensource2.wolfsonmicro.com (Postfix) with ESMTPSA id 9C5E8110504;
        Thu,  3 Jun 2010 13:03:51 +0100 (BST)
Received: from broonie by rakim.wolfsonmicro.main with local (Exim 4.71)
        (envelope-from <broonie@rakim.wolfsonmicro.main>)
        id 1OK99L-0000nl-3x; Thu, 03 Jun 2010 13:03:51 +0100
Date:   Thu, 3 Jun 2010 13:03:51 +0100
From:   Mark Brown <broonie@opensource.wolfsonmicro.com>
To:     Wan ZongShun <mcuos.com@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [alsa-devel] [RFC][PATCH 20/26] alsa: ASoC: Add JZ4740 codec
 driver
Message-ID: <20100603120350.GC2762@rakim.wolfsonmicro.main>
References: <1275505397-16758-1-git-send-email-lars@metafoo.de>
 <1275505950-17334-4-git-send-email-lars@metafoo.de>
 <4C074171.2080106@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C074171.2080106@gmail.com>
X-Cookie: In the next world, you're on your own.
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 27044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2327

On Thu, Jun 03, 2010 at 01:45:21PM +0800, Wan ZongShun wrote:

> Your all the patches have two kinds of 'WARNING:',as following:

> (1)'WARNING: line over 80 characters' and

> Please make a line less than 80 characters.

You need to apply a certain degree of taste when looking at checkpatch
warnings, particularly things like line length.  Sometimes fixing the
warning for the sake of fixing the warning makes the code uglier than it
would be with whatever the style issue that's been identified is.
