Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Apr 2015 22:46:54 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:58426 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011610AbbDOUqwrS6Vy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Apr 2015 22:46:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=GQR82F22ur+XgvZ/xa7B14C3gawB+QUS89ROUm9dyJo=;
        b=g4bMl7M605KWryKe3U4003ayqSOH7HbJc09nrREviBsJ6IBfMl2Acd1YJEESNJQli9BXiNnxxjpAPpAif32Kq113uE24B+FBYnqrDgZKk0mF8FBb2++/lMWXULSKVhKuIu5SZ2LKiZgNT7XA1BUFWCZQ0HUaO19Gqw7efB6vDk0=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1YiUCu-001t9A-A9
        for linux-mips@linux-mips.org; Wed, 15 Apr 2015 20:46:48 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:43313 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1YiUCi-001t4u-OA; Wed, 15 Apr 2015 20:46:37 +0000
Date:   Wed, 15 Apr 2015 13:46:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [RFC PATCH] bgmac: Fix build error seen if BCM47XX is not
 configured
Message-ID: <20150415204635.GA18364@roeck-us.net>
References: <1429128338-28549-1-git-send-email-linux@roeck-us.net>
 <CACna6rwPYP0FV60v9ey0uV=3eU_8SZ4t+WoZCtiDHHeCLiM3Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACna6rwPYP0FV60v9ey0uV=3eU_8SZ4t+WoZCtiDHHeCLiM3Dg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020203.552ECE38.01A5,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 6
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
X-archive-position: 46869
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

On Wed, Apr 15, 2015 at 10:21:49PM +0200, Rafał Miłecki wrote:
> On 15 April 2015 at 22:05, Guenter Roeck <linux@roeck-us.net> wrote:
> > arm:allmodconfig fails to build as follows since ARCH_BCM_5301X
> > is configured but not BCM47XX.
> >
> > drivers/net/ethernet/broadcom/bgmac.c: In function 'bgmac_probe':
> > drivers/net/ethernet/broadcom/bgmac.c:1643:2: error:
> >                 implicit declaration of function 'bcm47xx_nvram_getenv'
> >
> > Fixes: fc300dc3733f ("bgmac: allow enabling on ARCH_BCM_5301X")
> > Cc: Rafał Miłecki <zajec5@gmail.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > Seen in today's upstream kernel.
> >
> > I don't like this fix too much (I think it is quite kludgy),
> > so I marked it RFC (and please don't beat the messenger ;-).
> 
> Ooh great, I totally forgot about this :|
> 
> The problem is that fc300dc (bgmac: allow enabling on ARCH_BCM_5301X)
> [0] shouldn't really be sent (by me) in the first place. This is
> because it depends on 138173d (MIPS: BCM47xx: Move NVRAM header to the
> include/linux/.) [1] which isn't in Linus's tree yet.
> 
> So there are two solutions:
> 1) Revert fc300dc, wait for 138173d and re-apply fc300dc
> 2) Wait for 138173d with this build breakage
> 
> I guess the decisions depends on
> a) time needed for David to revert fc300dc & send pull request
> vs.
> b) time needed for Ralf to send pull request
> 
> David, Ralf, what do you think about this?
> 

Since the fix is in the queue, maybe we can live with the breakage
for a few days ? Your solution is definitely _much_ better than my hack.

Guenter
