Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2018 08:21:06 +0200 (CEST)
Received: from mail-io0-x241.google.com ([IPv6:2607:f8b0:4001:c06::241]:41169
        "EHLO mail-io0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991346AbeCZGU7sFjQ8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Mar 2018 08:20:59 +0200
Received: by mail-io0-x241.google.com with SMTP id m83so21799966ioi.8;
        Sun, 25 Mar 2018 23:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=F8N/x3Cph88GTKgYjXBduNDwcFw0SMkkCtlac24yPCw=;
        b=rpDX7LFWYHBp/eeKyZ4XzQ0x/0uvRZ7pZCvV+eqnfftTbfhTm4RTe0MUwU/9zEtL99
         rfitscaQhn600sUnvxDRlWW4bTfKJ0pFaKcIQ9SiJru9o1BzQwPF5TrlHVVGjn+CeIOL
         XuJFtbkondbU6x+jKObIh5fUg2evSPBOHhkra+mdpSRVGBKWk6rQujjNSWH2xDlOhzOY
         OBy/5MtVx5Xp6DJXuRJNVbZOXmprkkIjYkx9+3I4XDZzwxf9WewJP34KraGWNx6cUwGO
         YCNFa2Pk7rr5zLviB+ON7zx71T/VSVwibT06raeQPk7UCOuVkGmLz8Altu8DZ2st7mNK
         Entw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=F8N/x3Cph88GTKgYjXBduNDwcFw0SMkkCtlac24yPCw=;
        b=PPylsUo3HORVV7PuyaXmAPYU9cWQgmfkdnmdm9ZfVefrEug3+lu4fqpsnb7KChRkkv
         CGrBwy1US0p2GhIxX9KSf+uedzbTa0RhxIDsS4ypyniB7eMTq/hTXuhwUKsa4T1BczVH
         20POslOq70gqz5E7XZaF/+RrMySPIrVyWqKgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=F8N/x3Cph88GTKgYjXBduNDwcFw0SMkkCtlac24yPCw=;
        b=j42XrErek+H5jCX5x6L0khMqrDFiJounCQYMA1BjVQrZz89lejuGQRN9BCUl3nrEOW
         xPEEzbJpJboOEqdXpXCgwhb0DNOpqhEWdfj9X6HdiCqp0KSJ8+sJ2/Y6KX6vHQUBgCLb
         dLZB8KMz1AiKJCUvGztg43WAui8643Oe6tkB4d+capbauUm4ZkuXJGlcVvP6bihs0fkU
         D3wLnr7pfjniOLeDbjmzsjF+T7yQdn3jsEq4ipp3tXBCHiXy3EBGG3tN9Stj9+l4MqUb
         hWm5ZuJDmDct9xXMmhkLk5d5JnEiwkw2VDNGdbQWwnWMsyxPCB+9h//Z6+n9ogWHmnwY
         PG3Q==
X-Gm-Message-State: AElRT7H90EhASE5X1Ufhgxfb+a6SNPVUfT2jY91zctwVELrDIITDV4/P
        0esN7QZ84Gldk+rujHQ2W5hgKbOC+tomWo31fLM=
X-Google-Smtp-Source: AIpwx4+0qab3BcQ1qIDsoAk7THvPfVhHJr73dPKJEHSjFBM9+9XLZbEY7/7y6oq0WRJYWWdm268JFGNgkB+tmWUS/ac=
X-Received: by 10.107.182.214 with SMTP id g205mr7230756iof.203.1522045253148;
 Sun, 25 Mar 2018 23:20:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.95.15 with HTTP; Sun, 25 Mar 2018 23:20:52 -0700 (PDT)
In-Reply-To: <CA+55aFw8VGnVgaWHVFP-LChMNaoANOwT18jJEWzSCRLFeRGcmA@mail.gmail.com>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-5-linux@dominikbrodowski.net> <20180318174014.GR30522@ZenIV.linux.org.uk>
 <CA+55aFwuZCpAZRpsTGiUmG065ZHHpj+03_NeWiy-OGkMGw7e3g@mail.gmail.com>
 <20180318181848.GU30522@ZenIV.linux.org.uk> <20180319042300.GW30522@ZenIV.linux.org.uk>
 <20180319092920.tbh2xwkruegshzqe@gmail.com> <20180319232342.GX30522@ZenIV.linux.org.uk>
 <20180322001532.GA18399@ZenIV.linux.org.uk> <20180326004017.GA2211@ZenIV.linux.org.uk>
 <20180326034750.GN30522@ZenIV.linux.org.uk> <CA+55aFw8VGnVgaWHVFP-LChMNaoANOwT18jJEWzSCRLFeRGcmA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Mar 2018 20:20:52 -1000
X-Google-Sender-Auth: 4yfXnPHQr6Ry271lHaPL-CL-TJ4
Message-ID: <CA+55aFy974z4PQMzSKbvcz02BeyRQTbXxyjw_GgjrXSeAf3wwQ@mail.gmail.com>
Subject: Re: [RFC] new SYSCALL_DEFINE/COMPAT_SYSCALL_DEFINE wrappers
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jiri Slaby <jslaby@suse.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus971@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
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

On Sun, Mar 25, 2018 at 8:15 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> HOWEVER.
>
> I didn't actually test any of the compat or x32 ones, and the way I
> did it there also was no type-checking or other automated catching of
> getting it wrong. So it's almost certainly completely buggy, but the
> _intent_ is there and there is a remote possibility that it might even
> work.

Note: the commit message is "broken, but working, ptregs system call
conversion for x86-64".

The "but working" is not because it would be right, but because it
booted a real 64-bit distribution successfully, and I actually used
that kernel.

But that only tests the native 64-bit case, it in no way tests the
compat or x32 cases what-so-ever. That part was literally a "it
compiles - it must be perfect" with absolutely zero testing of even
the most trivial kind.

And it really would have been most trivial to just do a "Hello world"
and build it with "-m32". I didn't do even that, and if I had, I would
have been honestly surprised had it worked.

But there was a _theoretical_ chance that it could have worked. Maybe.

      Linus
