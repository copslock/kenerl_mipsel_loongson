Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Sep 2015 05:34:41 +0200 (CEST)
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33648 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006517AbbIEDej0Qqed (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Sep 2015 05:34:39 +0200
Received: by oixx17 with SMTP id x17so21785410oix.0;
        Fri, 04 Sep 2015 20:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5ICvxrG6qzmdFOz1vjFW2v6MjUA8Rb5DsEqDnOkC1xQ=;
        b=BYE/i3nXwctnExr2E2OZTX7Rr161VT8G15upkofL6qlqgOO21hBhOWNa/mVdrKAbZ5
         /7MkaeL4yzHI+Br9FFb9z9VQMowGTPXhZ/0lh4aBRp9zCdtC/m6TXSa1DeX2epTvUSFz
         z1Ni6QCjq3+FNpZIermbZI9BbfUwNrAn29WFQx7gc6I+VzH3gYvwyg6259mk8EzQpH1w
         6796XvVPtXfqOrr/w92IFpRf3oTJasFFKO+KSOp9XsR1bZ5cIowf6zJ91ACL9ouUWarH
         FxBc9SI1lAT6w2b5X6io7rzKUdS6UiFv3JhXoVCOGyVw2vYnp/ZIZLBwKfH+MqpJ63+S
         syvA==
X-Received: by 10.202.206.22 with SMTP id e22mr5983556oig.132.1441424073562;
 Fri, 04 Sep 2015 20:34:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.198.12 with HTTP; Fri, 4 Sep 2015 20:34:14 -0700 (PDT)
In-Reply-To: <CAECwjAihV86pXqCA1tAthZKd5WoSm0-yO6++Gj7pff4K2qGJzQ@mail.gmail.com>
References: <1441273665-15601-1-git-send-email-yszhou4tech@gmail.com>
 <alpine.LFD.2.20.1509041924220.10227@eddie.linux-mips.org> <CAECwjAihV86pXqCA1tAthZKd5WoSm0-yO6++Gj7pff4K2qGJzQ@mail.gmail.com>
From:   Yousong Zhou <yszhou4tech@gmail.com>
Date:   Sat, 5 Sep 2015 11:34:14 +0800
Message-ID: <CAECwjAiMyV5RqjbjB5hfJoje3cDWbRsk+QFB-gq4RkzPuGkZwg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: UAPI: Fix unrecognized opcode WSBH/DSBH/DSHD when
 using MIPS16.
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, Chen Jie <chenj@lemote.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <yszhou4tech@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yszhou4tech@gmail.com
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

On 5 September 2015 at 11:29, Yousong Zhou <yszhou4tech@gmail.com> wrote:
>     #include <stdio.h>
>     #include <stdint.h>
>

#include <asm/byteorder.h> was missed out at the top.

                yousong

>     uint16_t __attribute__((noinline)) f(uint16_t v)
>     {
>         v = __cpu_to_le16(v);
>         return v;
>     }
>
>     int main()
>     {
>         printf("%x\n", f(0xbeef));
>
>         return 0;
>     }
>
