Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Sep 2018 03:45:10 +0200 (CEST)
Received: from mail-pf1-x442.google.com ([IPv6:2607:f8b0:4864:20::442]:41064
        "EHLO mail-pf1-x442.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994243AbeI2BpHqzfJv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 Sep 2018 03:45:07 +0200
Received: by mail-pf1-x442.google.com with SMTP id m77-v6so5417468pfi.8
        for <linux-mips@linux-mips.org>; Fri, 28 Sep 2018 18:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=BCbCfmNw3TWJkcE6Svde7cv50NunpK6ZWR+5u993ZLE=;
        b=j8bqOPsFZQJxQDphK+7RVzPhvvhNsdCz2BY3fdui/U84nwPEi3saoF00PHGytAbQe9
         illdEqquMQNFQJFXlLxZG3XETubvW3sWLBX/qvIOM3w6u8Daohdify44TrJis1ThHheh
         qIFplHk0EEFVcaH/DfdDN0oE1TTfiQZPvpLA5DFvPsxYz5R+7ayYs4wFr3cEGCiK0D4q
         svNDPnfjdhb1kQ0Q1ybewtq6i1mcVbSWV6BCIU0rdUui6Nt1Irkbxng3QCc2p6mqMjJG
         JeO5Qr8WhGbbGFQgqq0q8cy50TZC5ZsP833wl/ExeQb/4V8PLe9/CX9t5/fBe1wTyhrj
         c1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=BCbCfmNw3TWJkcE6Svde7cv50NunpK6ZWR+5u993ZLE=;
        b=d44X47oZPNR6ZSXwQg/wZz4hjGWLx4TODP2wTjK6EZd15de0GDkw/3CDRMiOHr+BrU
         2dvQKysFYwrt91HJusuvy7ejNDsXdXt0PnTqEAFD42Ei5BaTGV9PktBKxZn9IUEO+2KQ
         Cuw9yLD/uOncGrAtLdj/S7aJQI04voCtY1dfF8KlkTG5eZjleiaYHJ2Lgl4c/3YUYkgA
         JTWdtwqvHinxQTD2nUEBHIG5Gm7/AGy8rL1QU4aacE9gq6rJclA/3JUPiue2Zpa1Nylq
         p3f/aR7ZIKlnIvEVYiwdW/wzC2SNqN4SmsfBIR+qv88RntD/U/iswHnXkumVPaBNDppX
         bezg==
X-Gm-Message-State: ABuFfojDJLrOtzy8FCoUAi3lpl0bgxpB7yHRplCkURipiGmTRguoibc0
        a7tSEGJYcoqvMd1tGWYHXNNPxw==
X-Google-Smtp-Source: ACcGV61T0KjR++luqDgzcAuFxi4J9zeMjLM4g8tyttvyKnmoc8f+hbTcG0Tvw92DtAWkzzGbXmJ90Q==
X-Received: by 2002:a17:902:ab94:: with SMTP id f20-v6mr1120186plr.231.1538185500835;
        Fri, 28 Sep 2018 18:45:00 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id y4-v6sm8742362pfm.137.2018.09.28.18.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 18:44:59 -0700 (PDT)
Date:   Fri, 28 Sep 2018 18:44:59 -0700 (PDT)
X-Google-Original-Date: Fri, 28 Sep 2018 17:33:35 PDT (-0700)
Subject:     Re: [PATCH 1/2] of/fdt: Allow architectures to override CONFIG_CMDLINE logic
In-Reply-To: <CAL_Jsq+n4e5_ptuh89CJibViGS_bgHz0A+Ki-uwtcGU38+mHXQ@mail.gmail.com>
CC:     paul.burton@mips.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        frowand.list@gmail.com, jaedon.shin@gmail.com, malat@debian.org,
        stable@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     robh+dt@kernel.org
Message-ID: <mhng-01382a17-8203-4155-9caf-20600f88bb37@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <palmer@sifive.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: palmer@sifive.com
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

On Fri, 07 Sep 2018 13:29:03 PDT (-0700), robh+dt@kernel.org wrote:
> On Fri, Sep 7, 2018 at 1:55 PM Paul Burton <paul.burton@mips.com> wrote:
>>
>> The CONFIG_CMDLINE-related logic in early_init_dt_scan_chosen() falls
>> back to copying CONFIG_CMDLINE into boot_command_line/data if the DT has
>> a /chosen node but that node has no bootargs property or a bootargs
>> property of length zero.
>
> The Risc-V guys found a similar issue if chosen is missing[1]. I
> started a patch[2] to address that, but then looking at the different
> arches wasn't sure if I'd break something. I don't recall for sure,
> but it may have been MIPS that worried me.

IIRC we actually determined it didn't even work correctly on RISC-V, but I 
never actually got the time to figure out why and then forgot about it.  Sorry!

>
>> This is problematic for the MIPS architecture because we support
>> concatenating arguments from either the DT or the bootloader with those
>> from CONFIG_CMDLINE, but the behaviour of early_init_dt_scan_chosen()
>> gives us no way of knowing whether boot_command_line contains arguments
>> from DT or already contains CONFIG_CMDLINE. This can lead to us
>> concatenating CONFIG_CMDLINE with itself, duplicating command line
>> arguments which can be problematic (eg. for earlycon which will attempt
>> to register the same console twice & warn about it).
>
> If CONFIG_CMDLINE_EXTEND is set, you know it contains CONFIG_CMDLINE.
> But I guess part of the problem is MIPS using its own kconfig options.
>
>> Move the CONFIG_CMDLINE-related logic to a weak function that
>> architectures can provide their own version of, such that we continue to
>> use the existing logic for architectures where it's suitable but also
>> allow MIPS to override this behaviour such that the architecture code
>> knows when CONFIG_CMDLINE is used.
>
> More arch specific functions is not what I want. Really, all the
> cmdline manipulating logic doesn't belong in DT code, but it shouldn't
> be in the arch specific code either IMO. Really it should be some
> common kernel function which calls into the DT code to retrieve the DT
> bootargs and that's it. Then you can skip calling that kernel function
> if you really need non-standard handling.
>
> Perhaps you should consider filling DT bootargs with the cmdline from
> bootloader. IOW, make the legacy case look like the non-legacy case
> early, and then the kernel doesn't have to deal with both cases later
> on.
>
> Rob
>
> [1] https://lkml.org/lkml/2018/3/14/701
> [2] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git dt/cmdline
