Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Dec 2015 05:01:51 +0100 (CET)
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34908 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006880AbbLJEBuEResC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Dec 2015 05:01:50 +0100
Received: by mail-wm0-f44.google.com with SMTP id u63so7263096wmu.0
        for <linux-mips@linux-mips.org>; Wed, 09 Dec 2015 20:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=gszFJV6jvHTRUzbFm7jA14PKTD919scheslOfy/vhis=;
        b=RobMLdI8XI9aVDu+c32DNvyqU96rVSiMi04yc2KTFb4JdnD9RTC+pEqEEe5U9197ZN
         BHVl0BfH/Fzqc4/ayfJNbBQ+8K+sSOd5yCk3WvBN8WDgDvTXye8Ua/RhVPfCZAK1rXsM
         8moPDcPvDETS60YbtFZLuBQXSUIDld3AVa5HrW3XbRzTiGZcThwsUN9Y+dc4ngwA9La7
         856ItmUrlYNnCU/x1pl/zOLOc4MUBdh8TPgJT2ObvbnGu+K5TqrEn54ylRd/bPo/Rs+6
         vKL7J2k2jFkDrXRyREV2nGoxgVPUCMctT/yC4WcfXoBg3Ng+hZH648u2gzManH3cYld2
         fO+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=gszFJV6jvHTRUzbFm7jA14PKTD919scheslOfy/vhis=;
        b=mYFf1nMgxCXjHllICDd48qDyz4PD4wLK4mWuc0B9OZfxwvsX+1Dz6fU5dFkBwCHGOf
         7kKtBRr0tM1192eRNhXMaGT+ekZsyAAI4cth87XXFJif23a+g4RzCuktflWwmJtOFal7
         2OWZNM2kL6ycqMZZp8OVNkZ086pWvX2nh5/C/QJGTpdzrqfGaG7OZuADKgxLLYr3pFBo
         +9ek32WeZ9r7sab94jEZS4IbYIHmNjICSnSSiv1qMe6z2bl3DtvgvSPmUjTnKav97/E2
         WzBY2sypdUkYovN8bSisE1wXiC5kR5Z056/JRJyt+uaUMh+BwUoDQHecWz24nPwsQStt
         AH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-type;
        bh=gszFJV6jvHTRUzbFm7jA14PKTD919scheslOfy/vhis=;
        b=mz4dyN9EXQZVaCEOyfC92jyVX1Ba+n9JIIut8HZ/qrwF7/M+pBug8lOwKQJscmsLmC
         kf3GsOfUTeuHBprMUculrbygotITjD9lzqrqcvvWTS2YkbTzk9pNO6jPIvXfIO4exT75
         AxvWlyW8Wk2ZyD7RF5pWTHwocH/TtTk1R7YRODrplJbA4TKTtvWC63t7jDkNCfsJ23z7
         zrTTOqKfDNOzA9WdSRxIKRpZp/vmGBlVRSssVH7xN+4Y+RSQdrzvDFwMT2+e+qYcMvA0
         PeaRN5ajVMaDIY8gT7/1wNcAh37soVCLZlEQDb9Nx+QCVXitva7/+f4EwEH1Lyx7Ei2M
         y+EA==
X-Gm-Message-State: ALoCoQlPJlE2b9GRgzy3oPYTxQv3bO909+jClWHWtZMP1vco3a+qkEXip/5ILnUWztMZgjZhEedvZZNMO6WWHX6hSGJDvvr6cl+N6e6IzV505fS6yEY16+U=
X-Received: by 10.28.105.23 with SMTP id e23mr39999215wmc.80.1449720104442;
 Wed, 09 Dec 2015 20:01:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.31.135 with HTTP; Wed, 9 Dec 2015 20:01:24 -0800 (PST)
In-Reply-To: <201512100349.fX57FR9Z%fengguang.wu@intel.com>
References: <1449683969-7305-13-git-send-email-ddecotig@gmail.com> <201512100349.fX57FR9Z%fengguang.wu@intel.com>
From:   David Decotigny <ddecotig@gmail.com>
Date:   Wed, 9 Dec 2015 20:01:24 -0800
X-Google-Sender-Auth: RC52sMpXPxYOO91-RdnSv0_qUU4
Message-ID: <CAG88wWZP7KGC5zguP0te7KaLngLX98Q2ZsDJmbU-GHEEaLzKtA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 12/19] net: fcoe: use __ethtool_get_ksettings
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben@decadent.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        linux-mips@linux-mips.org, fcoe-devel@open-fcoe.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Eugenia Emantayev <eugenia@mellanox.co.il>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Ido Shamay <idos@mellanox.com>, Joe Perches <joe@perches.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Venkata Duvvuru <VenkatKumar.Duvvuru@emulex.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Pravin B Shelar <pshelar@nicira.com>,
        Ed Swierk <eswierk@skyportsystems.com>,
        Robert Love <robert.w.love@intel.com>,
        "James E.J. Bottomley" <JBottomley@parallels.com>,
        Yuval Mintz <Yuval.Mintz@qlogic.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Return-Path: <decot@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddecotig@gmail.com
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

apologies, forgot to make allyesconfig/allmodconfig this time. Fixed
in my local copy. Will be part of v5 after other feedback on this v4.

On Wed, Dec 9, 2015 at 11:18 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi David,
>
> [auto build test ERROR on net-next/master]
>
> url:    https://github.com/0day-ci/linux/commits/David-Decotigny/RFC-new-ETHTOOL_GSETTINGS-SSETTINGS-API/20151210-022123
> config: i386-randconfig-b0-12100240 (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All errors (new ones prefixed by >>):
>
>    drivers/scsi/fcoe/fcoe_transport.c: In function 'fcoe_link_speed_update':
>>> drivers/scsi/fcoe/fcoe_transport.c:104:32: error: request for member 'mask' in something not a structure or union
>       if (ecmd.link_modes.supported.mask[0] & (
>                                    ^
>    drivers/scsi/fcoe/fcoe_transport.c:110:32: error: request for member 'mask' in something not a structure or union
>       if (ecmd.link_modes.supported.mask[0] & (
>                                    ^
>    drivers/scsi/fcoe/fcoe_transport.c:117:32: error: request for member 'mask' in something not a structure or union
>       if (ecmd.link_modes.supported.mask[0] & (
>                                    ^
>    drivers/scsi/fcoe/fcoe_transport.c:122:32: error: request for member 'mask' in something not a structure or union
>       if (ecmd.link_modes.supported.mask[0] & (
>                                    ^
>
> vim +/mask +104 drivers/scsi/fcoe/fcoe_transport.c
>
>     98          if (!__ethtool_get_ksettings(netdev, &ecmd)) {
>     99                  lport->link_supported_speeds &= ~(FC_PORTSPEED_1GBIT  |
>    100                                                    FC_PORTSPEED_10GBIT |
>    101                                                    FC_PORTSPEED_20GBIT |
>    102                                                    FC_PORTSPEED_40GBIT);
>    103
>  > 104                  if (ecmd.link_modes.supported.mask[0] & (
>    105                              SUPPORTED_1000baseT_Half |
>    106                              SUPPORTED_1000baseT_Full |
>    107                              SUPPORTED_1000baseKX_Full))
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
