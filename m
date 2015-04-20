Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Apr 2015 22:19:55 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:37981 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025907AbbDTUTyCeN5y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Apr 2015 22:19:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=qkFkvbgL7GOHQl9HfvhYNDkmUPN5Es69/xJHOhXlOxo=;
        b=p9P9TOTxQRpJep7ig1PGVilHbUHQ5lmYXRumtFu0krDxwwM+N1feVHTC0h2pW+bhq7XQSDXpY1DoH6a4sL9qrNb7rfoNmrrpyw4ONm9b7zkHpjjQVs4g3cR3eWKsJEmgw3/JxfCOZ7xwGWbIzUsj+RJWIHtMF21rGNubbF+H4j8=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1YkIAX-002uUy-Eb
        for linux-mips@linux-mips.org; Mon, 20 Apr 2015 20:19:49 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:41343 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1YkIAL-002uQb-An; Mon, 20 Apr 2015 20:19:37 +0000
Date:   Mon, 20 Apr 2015 13:19:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-kernel@vger.kernel.org,
        Rusty Russell <rusty@rustcorp.com.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@linux-mips.org
Subject: Re: mips build failures due to commit 8dd928915a73 (mips: fix up
 obsolete cpu function usage)
Message-ID: <20150420201935.GA16471@roeck-us.net>
References: <20150420194028.GA10814@roeck-us.net>
 <20150420200642.GA23756@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150420200642.GA23756@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020202.55355F65.026E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 5
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 0
X-CTCH-SenderID-TotalConfirmed: 0
X-CTCH-SenderID-TotalBulk: 0
X-CTCH-SenderID-TotalVirus: 0
X-CTCH-SenderID-TotalRecipients: 0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: mailgid no entry from get_relayhosts_entry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Mon, Apr 20, 2015 at 10:06:42PM +0200, Ralf Baechle wrote:
> On Mon, Apr 20, 2015 at 12:40:28PM -0700, Guenter Roeck wrote:
> 
> > the upstream kernel fails to build mips:nlm_xlp_defconfig,
> > mips:nlm_xlp_defconfig, mips:cavium_octeon_defconfig, and possibly
> > other targets, with errors such as
> > 
> > arch/mips/kernel/smp.c:211:2: error:
> > 	passing argument 2 of 'cpumask_set_cpu' discards 'volatile' qualifier
> > 	from pointer target type
> > arch/mips/kernel/process.c:52:2: error:
> > 	passing argument 2 of 'cpumask_test_cpu' discards 'volatile' qualifier
> > 	from pointer target type
> > arch/mips/cavium-octeon/smp.c:242:2: error:
> > 	passing argument 2 of 'cpumask_clear_cpu' discards 'volatile' qualifier
> > 	from pointer target type
> > 
> > The problem was introduced with commit 8dd928915a73 (" mips: fix up obsolete cpu
> > function usage"). I would send a patch to fix it, but I am not sure if removing
> > 'volatile' from the variable declaration(s) would be a good idea.
> > 
> > I don't recall seeing the problem in -next, but unless I am missing something,
> > the patch never made it into -next to start with.
> 
> It was posted on March 2nd as part of a larger series.  Only this patch
> 9/16 was send to linux-mips and when I tested the patch it failed.  Back
> then I blamed it on not having patches 1 to 8 in my test tree so I didn't
> diver deeper into the issue and dropped the patch ...
> 

Hi Ralf,

The patch failed all by itself, no context needed ;-). Anyway, since it was part
of a larger series, I would assume that it should have been added to -next as
part of that series, not through the mips tree. For whatever reason that did not
happen ... and as far as I can see, many if not all mips smp builds now fail
in the upstream kernel.

Any idea what the fix should be ?

Thanks,
Guenter
