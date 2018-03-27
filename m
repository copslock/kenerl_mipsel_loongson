Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2018 05:40:24 +0200 (CEST)
Received: from mail-it0-x22d.google.com ([IPv6:2607:f8b0:4001:c0b::22d]:50962
        "EHLO mail-it0-x22d.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992604AbeC0DkRv8oaN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Mar 2018 05:40:17 +0200
Received: by mail-it0-x22d.google.com with SMTP id d13-v6so13313532itf.0;
        Mon, 26 Mar 2018 20:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=t/ReNPFwGYqvHmF8SCdM2AH8XXPVCqhmRQB26DL5+Wk=;
        b=HRif/lEcTXfVEQbOxNfNMNmG56xXf25chuc5oC7dq/LLf+1i3pT6cfC95Rq9OxtNWD
         01TntQCoOZ25YSCyrVvB2BySIsYFYCLo0micIaLNOtb4Bp94gCkobDDfonoKttMB7dnc
         f0ghhxmkbrBK3r6BlJogw++XbcdcJrlfY4pGhbqblhu+PhCJwjPtsbE0R/HgQcjhcJNr
         6F7ri8zVrqClGFFzz9OhlpS4FTq80/3SC42Akr63L6XaSUhv/aWiEq4bXnpb7jYxWP8C
         +xlDU0d/SAUTRu9bk3/5t+smyZwRjnb0aOB5MA6/bSpfzsi4qk8sutS2U7VuWblFb2X9
         BLsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=t/ReNPFwGYqvHmF8SCdM2AH8XXPVCqhmRQB26DL5+Wk=;
        b=cGlsb4l5bvmA/vKv5P3DwuQgkU7GJQ3MNIvHVy8+p9ktUxbHCClGExmKVS2jBbayym
         znkhJRAOmbKknb6piawWrc7GLp/m/dU/UW2Wy2mz87EoOXEsme3Q2BdPScML3a38SFdF
         cUGytfgKqSmV7agdazg69ExCmaQMaSdC9QmXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=t/ReNPFwGYqvHmF8SCdM2AH8XXPVCqhmRQB26DL5+Wk=;
        b=dS1Tg89H2Jxwx6zkJQBifEuNOURMhw3TvpX6Eu0F5RRi6og0bwNtmAN+7GT3N6wk7E
         cM41inmeCdpl7GzFVet4oyhTkhudeyI3lqT1dPhm5n8YbetGtxpRH91Yhwu5EI61JoYV
         Cx0nHN8YPCs4dKU2AnMETN1UedOKAM2bjCTl5EsgJmMONYGIW0X2+c/+TLvnA3sPh0xh
         5VSgCswM6Cn/CZib1VcSCKNm/sUBg15vNAgjsQ7d+KGije4iMqfoTdc4Q2NG27esg/iF
         6y4Lnw+Im01FdrCSMDjlQpd9NnnlDPgj4NalHa38c0+4gspO91bdTRhqjBVFY0Q/jxzp
         gJ8Q==
X-Gm-Message-State: AElRT7EMaESyKbN/Qr8t0yDpXOMOpr0NL+fOXaxtCnax4L0Yxi00Eiin
        glaL15zOIEar1IxW/pXJwp+BEkZw9eWlXd/Vnlw=
X-Google-Smtp-Source: AIpwx4+rzLY3dniAgFtKVodgoaTFA6ZMpt/wIZFNIU4EnNsSOMzHzNadgdozRpq5aJokfiu/PcJ0eZfkcqs/zuqDp6Q=
X-Received: by 2002:a24:19c9:: with SMTP id b192-v6mr1737664itb.1.1522122011450;
 Mon, 26 Mar 2018 20:40:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.95.15 with HTTP; Mon, 26 Mar 2018 20:40:10 -0700 (PDT)
In-Reply-To: <8a8ee344-fb19-3ed9-f7dc-db63f703e6d3@physik.fu-berlin.de>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-5-linux@dominikbrodowski.net> <20180318174014.GR30522@ZenIV.linux.org.uk>
 <CA+55aFwuZCpAZRpsTGiUmG065ZHHpj+03_NeWiy-OGkMGw7e3g@mail.gmail.com>
 <20180318181848.GU30522@ZenIV.linux.org.uk> <20180319042300.GW30522@ZenIV.linux.org.uk>
 <20180319092920.tbh2xwkruegshzqe@gmail.com> <20180319232342.GX30522@ZenIV.linux.org.uk>
 <20180322001532.GA18399@ZenIV.linux.org.uk> <20180326004017.GA2211@ZenIV.linux.org.uk>
 <20180326034750.GN30522@ZenIV.linux.org.uk> <CA+55aFw8VGnVgaWHVFP-LChMNaoANOwT18jJEWzSCRLFeRGcmA@mail.gmail.com>
 <428751c8-6920-096b-8694-a3f1b8990bdf@physik.fu-berlin.de>
 <CA+55aFwp-T-WFN95j7u5nn2BExxviJCx1-RgD3Mnu1AN_GYD3w@mail.gmail.com> <8a8ee344-fb19-3ed9-f7dc-db63f703e6d3@physik.fu-berlin.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Mar 2018 17:40:10 -1000
X-Google-Sender-Auth: Kd9FGnI0th4QSB-ymh8QgmQcsdE
Message-ID: <CA+55aFzHL1L_SEt_xqmJBfRRngTm4qbQGwxFvqSXw-MD2BiAOQ@mail.gmail.com>
Subject: Re: [RFC] new SYSCALL_DEFINE/COMPAT_SYSCALL_DEFINE wrappers
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ingo Molnar <mingo@kernel.org>,
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
X-archive-position: 63243
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

On Mon, Mar 26, 2018 at 4:37 PM, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> What about a tarball with a minimal Debian x32 chroot? Then you can
> install interesting packages you would like to test yourself.

That probably works fine.

          Linus
