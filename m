Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Aug 2014 10:32:36 +0200 (CEST)
Received: from mail-la0-x231.google.com ([IPv6:2a00:1450:4010:c03::231]:58322
        "EHLO mail-la0-x231.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025874AbaHWTuRS8vNL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Aug 2014 21:50:17 +0200
Received: by mail-la0-f49.google.com with SMTP id hz20so11143410lab.22
        for <multiple recipients>; Sat, 23 Aug 2014 12:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=vOrHQRKwC8g9pO9FuqmfcMMiLI8vtmFdGyavzqdlzE4=;
        b=GgguoL2O0klvs5Vclcy4RrBzzLKmhz3BDcFm+Lv9s+lW+FuDD/25mZ5KsEEPEQEICg
         ccU8QNUE9FKHvqPikg2EhZy3ufjm97RQa0XVX1jb/WDX+7DXpaEdoUgrawBY6dDNfFbz
         d4h53m15LpZor9TxqcUUPzNJTjNAiw0BM15qCu9fYs3U9rH+IV4i5RSkOtgKvcgm+1Cj
         LxKLkWnQfdYILlD9YEtAdlyQWrtS8nUdjT+9pFdYEz/r1U8suImJx9igDaL81cOPwecA
         3Vie1k8lQ77Qe2g2Z8+QdoVgE+P3sbSvQ+JnmtCmpwaeVhlQNfuOqXz8yJ5UUoNNkOrL
         OrYw==
MIME-Version: 1.0
X-Received: by 10.112.120.226 with SMTP id lf2mr11104566lbb.14.1408823411696;
 Sat, 23 Aug 2014 12:50:11 -0700 (PDT)
Received: by 10.152.170.202 with HTTP; Sat, 23 Aug 2014 12:50:11 -0700 (PDT)
In-Reply-To: <20140823063113.GC23715@localhost>
References: <1408651466-8334-1-git-send-email-abrestic@chromium.org>
        <CAGVrzcZobuL4z0WNX+Sz4p_uwaPL-S5yvEmgRUwZPJi4+qq0tg@mail.gmail.com>
        <CAL1qeaGb-o0P7x4nZPJ+dGfoSKz+2ANrB0gGrBi19TtPxVTAZQ@mail.gmail.com>
        <20140823063113.GC23715@localhost>
Date:   Sat, 23 Aug 2014 21:50:11 +0200
X-Google-Sender-Auth: rNQdmktVYSNXvhAu2XFEG2WUeDI
Message-ID: <CAMuHMdXudu0kuOkKN8JCrWZSrQ4awKHhHU0E2ss++ProP0rteQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] MIPS: Move device-tree files to a common location
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        John Crispin <blogic@openwrt.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42189
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

On Sat, Aug 23, 2014 at 8:31 AM, Olof Johansson <olof@lixom.net> wrote:
>> > arch/arm/boot/dts/<vendor>/
>> >
>> > Is this something we should do for the MIPS and update the other architectures
>> > to follow that scheme?
>>
>> I recall reading that as well and that it would be adopted for ARM64,
>> but that hasn't seemed to have happened.  Perhaps Olof (CC'ed) will no
>> more.
>
> Yeah, I highly recommend having a directory per vendor. We didn't on ARM,
> and the amount of files in that directory is becoming pretty
> insane. Moving to a subdirectory structure later gets messy which is
> why we've been holding off on it.

It would mean we can change our scripts to operate on "interesting"
DTS files from

     do-something-with $(git grep -l $vendor, -- arch/arm/boot/dts)

to

    do-something-with arch/arm/boot/dts/$vendor/*

which is easier to type...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
