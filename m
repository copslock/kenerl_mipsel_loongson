Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Apr 2015 22:21:55 +0200 (CEST)
Received: from mail-ig0-f173.google.com ([209.85.213.173]:32790 "EHLO
        mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014463AbbDOUVySnbrH convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Apr 2015 22:21:54 +0200
Received: by igbpi8 with SMTP id pi8so62549930igb.0;
        Wed, 15 Apr 2015 13:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=p7oT8/okY9sAK2reG8iJbGxuHjqWSUVXJlyGQvniY7E=;
        b=0zX6TY+s3aBiRQxI3SgStv4StXPPfDcNYUkLz/l2jKUjj4EopjOG/lOppQ3eLP2abM
         /EFyt78D2tHs7PzlOlyLwuVYuS5mT9LWdIGc/odQWBCA3BOoULosmnieDTK/AONPkMa8
         hJBLOEme9eKvhu/xwaw2r+r1NPut3ZslEXJqcwRFzVRUIvKtlkOVRz0Ii2Pv8pchAj53
         drS5Jt5FrvyFhKFNk8lWEP8lxHZ/drgl6Y1C1NGJtsgyrnm/8vpatchCuIjjMhN6CBp4
         ebLsv53+FTAe/Sgg49c1QgGHnVhmwmRvHwVamjqB+Coi/MwWzwmSR99T5QM/klGg2Leo
         eklQ==
MIME-Version: 1.0
X-Received: by 10.50.131.196 with SMTP id oo4mr892086igb.2.1429129309863; Wed,
 15 Apr 2015 13:21:49 -0700 (PDT)
Received: by 10.107.36.73 with HTTP; Wed, 15 Apr 2015 13:21:49 -0700 (PDT)
In-Reply-To: <1429128338-28549-1-git-send-email-linux@roeck-us.net>
References: <1429128338-28549-1-git-send-email-linux@roeck-us.net>
Date:   Wed, 15 Apr 2015 22:21:49 +0200
Message-ID: <CACna6rwPYP0FV60v9ey0uV=3eU_8SZ4t+WoZCtiDHHeCLiM3Dg@mail.gmail.com>
Subject: Re: [RFC PATCH] bgmac: Fix build error seen if BCM47XX is not configured
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 15 April 2015 at 22:05, Guenter Roeck <linux@roeck-us.net> wrote:
> arm:allmodconfig fails to build as follows since ARCH_BCM_5301X
> is configured but not BCM47XX.
>
> drivers/net/ethernet/broadcom/bgmac.c: In function 'bgmac_probe':
> drivers/net/ethernet/broadcom/bgmac.c:1643:2: error:
>                 implicit declaration of function 'bcm47xx_nvram_getenv'
>
> Fixes: fc300dc3733f ("bgmac: allow enabling on ARCH_BCM_5301X")
> Cc: Rafał Miłecki <zajec5@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Seen in today's upstream kernel.
>
> I don't like this fix too much (I think it is quite kludgy),
> so I marked it RFC (and please don't beat the messenger ;-).

Ooh great, I totally forgot about this :|

The problem is that fc300dc (bgmac: allow enabling on ARCH_BCM_5301X)
[0] shouldn't really be sent (by me) in the first place. This is
because it depends on 138173d (MIPS: BCM47xx: Move NVRAM header to the
include/linux/.) [1] which isn't in Linus's tree yet.

So there are two solutions:
1) Revert fc300dc, wait for 138173d and re-apply fc300dc
2) Wait for 138173d with this build breakage

I guess the decisions depends on
a) time needed for David to revert fc300dc & send pull request
vs.
b) time needed for Ralf to send pull request

David, Ralf, what do you think about this?

Sorry for causing this problem :|

[0] http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=fc300dc3733fdc328e6e10c7b8379b60c26cd648
[1] http://git.linux-mips.org/cgit/ralf/upstream-sfr.git/commit/?id=138173d4e826587da66c7d321da1a91283222536
