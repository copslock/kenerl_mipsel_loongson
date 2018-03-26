Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2018 08:15:46 +0200 (CEST)
Received: from mail-it0-x242.google.com ([IPv6:2607:f8b0:4001:c0b::242]:40344
        "EHLO mail-it0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991307AbeCZGPjvbDR8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Mar 2018 08:15:39 +0200
Received: by mail-it0-x242.google.com with SMTP id y20-v6so9240133itc.5;
        Sun, 25 Mar 2018 23:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Z3wg8zcx4CB0JiaDeY6zfNSgXHxGmKSAL04PMGIJ0Nw=;
        b=tUzNuDicxDwc6u25MF4HkorBDetaQGenvDIrXZ/3Geq0MlcNcm5rxWnRzfs15H2fTe
         QbNMAOact2YsfgoKi8WNCSDrJXa7qkaS/H/Wa3MDod4kwik007qzSFh/OFA+fMhwdOfl
         gLmp1qAu7QEHmCZiendntsIqgXD/6S9MffDM03xxwRoOj/wMF6C/L13r3wc3MqAI0Upi
         lC42HVoyYPkYL49r5Cappbh0kQWvL7uZ5czG0eKXozmFi5yq0zX//lWtytAo2YZS432O
         6rRdFFrbHyZFTJIS2QIbA0+Rp/F1iQI0AAm5Sij4Ds7d13Z4U67YnSD4ZMBxjnaTUaK/
         fcCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Z3wg8zcx4CB0JiaDeY6zfNSgXHxGmKSAL04PMGIJ0Nw=;
        b=QIhnUag688v2dOuDKOQgDGtiiujHQwUNusX5Zq88vmaYdzH37JwybpGM3lU6OHpx3U
         tWl+7ZKTafBL+T0QhovU3z24xavY3YjFHeJdKXdmhl4gD8NbA0dBtWGkLqq3FQUhG24C
         Xrnt1s/ubKMSByQOeFM4dRGCwtG2Tut77oLkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Z3wg8zcx4CB0JiaDeY6zfNSgXHxGmKSAL04PMGIJ0Nw=;
        b=X0ud76n63lUPr4RWCs2oy8cWHK8AtGYor7MW/uFQxBbwqkfKfXrfdMW6ZaW8am3KQX
         63TCKg5QkpMYjp7Wyu3rJZZz9rlqd+93FtsA5SKmiDLSEB8fBWbvjq82i+Y6QtChBG8O
         eJAG8kaMseFb0Pracuxoet25ZeZKkgL39t3k2BYBvAxOKpDNTcmJUHRuutZtcG/2Ko6e
         tbh3i6IjsSxYPpGNGSwWrixu9aylDheahOSZIPrYbbT9X0+h7guDDpRHGAuEUedM1k/R
         ILtnt/Fh+/9c45GQQxHPvnyVwKXzZo9EME5U2XY9TGMT409fHEeERXrOi7ZhYwj40GFY
         q8tw==
X-Gm-Message-State: AElRT7HpSQ6efFTdlFuR+BczgF6DNp2/W+NUsRzMWiuQFoP0irHTCrr3
        9CwD5YJZ7lE1xKjv5Lc+ZiDfA5J6XmEnIXYOGFY=
X-Google-Smtp-Source: AG47ELsYuh5vZPJVBYTKpLXNXcPAwzM2eXJHqf7f8ohFafGgIhKjn+9BSf7Kl/kTNywqaSwG/OIl7qr4xYwrnc3Jnac=
X-Received: by 2002:a24:c581:: with SMTP id f123-v6mr14028656itg.113.1522044933369;
 Sun, 25 Mar 2018 23:15:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.95.15 with HTTP; Sun, 25 Mar 2018 23:15:32 -0700 (PDT)
In-Reply-To: <20180326034750.GN30522@ZenIV.linux.org.uk>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-5-linux@dominikbrodowski.net> <20180318174014.GR30522@ZenIV.linux.org.uk>
 <CA+55aFwuZCpAZRpsTGiUmG065ZHHpj+03_NeWiy-OGkMGw7e3g@mail.gmail.com>
 <20180318181848.GU30522@ZenIV.linux.org.uk> <20180319042300.GW30522@ZenIV.linux.org.uk>
 <20180319092920.tbh2xwkruegshzqe@gmail.com> <20180319232342.GX30522@ZenIV.linux.org.uk>
 <20180322001532.GA18399@ZenIV.linux.org.uk> <20180326004017.GA2211@ZenIV.linux.org.uk>
 <20180326034750.GN30522@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Mar 2018 20:15:32 -1000
X-Google-Sender-Auth: YDx_DvZd3_qAcavXpUX35UTCypQ
Message-ID: <CA+55aFw8VGnVgaWHVFP-LChMNaoANOwT18jJEWzSCRLFeRGcmA@mail.gmail.com>
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
X-archive-position: 63227
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

On Sun, Mar 25, 2018 at 5:47 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Linus, Dominik - how do you plan dealing with that fun?

Secretly, I was hoping to kill x32, because it's not being used afaik.

More realistically, I was thinking we'd just use a separate table or
system calls, and generate different versions.

In fact, you can see exactly that in my WIP branch, except it uses the
wrong name.

So see the "WIP-syscall" branch in my normal git kernel repo, and in
particular the patch to <linux/syscalls.h>, which generates
"sys_x64##name" and "sys_i86##name()" inline functions that do that
mapping correcty for native x86-64, and for the (misnamed) x32 cases.

So there are three different cases:

 - native: sys_x64_name() generated by SYSCALL_DEFINEx()

 - compat -bit: compat_sys_i86_name() generated by COMPAT_SYSCALL_DEFINEx()

 - x32: sys_i86_name() generated by SYSCALL_DEFINEx().

and then I actually changed the names in the tables (ie in
arch/x86/entry/syscalls/syscall_64.tbl etc).

HOWEVER.

I didn't actually test any of the compat or x32 ones, and the way I
did it there also was no type-checking or other automated catching of
getting it wrong. So it's almost certainly completely buggy, but the
_intent_ is there and there is a remote possibility that it might even
work.

              Linus
