Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 08:28:49 +0200 (CEST)
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37127 "EHLO
        mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008848AbbGNG2sBZ3tr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jul 2015 08:28:48 +0200
Received: by wibud3 with SMTP id ud3so5403962wib.0;
        Mon, 13 Jul 2015 23:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3gN03NXCqorbhecg+WaR2AdXcH3KmLdRRY/6Buca3tQ=;
        b=NVazkuiwa4081yUyu0hW+OX9STs2vVMidAsB5lu/6TH0Bf5kZfJVmavCBMlUpXnsCy
         k4YijZ0SwZiZYUjCm2YDWLhdG/GUgbH91Z6yiw18vNS/q2wr/htNB8fY+V396oenBPxk
         fza0RjGOVZCMxGFucAR6eoaF8q2iUJ7oG+asE4r1RTMpIQXkxej2GIx/rTZuXouSVEu9
         2nIg9h5sG/bszfJUjIJM4B628xfWcsimTbAwtfbn77IxhwK3cBfR+vVWJ0bRedWSYCXK
         voGZqQmgvHAfnPk2xJ6up9tPA/mgsEgOtPCH4Z8+zXAVIZiD3t3VcaYdGl80HqIbGBLc
         tTUw==
X-Received: by 10.194.123.4 with SMTP id lw4mr72894747wjb.94.1436855322844;
 Mon, 13 Jul 2015 23:28:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.248.193 with HTTP; Mon, 13 Jul 2015 23:28:03 -0700 (PDT)
In-Reply-To: <CAOLZvyHPYF2kO2EdijCCX9OSt=hdo8g-tUXzZee0sSXT=-WdDw@mail.gmail.com>
References: <CAOLZvyHPYF2kO2EdijCCX9OSt=hdo8g-tUXzZee0sSXT=-WdDw@mail.gmail.com>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Tue, 14 Jul 2015 08:28:03 +0200
Message-ID: <CAOLZvyE3GYuU8E9Rico3bjRFs=4wn5mWfRf0NyCk_zJqxQTneg@mail.gmail.com>
Subject: Re: 4.1: XPA breaks Alchemy
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

Ping

This issue still exists in latest -git.  It goes away when
CONFIG_PHYS_ADDR_T_64BIT
is disabled, but then we lose PCI and PCMCIA (and other chipselect signals which
are mapped beyond 4G).

I'm going to look into this today if nobody beats me to it.

Manuel


On Thu, Apr 30, 2015 at 7:34 PM, Manuel Lauss <manuel.lauss@gmail.com> wrote:
> your patch commit c5b367835cfc7a8ef53b9670a409ffcc95194344
> ("MIPS: Add support for XPA") breaks userspace on my Alchemy systems,
> everything is killed with error -14:
>
> Kernel panic - not syncing: Requested init /bin/sh failed (error -14).
>
> Reverting that patch fixes everything.  I bet it's related to the 36bit
> address space in some way.
