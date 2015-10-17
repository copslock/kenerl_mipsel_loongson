Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Oct 2015 04:17:54 +0200 (CEST)
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36718 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006523AbbJQCRwiVKlZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Oct 2015 04:17:52 +0200
Received: by qkht68 with SMTP id t68so62164399qkh.3;
        Fri, 16 Oct 2015 19:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uQul/wLI1sdUhstCpnTOGTwwaca/oWxyjuJ9MKVKrQc=;
        b=MyqqKmDuZdsoD9Vq5jpR1FtX5p8rxa89CGDxhFCyrGhtTeGoUY9xQe7eSV6Bw1FBek
         ZtiNK1We0T3+zurgDbPGy4/ScoeHWxJH4C+f96tqbieSjaAUIi3j5tHhq6doi/ReYib7
         uDW2mqOn2yBmn4azqNs5pkEw5NuFPDATuw/u4q9Ow/a+QMO0ct+QEU/hrWhJWmgzGtfz
         2hSTbQuaM/xrdRmzYL+9IujLCFHrHdzOH4SqDNKx9fPn3Nl4elgnm9QmDbDrLY91pWCw
         bmtUIDwmx4jo00wMcmtHguSaM/UXvHVIicXOzP7iAeDzBx1im46rIzx1afOGQpN+6b63
         E9gg==
X-Received: by 10.55.31.232 with SMTP id n101mr22694194qkh.107.1445048262691;
 Fri, 16 Oct 2015 19:17:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.34.173 with HTTP; Fri, 16 Oct 2015 19:17:23 -0700 (PDT)
In-Reply-To: <1445025118-13290-1-git-send-email-f.fainelli@gmail.com>
References: <1445025118-13290-1-git-send-email-f.fainelli@gmail.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Fri, 16 Oct 2015 19:17:23 -0700
Message-ID: <CAJiQ=7AR7L2TgfsKpMLmdnZiy2xKCCTUzdNVqx0v5Wsku=n5Gg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BMIPS: Enable GZIP ramdisk and timed printks
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Jonas Gorski <jogo@openwrt.org>, dragan.stancevic@gmail.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Fri, Oct 16, 2015 at 12:51 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Update bmips_be_defconfig and bmips_stb_defconfig to have GZIP ramdisk
> support enabled by default as well was timed printks.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Kevin Cernekee <cernekee@gmail.com>
