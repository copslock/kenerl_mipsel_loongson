Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Nov 2018 03:38:53 +0100 (CET)
Received: from conssluserg-02.nifty.com ([210.131.2.81]:30173 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993001AbeKWChPMm1jH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Nov 2018 03:37:15 +0100
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id wAN2ahWL025522
        for <linux-mips@linux-mips.org>; Fri, 23 Nov 2018 11:36:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wAN2ahWL025522
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542940604;
        bh=Grkalro82XcZftrUmZQ9Uk6Q9M7QC4TvdZzw2JwHwGE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m4/YNoiAWV2v+sVOr1fHL7xqC8GWiY8Vsf1Zh/Te7GtZA5n3DT+2PCGjPDWOyBiI5
         VDMkFN9xt471NqfL9TeLNSf5rMsiz2m9eX5uHzQWq1v91OzJqHgjI7jOKMJWSWGbZd
         9zxF+XIcf0OpzCBzmFgn40r/HGHy/lbtAWfS/28bhjHBfRUcyqAsAT8ByPrCKlT2so
         VEq+8z7jIfRkdqj/4ytGmuNF35qiArHgXpvMKLmrYGTyN0Mlkp3SdheV41Kpl8g3V6
         okWinZX5ZZw6Dcwx5HR1Gfvs6Dtmj79rb2pTHqHelZAiglvY/97E7vefBb3I9UJwM0
         s6819/ft24nwg==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id h78so6375337vsi.6
        for <linux-mips@linux-mips.org>; Thu, 22 Nov 2018 18:36:44 -0800 (PST)
X-Gm-Message-State: AGRZ1gLrogrxiMUoRbzvGT8KEM4QGjlz9ydkw7Zkrh8PHVTXZfYQ0MoB
        S29a2bxdFH8x20E8W9TzCbOVZ70n+N4G6CbnG6M=
X-Google-Smtp-Source: AJdET5cvDS4SzyKrkGSSYigRcVPdU3u9wSG0ScXvHCVHXLUFXKqmyJ6YAXR/wfz8J0hWT/0RlTy9yMtfPTbMsNHvyDU=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr5688953vsm.181.1542940603144;
 Thu, 22 Nov 2018 18:36:43 -0800 (PST)
MIME-Version: 1.0
References: <20181115190538.17016-1-hch@lst.de> <CAK7LNARL8yZexzXiEaT77U_rdwhr5uENXbSaSTGHU33HbSmW6g@mail.gmail.com>
In-Reply-To: <CAK7LNARL8yZexzXiEaT77U_rdwhr5uENXbSaSTGHU33HbSmW6g@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 23 Nov 2018 11:36:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNARA-wbDDh_T2HghAUGizY-bF28O_8cjLmp9DMHaoxZPNw@mail.gmail.com>
Message-ID: <CAK7LNARA-wbDDh_T2HghAUGizY-bF28O_8cjLmp9DMHaoxZPNw@mail.gmail.com>
Subject: Re: move bus (PCI, PCMCIA, EISA, rapdio) config to drivers/ v4
To:     Christoph Hellwig <hch@lst.de>
Cc:     mporter@kernel.crashing.org, Alex Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-pci@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-alpha@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
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

On Fri, Nov 23, 2018 at 11:32 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Christoph,
>
>
> On Fri, Nov 16, 2018 at 4:08 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Hi all,
> >
> > currently every architecture that wants to provide on of the common
> > periphal busses needs to add some boilerplate code and include the
> > right Kconfig files.   This series instead just selects the presence
> > (when needed) and then handles everything in the bus-specific
> > Kconfig file under drivers/.
>
>
> Thanks for this work!
>
>
> I applied this series, and it is available at
>
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
> kconfig2


BTW, if you find questionable parts,
please let me know.

We still have plenty of time by the next MW.

Thanks.



-- 
Best Regards
Masahiro Yamada
