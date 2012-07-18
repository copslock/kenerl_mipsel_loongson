Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jul 2012 10:36:00 +0200 (CEST)
Received: from mail-gg0-f177.google.com ([209.85.161.177]:60423 "EHLO
        mail-gg0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903472Ab2GRIfx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jul 2012 10:35:53 +0200
Received: by ggcs5 with SMTP id s5so1400315ggc.36
        for <multiple recipients>; Wed, 18 Jul 2012 01:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=na1NQxt2XM3cbFALyGTwx0Fe8cwqocyn6p7xm1O1XRI=;
        b=YEU7FF1QoCDwcxDXySSxOtkEsxGNdiolObCSyMBkwDsMUP00Fs0iDaRlVD3/0pU+u6
         QZaS5EieMlW5n1AKKH0/WrpfemQM813Vny+IIiF+bWf18TL+0tysO0sQcrXYdb3WZKYB
         WehB5hoKZhZxriOBjIIFSSUivSF5WiQwTnoY+VXo2/gU6X6fv9EFirjpy6Y7kjQKy6Hc
         1WzCsAsZDT2gIPr3Iw0wyKlII1ci1QaMVAK8iHwkgqB3A3L0vryItt+hbGtPqf1NBjQw
         36OMf73naawoIZSm1be1yxP9aCTTMmeXE1kBWuz0LXwTjynMCWbJdt3RlGWYc4lYc0Rn
         VhOA==
MIME-Version: 1.0
Received: by 10.50.135.1 with SMTP id po1mr1108998igb.67.1342600546627; Wed,
 18 Jul 2012 01:35:46 -0700 (PDT)
Received: by 10.231.135.1 with HTTP; Wed, 18 Jul 2012 01:35:46 -0700 (PDT)
In-Reply-To: <CAMuHMdXSGgH+M_2+xuzY2t_sGZto24=atv3Kaj+R-dWAUPzW7w@mail.gmail.com>
References: <1339962373-3224-1-git-send-email-geert@linux-m68k.org>
        <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com>
        <20120620152759.2caceb8c.yuasa@linux-mips.org>
        <20120620161249.GB29196@linux-mips.org>
        <4FE4B13E.10709@caviumnetworks.com>
        <CAMuHMdXSGgH+M_2+xuzY2t_sGZto24=atv3Kaj+R-dWAUPzW7w@mail.gmail.com>
Date:   Wed, 18 Jul 2012 10:35:46 +0200
X-Google-Sender-Auth: Lzm0-Z199Mg_WHoF2uOaDRblHeE
Message-ID: <CAMuHMdWW=sAff-iw0EiHaejr34Z4u_X7w3nHf6Tfo-c2f=Qijg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: fix bug.h MIPS build regression
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     David Daney <ddaney@caviumnetworks.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Yoichi Yuasa <yuasa@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
        Linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 33939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, Jul 16, 2012 at 9:27 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, Jun 22, 2012 at 7:54 PM, David Daney <ddaney@caviumnetworks.com> wrote:
>> On 06/20/2012 09:12 AM, Ralf Baechle wrote:
>>>
>>> On Wed, Jun 20, 2012 at 03:27:59PM +0900, Yoichi Yuasa wrote:
>>>
>>>> Commit: 3777808873b0c49c5cf27e44c948dfb02675d578 breaks all MIPS builds.
>>>
>>>
>>> Thanks, fix applied.
>>>
>>
>> Where was it applied?
>>
>> It doesn't show up in linux-next for 20120622, which is where it is needed.
>
> It's also desperately needed in mainline for 3.5.
>
> Ralf?

Andrew? This prevents any green MIPS builds.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
