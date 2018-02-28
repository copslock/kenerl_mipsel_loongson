Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2018 03:23:40 +0100 (CET)
Received: from mail-io0-x243.google.com ([IPv6:2607:f8b0:4001:c06::243]:47006
        "EHLO mail-io0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991855AbeB1CXXPJngq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Feb 2018 03:23:23 +0100
Received: by mail-io0-x243.google.com with SMTP id p78so1486226iod.13;
        Tue, 27 Feb 2018 18:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=3FNhEMTkryn+9EX90ae8Xu5gz6drDIs5FcbpJl4PJiY=;
        b=u1OEzOUaR8RTT4eQAYnr+Ykzpy57aWUY7WY7CZ/G4bc7EAY/rgF4qu1cHhGlQcVDJy
         +pIBx9ycQff7vOrO0MKacbWrbW1d0HABkyt7B2UFNwX1E/GBG4eFpf4LZpkPv32cR30r
         Qg7XfyIqXMv6aXUmO4WYC5qcYA8Oi65lYZqDAo2TLAN+PC0MHqTZeOPxAx3q9aZg8DSx
         IEq5Uk4Larwkmru+VYXL7YnSXrM/BOHZErqwJ8mXStrhJTpdjAvk8qBNidHgJcpI843I
         FVdRj/kZ33DwRE1ktnoJtLUSV4aNrdYFdd9rQORzjJhWxHza58C4YcnP7gUBxnALPsM4
         2sGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=3FNhEMTkryn+9EX90ae8Xu5gz6drDIs5FcbpJl4PJiY=;
        b=eAdx0ezqDmu0EPbrMe+HCpaTLf8IlBB8lJYRmAMXyPe7afP8iyHiQmfIso49wMzIBS
         lxxtw0BC5kE1zc/zA2H/gl6rMiJvHj5F8ciiCGgDFEW/mmnPTSmVmCBYPdudubbuLN0b
         CZ3ho4zH14UW+C+LpN64YE92VItguT8IeKfAangPxN2Y+tgdblT3qAmJCFB8ZyiyOtfT
         irm94fMomWjJNX6d5vW1TmuMzIImYYLQM4mEwNDt9FimE2h+2Olv855mkMzEdzN/Z1sM
         7qTVfqKwvgcRmnzFXsjRujKdGuG/9Bt+kXRQGUY3zXBUEwKtZNjsEumU2/gcu2MlAJFR
         n0Ew==
X-Gm-Message-State: APf1xPAJuBaRJ717hkaQEr2sSCosuk1tqEEV6W3JOoV5HW8AyHZ4xlYu
        MpVTAHUlSukXz5GvAqddUFQCBoXUvQv7E09Cdtw=
X-Google-Smtp-Source: AG47ELtWR72kZ9npgV2dpcPvCGRah+Ooqe2clrvfI4RIPB7aQf5V6aFlaOLB5mIhF1+YZQHQmwq85NAQB68zPa3DMXY=
X-Received: by 10.107.172.130 with SMTP id v124mr17942079ioe.301.1519784589838;
 Tue, 27 Feb 2018 18:23:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.51.212 with HTTP; Tue, 27 Feb 2018 18:23:09 -0800 (PST)
In-Reply-To: <20180215110506.GH3986@saruman>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com> <20180215110506.GH3986@saruman>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Wed, 28 Feb 2018 10:23:09 +0800
X-Google-Sender-Auth: u4k04Xuke-Kk1uaS7fcHO3ViOlg
Message-ID: <CAAhV-H7RMmtcc6BW7dCnZ617dx5ZZrzvbFTUekGSgLYCkZfZEw@mail.gmail.com>
Subject: Re: [PATCH V2 00/12] MIPS: Loongson: new features and improvements
To:     James Hogan <jhogan@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Hi, James,

I really don't want send many patches in a seris. But in practise, my
single patch in linux-mips usually be ignored (even they are very
simple and well described)....

For example:
https://patchwork.linux-mips.org/patch/17723/
https://patchwork.linux-mips.org/patch/18587/
https://patchwork.linux-mips.org/patch/18682/

Anyway, thank you for your susggestions, I will rework other patches.

Huacai

On Thu, Feb 15, 2018 at 7:05 PM, James Hogan <jhogan@kernel.org> wrote:
> On Sat, Jan 27, 2018 at 11:12:20AM +0800, Huacai Chen wrote:
>> This patchset is prepared for the next 4.16 release for Linux/MIPS. It
>> add Loongson-3A R3.1 support, enable Loongson-3's SFB at runtime, adds
>> "model name" and "CPU MHz" knobs in /proc/cpuinfo which is needed by
>> some userspace tools, adds Loongson-3 kexec/kdump and CPUFreq support,
>> fixes CPU UART irq delivery problem, and introduces WAR_LLSC_MB to
>> improve stability.
>>
>> V1 -> V2:
>> 1, Add Loongson-3A R3.1 basic support.
>> 2, Fix CPU UART irq delivery problem.
>> 3, Improve code and descriptions (Thank James Hogan).
>> 4, Sync the code to upstream.
>
> I few general suggestions that I hope will help you to get your patches
> applied quicker:
>
> - Please have a separate series for each group of related changes in
>   future. It makes them more manageable, makes dependencies clearer, and
>   avoids unchanged resends of unrelated patches when you respin the
>   whole series. Series are mainly to group tightly related patches, or
>   because of dependencies of later patches on earlier ones (and even if
>   you have a series of 30 dependent patches, you can still sometimes
>   split it into groups and mention in the cover letters which other
>   pending series each series depends on).
>
> - More importantly, avoid moving patches between series or adding
>   unrelated patches to a series if possible (so probably best not to
>   split this series now). It makes it harder to see what has changed,
>   whether past feedback has been addressed, and whether new/removed
>   patches are new/abandoned or simply moved from/to a different series.
>
> - Please don't resend a series without changes, ping it if you are
>   concerned. It clutters patchwork for no good reason and makes it
>   harder to see if past feedback has been addressed.
>
> - Please run checkpatch on all patches before submission, and fix any
>   reasonable warnings and errors (i.e. there are various lines exceeding
>   80 characters in this series which should be split, but some are
>   acceptable where its to keep a string together).
>
> - Please include Fixes tags where appropriate, especially where you've
>   Cc'd stable.
>
> - If you Cc stable, please state how far back it should be backported
>   wherever possible,
>   E.g. Cc: <stable@vger.kernel.org> # 4.14+
>   This may help finding what version a commit is first included in:
>   https://www.linux-mips.org/archives/linux-mips/2017-07/msg00149.html
>
> - Please run get_maintainer.pl on each patch to make sure you cc the
>   appropriate maintainers and lists (and Cc them on the cover letter
>   too). Its fine to skip LKML for lots of MIPS patches, but don't miss
>   out the appropriate subsystem maintainers and lists for patches
>   touching drivers/ or they'll never get acked and never get applied.
>
> - Split arch/mips/ and drivers/ patches wherever possible.
>
> Cheers
> James
