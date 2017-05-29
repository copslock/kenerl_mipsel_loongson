Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 May 2017 21:39:10 +0200 (CEST)
Received: from mail-io0-x244.google.com ([IPv6:2607:f8b0:4001:c06::244]:36185
        "EHLO mail-io0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993959AbdE2Ti7BbDrf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 May 2017 21:38:59 +0200
Received: by mail-io0-x244.google.com with SMTP id f102so7494269ioi.3;
        Mon, 29 May 2017 12:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=GPXo60hQPXst7u7ZNAO6k2UQnifs5m6Cj6GRzB/uLO0=;
        b=Cjh7D5r0iNMHQUdw/4+v22m6a7qOp60HV7ZQ7Gda5GVpqJ1aT49CkOiYQdB1W1b8cg
         XdDbdbD8Sse+Cv0K4+KFl40ISAOuWAVhaAMYGIE4tApkzqES24k+0uAma15FDGYMPKuF
         BKXtio0bighYZjWY91Atn4H+MAvHnYlXaUdWvN0c28W3h4WRUGAm+n/6QX+2rnri7ibD
         WJFpe8QNXEzeDzUYbIGOuwRPg6urjL+7Wh1i+81DUjJ2We3upykwUnXIWSGUicVGnZmz
         U6Ar/i53i4caFYFTqCBz6hUqoi96F849bOcq6yytE3p6VnjZUoo1+OBj4cOHzx4wwM1E
         F6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=GPXo60hQPXst7u7ZNAO6k2UQnifs5m6Cj6GRzB/uLO0=;
        b=da6tX7osk7CHXC6QekIMrQ2+iMAKJ5y39eKuIOa6C4dkuXPlH8hCwuBZi+H3o8neoZ
         OyxynbLMec5NlAdWW/tj1EXtvCs59PU4Bls2cPdfZxCVeD6pGA3RJ73o0C5iXIaZgmhm
         ixwHSoLX5cCDGQcWFfZQkd/s6pc627TuNE1JSytWcUo4AR/MeFt7pbTx8dub0QgTtwdU
         TcqhJDSGb1v6iPuPAeNTe7zw63yz3LwNZK2LnJ13Q8P3VvWgAo8fHHXUS/deOvlHqpTY
         1av97FfhqCCLd7Bc57FMGEkLdGf7AL6ls5nDDJuQfjiZM8MJU++jU/wF/1+SF4NTZqMw
         u++w==
X-Gm-Message-State: AODbwcDCFaRdyWg+kyLFxgzq6tDV/EE57Jhq11ZeQULfbNYITANnOLm8
        SCsRAH1zSo30l14XUbNbiCFaz6sOvO7t
X-Received: by 10.107.201.135 with SMTP id z129mr13543762iof.51.1496086733283;
 Mon, 29 May 2017 12:38:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.15.148 with HTTP; Mon, 29 May 2017 12:38:52 -0700 (PDT)
In-Reply-To: <1495655035.2093.86.camel@perches.com>
References: <7995eb17-f2ec-54ad-f4d4-7b3dd8337d33@users.sourceforge.net>
 <1495565752.2093.69.camel@perches.com> <71a2ce6a-968c-b13c-95b0-610f0c1bab03@users.sourceforge.net>
 <1495655035.2093.86.camel@perches.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 May 2017 21:38:52 +0200
X-Google-Sender-Auth: dHa1RW9n1c-MUkEZBV3UqL0uv5I
Message-ID: <CAMuHMdXHuiaQ02Bmv_ig=kTTSHnhK=-64t9yv-rn5tFo=cn1hg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Octeon: Delete an error message for a failed memory
 allocation in octeon_irq_init_gpio()
To:     Joe Perches <joe@perches.com>
Cc:     SF Markus Elfring <elfring@users.sourceforge.net>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Daney <david.daney@cavium.com>,
        =?UTF-8?B?UmFsZiBCw6RjaGxl?= <ralf@linux-mips.org>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58071
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

On Wed, May 24, 2017 at 9:43 PM, Joe Perches <joe@perches.com> wrote:
> On Wed, 2017-05-24 at 18:01 +0200, SF Markus Elfring wrote:
>> I am curious if I will stumble on a similar change possibility once more
>> for remaining update candidates in other software areas.
>
> Only if you keep your eyes open to the possibilities.

It's like a puzzle: how to fold the if/else trees and forests to achieve
the longest linear path and the smallest indentation ;-)

And... goto (to the end/cleanup phase!) is your friend...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
