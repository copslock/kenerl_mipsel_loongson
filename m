Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jul 2012 21:27:25 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:63492 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903549Ab2GPT1S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jul 2012 21:27:18 +0200
Received: by yenr9 with SMTP id r9so5834428yen.36
        for <multiple recipients>; Mon, 16 Jul 2012 12:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=RXDeBqqf4ud4rDmEXMl0crGcBy7+YyIbTm8EiwtuzEc=;
        b=jU1e99sp+SI2KFrEz0mpfay+IsZfP3JFcWdc3O4T68eeegNtf0menKsXkDoiloqAMv
         ulWuI166AhOsxV3UfiOAb3noKzBrYoT8+uPDE0+9uasO2qZY01Vnw8gpYyN0kRPv8Eot
         lYwHL50ACQbkn1aetrLWqc8bbVIYQLkzvzWVa1hvI6M4MgLRSKxOXrPZEstbuDKhWF0n
         OVJoRTZrqGImhtWq5BrmkiQYe0lhBDbGGz/PS9PzvRva5aAZYiQL89JGg+vCGjCFgS/k
         kzl4NreAEGsEW1akUGsvig62blxsn7cr6vwB9O8ErSJgT9aN7iFKVTtG5Jdk4DkK+7p1
         M3jA==
MIME-Version: 1.0
Received: by 10.50.135.1 with SMTP id po1mr5981152igb.67.1342466832162; Mon,
 16 Jul 2012 12:27:12 -0700 (PDT)
Received: by 10.231.135.1 with HTTP; Mon, 16 Jul 2012 12:27:12 -0700 (PDT)
In-Reply-To: <4FE4B13E.10709@caviumnetworks.com>
References: <1339962373-3224-1-git-send-email-geert@linux-m68k.org>
        <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com>
        <20120620152759.2caceb8c.yuasa@linux-mips.org>
        <20120620161249.GB29196@linux-mips.org>
        <4FE4B13E.10709@caviumnetworks.com>
Date:   Mon, 16 Jul 2012 21:27:12 +0200
X-Google-Sender-Auth: 3zRs9Ed7_W2rWDcGqS4JdQG_7r4
Message-ID: <CAMuHMdXSGgH+M_2+xuzY2t_sGZto24=atv3Kaj+R-dWAUPzW7w@mail.gmail.com>
Subject: Re: [PATCH] MIPS: fix bug.h MIPS build regression
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Yoichi Yuasa <yuasa@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
        Linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 33937
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

On Fri, Jun 22, 2012 at 7:54 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 06/20/2012 09:12 AM, Ralf Baechle wrote:
>>
>> On Wed, Jun 20, 2012 at 03:27:59PM +0900, Yoichi Yuasa wrote:
>>
>>> Commit: 3777808873b0c49c5cf27e44c948dfb02675d578 breaks all MIPS builds.
>>
>>
>> Thanks, fix applied.
>>
>
> Where was it applied?
>
> It doesn't show up in linux-next for 20120622, which is where it is needed.

It's also desperately needed in mainline for 3.5.

Ralf?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
