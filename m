Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2010 03:24:29 +0100 (CET)
Received: from aeryn.fluff.org.uk ([87.194.8.8]:49968 "EHLO
        kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1492859Ab0BCCYZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2010 03:24:25 +0100
Received: from ben by kira.home.fluff.org with local (Exim 4.71)
        (envelope-from <ben@fluff.org.uk>)
        id 1NcUuS-0006Mm-JA; Wed, 03 Feb 2010 02:24:04 +0000
Date:   Wed, 3 Feb 2010 02:24:04 +0000
From:   Ben Dooks <ben-linux@fluff.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        linux-i2c@vger.kernel.org, ben-linux@fluff.org, khali@linux-fr.org,
        rade.bozic.ext@nsn.com,
        Michael Lawnick <michael.lawnick.ext@nsn.com>
Subject: Re: [PATCH] I2C: Add driver for Cavium OCTEON I2C ports.
Message-ID: <20100203022404.GB24325@fluff.org.uk>
References: <1264711627-24304-1-git-send-email-ddaney@caviumnetworks.com>
 <20100128234113.GC13143@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100128234113.GC13143@linux-mips.org>
X-Disclaimer: These are my own opinions, so there!
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <ben@fluff.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25864
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben-linux@fluff.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 29, 2010 at 12:41:13AM +0100, Ralf Baechle wrote:
> On Thu, Jan 28, 2010 at 12:47:07PM -0800, David Daney wrote:
> 
> Thanks, I've replaced the queue patch with this one.

I'd rather avoid a cross-tree merge if possible. Is there anything
stopping it being added to my next-i2c tree?
 
>   Ralf
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
