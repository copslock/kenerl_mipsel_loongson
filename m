Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2018 03:04:12 +0200 (CEST)
Received: from mail-it0-x244.google.com ([IPv6:2607:f8b0:4001:c0b::244]:40295
        "EHLO mail-it0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992829AbeC0BECSkifa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Mar 2018 03:04:02 +0200
Received: by mail-it0-x244.google.com with SMTP id y20-v6so13093636itc.5;
        Mon, 26 Mar 2018 18:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=4NE5e2MWgoXummoFeEnXi/e+Cqd8GRa7MBgk21gc+Yg=;
        b=fBMAU890NECngYTzGy9hYSu75ob6HWbJXZzfwbOzUDiA0R7AN/c8wjDNzDswciJ67g
         FbpjF2yt/Wqr45zALSUsh9ep1UmGcEp7Ml6Q1jpjOLid3Q7zHre2rPFqV3+Jxz8jhFya
         zmRrGNQm2lNiyuHudNKqKYejFAPyEzJncwqxeEwYkzOSF0oSvUNshcoJDvJ5sp8v0qi1
         OHeQ+sWqrR1OKVOIjWovWDaaj4yzffrryfYdy+l4BLrJpxW727KWYaxBW4e1Cax+twoX
         jFaVR67U9ityvCC3LCfXkl8TL0DxOv4jJebdIfPAH8A3mRS+mQuHBXLs1ep0nbWOwKJA
         QFaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=4NE5e2MWgoXummoFeEnXi/e+Cqd8GRa7MBgk21gc+Yg=;
        b=emmLLShpq1O+vd7rQw5AyUpX1khjNHi+afGEd/8MfrM64s0pBdRCdwKJQ8FU9LZMX5
         YN4MJ1zPjwc5Dm11aU1T9ASAHfTZVqmV6KZ5q5VTQrsaYTaA6xsq8Ku87zvvhk8fGGOh
         I/yHTHby0B14kEBLa9LtISeQilmK8LU86lHQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=4NE5e2MWgoXummoFeEnXi/e+Cqd8GRa7MBgk21gc+Yg=;
        b=QSQj5KwgC+V/8B0IWA/KPcZzBuvBLFzVS+eML/AdTaGGjP7W5Qv5CYcjo+HJ4UDOYr
         3onu0gdXRRgkh4mm/VVEB+CZkCF6FIpMXvLCTt9NSFmoo2oIwFejt8VAAjkJFsmEIygB
         mg9krRUhDV0HeXTT63F3sdIWy4uqxRXBF+jD8TpJc641FqBc7QFZhXKS/4SGXfq1UEL+
         Wo4hTRjUDYrFoHZGNiLGiXDPYSj1COePzu8ofU3O05ualYh02PcvCSxRF3UMy9Qtbq9N
         r2jfwnhBIhJx1bvvYbkmi/BTysLeieZk87ge36KrnDNncQrdCHH4pOPYzVVwPd1o1eC5
         SYhQ==
X-Gm-Message-State: AElRT7HKVCtifbz2NSbjDqWQvMa9e6tf4WanLO5A9zKWywljSlSN0g+G
        lj/gKV7CMLdSWPSD4Sa94dNkMeNGmQ9K7dHXKeY3AQ==
X-Google-Smtp-Source: AG47ELsagbTDF9x0OfIQPz5KvjwZazSNZ/8tmyP9ZsRgCzZC8Uqu6/ei3EMvOKHM/h+nHMppVQg0lquEGp1gBWwQGOw=
X-Received: by 2002:a24:87c8:: with SMTP id f191-v6mr13079336ite.16.1522112635675;
 Mon, 26 Mar 2018 18:03:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.95.15 with HTTP; Mon, 26 Mar 2018 18:03:54 -0700 (PDT)
In-Reply-To: <428751c8-6920-096b-8694-a3f1b8990bdf@physik.fu-berlin.de>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-5-linux@dominikbrodowski.net> <20180318174014.GR30522@ZenIV.linux.org.uk>
 <CA+55aFwuZCpAZRpsTGiUmG065ZHHpj+03_NeWiy-OGkMGw7e3g@mail.gmail.com>
 <20180318181848.GU30522@ZenIV.linux.org.uk> <20180319042300.GW30522@ZenIV.linux.org.uk>
 <20180319092920.tbh2xwkruegshzqe@gmail.com> <20180319232342.GX30522@ZenIV.linux.org.uk>
 <20180322001532.GA18399@ZenIV.linux.org.uk> <20180326004017.GA2211@ZenIV.linux.org.uk>
 <20180326034750.GN30522@ZenIV.linux.org.uk> <CA+55aFw8VGnVgaWHVFP-LChMNaoANOwT18jJEWzSCRLFeRGcmA@mail.gmail.com>
 <428751c8-6920-096b-8694-a3f1b8990bdf@physik.fu-berlin.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Mar 2018 15:03:54 -1000
X-Google-Sender-Auth: Jt5T9aKOvYk8cL6-3ToUE3H54aQ
Message-ID: <CA+55aFwp-T-WFN95j7u5nn2BExxviJCx1-RgD3Mnu1AN_GYD3w@mail.gmail.com>
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
X-archive-position: 63241
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

On Sun, Mar 25, 2018 at 8:44 PM, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
<
> FWIW, we are maintaining an x32 port in Debian and there are some people
> actually using it [1]. There is one build instance running on VMWare that
> I am hosting [2] and around 10800 out of 12900 source packages build fine
> on x32 (12900 being the number for x86_64).

Hmm. Do you have a few statically built binaries that could be tested
without installing a whole distribution? Something real and meaningful
enough that it actually exercised a few real system calls, but not
something that needs to bring in 50 different shared libraries?

Something in /sbin, perhaps, that is still runnable by a regular user
and doesn't require some distro-specific /etc layout etc, so that it
would work even if you don't run Debian at all? Maybe some shell
binary or something?

      Linus
