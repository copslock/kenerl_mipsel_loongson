Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 12:21:26 +0200 (CEST)
Received: from mail-oi0-x242.google.com ([IPv6:2607:f8b0:4003:c06::242]:36854
        "EHLO mail-oi0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990510AbdEaKVQpPca3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2017 12:21:16 +0200
Received: by mail-oi0-x242.google.com with SMTP id w138so1200546oiw.3
        for <linux-mips@linux-mips.org>; Wed, 31 May 2017 03:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Cfh+7u7ctSslmmVZ7/kmiYlq70t3UddpMfHwHvevTbQ=;
        b=TqF0tbilQKBKM/3fw0eK+7mSRUJaiS+2cKXVlaEu/oIohijXUmtnWd4z5sUvpqlO0j
         kzVzuVjalHJtlkzpkvr1KyfzNxamThkuoCcZVlrR5PFqgzqzXusqnUHUL6WlJaqe6U7c
         VkXpSi/MVfWB88K3g9L1S56VU1br6Ft3bT/bTx4wJNNsZ0kRPS02OTgE+fAiB991Q/PF
         GA356NRZBs1RQNG9amudzGXY6HMw86P5PUKOJY/S5u8pj+8Y5zxo6ocTSvejhZvB67SB
         YoCUgEZQNux48EJNoXoKv8a5/YC5Tcj3Y1c++NuqML0gnRZUXiw0FbLUupNhmIcJ3uK4
         LwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Cfh+7u7ctSslmmVZ7/kmiYlq70t3UddpMfHwHvevTbQ=;
        b=IAMvctnmoYXC8i2DxfjuustORR0OJBQEZ+jeiMJDImp1W+eVLuJ7fEFcJsct1Lg3ql
         M4AnT56HbneuGD6UZV145fn+xg+EqUJssxV+DNEF9VVUoSIV8PfnODBcMGK0W+4dfWKT
         Zk5NmqbRbpnt9uFTDy7mXcZ+iz/ALfD8p0iZ+DWGnAZI65aom29cWeogiuLn8Qx9xasc
         3K8gMcDUBfjXftWIOiHg6VqfOGNdQcDUn92F8j55KuopXZglA2Ungod9VoJ0E96w+k5p
         WLDEkPNdGUJAyB36wOta8XGI01l9BoU5S1Juxepn2gAqX6nsQg5jWgYpeT4B5TGCyobj
         6hxg==
X-Gm-Message-State: AODbwcAvkYpizyKQKduoqNA21HmC/mju5NNIyLz5JuVHBWVGb2LmDKdj
        5UpQSBPJw/kY4oc8AS41lhufbUIVbA==
X-Received: by 10.157.50.11 with SMTP id t11mr303350otc.217.1496226070404;
 Wed, 31 May 2017 03:21:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.51.139 with HTTP; Wed, 31 May 2017 03:21:10 -0700 (PDT)
In-Reply-To: <7b6903a2-ce54-44f9-18ed-a14bd32069ce@broadcom.com>
References: <20170530112027.3983554-1-arnd@arndb.de> <7b6903a2-ce54-44f9-18ed-a14bd32069ce@broadcom.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 31 May 2017 12:21:10 +0200
X-Google-Sender-Auth: utYsm-w17C-JWafRkW-KxN9L1gM
Message-ID: <CAK8P3a2-kO==gMDm3E6U8CR-zhwmZGztRy7Trcezf8oZxgn01g@mail.gmail.com>
Subject: Re: [PATCH] bcm47xx: fix build regression
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Wed, May 31, 2017 at 11:43 AM, Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
> On 5/30/2017 1:20 PM, Arnd Bergmann wrote:
>>
>> An unknown change in the kernel headers caused a build regression
>> in an MTD partition driver:
>>
>> In file included from drivers/mtd/bcm47xxpart.c:12:0:
>> include/linux/bcm47xx_nvram.h: In function 'bcm47xx_nvram_init_from_mem':
>> include/linux/bcm47xx_nvram.h:27:10: error: 'ENOTSUPP' undeclared (first
>> use in this function)
>>
>> Clearly we want to include linux/errno.h here.
>
>
> unfortunate that you did not find the commit that caused this build
> regression. You could produce preprocessor output when it was working to see
> where errno.h got implicitly included and start looking there for git
> history.

I did a 'git bisect run make drivers/mtd/bcm47xxpart.o' now, which pointed to
0bc2d534708b ("rcu: Refactor #includes from include/linux/rcupdate.h").

That commit seems reasonable, it was just bad luck that it caused this
regression. The commit is currently in the rcu/rcu/next branch of tip.git,
so Paul could merge the patch there.

       Arnd
