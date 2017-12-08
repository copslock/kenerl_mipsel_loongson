Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 08:01:27 +0100 (CET)
Received: from mail-it0-x229.google.com ([IPv6:2607:f8b0:4001:c0b::229]:37680
        "EHLO mail-it0-x229.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990435AbdLHHBTsjG2z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Dec 2017 08:01:19 +0100
Received: by mail-it0-x229.google.com with SMTP id d137so2786719itc.2
        for <linux-mips@linux-mips.org>; Thu, 07 Dec 2017 23:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oESnI2wP4cXMECuKJduPTGXVujngMRd87B+g0mU2wCE=;
        b=VpfP/Ke7DPsvV8dQtrJ1hgbdf8i48Yaeu/ztnbnQfaUKz8KgUucOqz2+XYFAxnWrdC
         btM+s8kuF8CwF9DgNsKY4ZYiK/bzy+pqMvuCrSEroy/nW2RbDrNWzh3l7SOShH5NGW1z
         FwADwmJ4o3QjQHmL3QOY2OugSDbOYyTyWXLLYXReRZX23wXV6DRq9LRtec8M8PIqBTko
         Id+KYr6OOkx/RJUj0tzA7wOFDafmjg0Us9CEjfy7emx2uuKkhY80Ip97ugqT2UiK9CQj
         DEzN1oLc6cWZ1QUYfdmXBUUM+MzHqBRQdJy7CPzJhFtMvNDj6A7cWM3MZeK8vH8GUm3Z
         rJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oESnI2wP4cXMECuKJduPTGXVujngMRd87B+g0mU2wCE=;
        b=ppl+kIaZMBfsXkr0j+ula/sl4sYQnfTr7ilwWcP8q7z4ihB2arEoc6KkQ5lTwQcvM5
         6ylt9IKmUVWo7jv/ea0MIFLpIKvEK8GSmWcL8TFLUDUk7KWDUQrUFP2sef2T23OgUmo/
         wqY1FsZe4q7RCVNmNoGy/a7sckP8JAZnUNVRfameZBk5Afm3tUjNt8XbrMLnVAFJoWH8
         vHbRdMNizRe2/i2Nq908AsdOO/sBwLN91E/IL2OPP2/ei8mI9YNo6gs9/ZcggZ+xvmU7
         dAU/0AU+WDl8+6hFJHLLGSbPtHcYwi4SmWc5k+8ukSdgliQ69i31stSVRMjdBdV4CjyR
         GIMg==
X-Gm-Message-State: AKGB3mK1hG1/RsQLW/MUeUQQYC7dy65+dzU61+IVvm90eOrMi16CVgte
        XXF0s/ONdX10KwDvixKdsKNehyRlAThCr+6lhRlgzPb4
X-Google-Smtp-Source: AGs4zMaN092tIK/3oMyX84byF61KcftlqPhHERaVFKdE28d5u1U62UguoSXlq0WX5aHyB3u82P47CMh3O6SuiESK09s=
X-Received: by 10.107.62.10 with SMTP id l10mr5794966ioa.178.1512716472956;
 Thu, 07 Dec 2017 23:01:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.152.46 with HTTP; Thu, 7 Dec 2017 23:00:52 -0800 (PST)
In-Reply-To: <CAEdQ38HcOgAT6wJWWKY3P0hzYwkBGSQkRSQ2a=eaGmD6c6rwXA@mail.gmail.com>
References: <CAEdQ38HcOgAT6wJWWKY3P0hzYwkBGSQkRSQ2a=eaGmD6c6rwXA@mail.gmail.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Thu, 7 Dec 2017 23:00:52 -0800
Message-ID: <CAEdQ38G4VTXDGOarmmTac=hP92VJbQHRFxQTaSWQ3j4d63pogg@mail.gmail.com>
Subject: Re: NFS corruption, fixed by echo 1 > /proc/sys/vm/drop_caches --
 next debugging steps?
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        linux-nfs@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
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

On Sun, Mar 12, 2017 at 6:43 PM, Matt Turner <mattst88@gmail.com> wrote:
> On a Broadcom BCM91250a MIPS system I can reliably trigger NFS
> corruption on the first file read.
>
> To demonstrate, I downloaded five identical copies of the gcc-5.4.0
> source tarball. On the NFS server, they hash to the same value:
>
> server distfiles # md5sum gcc-5.4.0.tar.bz2*
> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2
> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.1
> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.2
> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.3
> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.4
>
> On the MIPS system (the NFS client):
>
> bcm91250a-le distfiles # md5sum gcc-5.4.0.tar.bz2.2
> 35346975989954df8a8db2b034da610d  gcc-5.4.0.tar.bz2.2
> bcm91250a-le distfiles # md5sum gcc-5.4.0.tar.bz2*
> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2
> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.1
> 35346975989954df8a8db2b034da610d  gcc-5.4.0.tar.bz2.2
> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.3
> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.4
>
> The first file read will contain some corruption, and it is persistent until...
>
> bcm91250a-le distfiles # echo 1 > /proc/sys/vm/drop_caches
> bcm91250a-le distfiles # md5sum gcc-5.4.0.tar.bz2*
> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2
> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.1
> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.2
> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.3
> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.4
>
> the caches are dropped, at which point it reads back properly.
>
> Note that the corruption is different across reboots, both in the size
> of the corruption and the location. I saw 1900~ and 1400~ byte
> sequences corrupted on separate occasions, which don't correspond to
> the system's 16kB page size.
>
> I've tested kernels from v3.19 to 4.11-rc1+ (master branch from
> today). All exhibit this behavior with differing frequencies. Earlier
> kernels seem to reproduce the issue less often, while more recent
> kernels reliably exhibit the problem every boot.
>
> How can I further debug this?

I think I was wrong about the statement about kernels v3.19 to
4.11-rc1+. I found out I couldn't reproduce with 4.7-rc1 and then
bisected to 4cd13c21b207e80ddb1144c576500098f2d5f882 ("softirq: Let
ksoftirqd do its job"). Still reproduces with current tip of Linus'
tree.

Any ideas? The board's ethernet is an uncommon device supported by
CONFIG_SB1250_MAC. Something about the ethernet driver maybe?
