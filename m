Return-Path: <SRS0=jxI9=VI=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9791C31E42
	for <linux-mips@archiver.kernel.org>; Thu, 11 Jul 2019 17:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832F421670
	for <linux-mips@archiver.kernel.org>; Thu, 11 Jul 2019 17:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Da22eipD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfGKROX (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:14:23 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42406 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbfGKROX (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 11 Jul 2019 13:14:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so3353851plb.9
        for <linux-mips@vger.kernel.org>; Thu, 11 Jul 2019 10:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ucw9rSRviGvxmtHa1eJcbGqoOfZIZgp2Nd0u5B3lWZA=;
        b=Da22eipDrFV3sVjp5lhMK1Ag4ov7GIbghnsCPMLPbWr4HTpMO+0Xb4J2rn8DRx6qHT
         raOPgwKUlI6vG5+eZKye7qCGQQETow7AmhpRoh5cHUdPCXlRT2cKL12Jq3MiFeBw679W
         wk1YpqERzczakZBDQQ8pko2DW4C1f70wJ9S/ns+5k4w9umeU1hYehewCAr5tVqqhs2DW
         GqdMBotLNyKw4ICag2o2Axnjtx62CvFcXWSjSNMUtdvoLBIYxzy7ujuT7vx9Sj96r9wA
         vjLfAdfQxMO9pCXH+JWhO4dfi00ckikjgNwJov9+WJZ2h2rnzwxooDe//g0ahmSlempo
         WnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ucw9rSRviGvxmtHa1eJcbGqoOfZIZgp2Nd0u5B3lWZA=;
        b=EuSg2tnrqA0BR9KCNK6JF92da5b0cuaRwllO/i3P1Kx5ilvsG/vfGbvQryMQW4CKRs
         GviCHO4LksD7Tqr5/tGMgwVetO4NKJMdjF5RxmQ2uX3Nf+360Lxc0kiezBxLRPUE13i6
         fwj1A0dyCD+jxr6KSGksLOwmvHo5AlNCDrInc+223VHPfnIWxGPKJfBV/llqXOY4E752
         /9PWgr5Le9dA8+es/NxZLd8YfJT4hxYHJF1MibJ+dH7oQnZIROAXVlpXdJGb8oK6yBk0
         ULIg10061P/VoCH1WDoEDwk3mG4c1lylaohgwkT87r1gDnaKi+FB4ab+v9OKE6KUtXmO
         4eIw==
X-Gm-Message-State: APjAAAUlCrd4Ny1lW23Zlc9ajxXU+3htKitztK24SOVeAhAPZu69K7ft
        2RaUSPWqna6ljUinzgpCcv4b1dTPNXBvbYLi4ms7pg==
X-Google-Smtp-Source: APXvYqyCiqSqHnYjKAeXDLQuC0c8sZpZJD60JXgP1quXPWouPH4pF7fZdEdLqQyRgFNNeHBCL0hiMDCMtYcdYDM2b4s=
X-Received: by 2002:a17:902:9f93:: with SMTP id g19mr5777071plq.223.1562865261987;
 Thu, 11 Jul 2019 10:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190710130206.1670830-1-arnd@arndb.de> <33511b0e-6d7b-c156-c415-7a609b049567@arm.com>
 <CAK8P3a1EBaWdbAEzirFDSgHVJMtWjuNt2HGG8z+vpXeNHwETFQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1EBaWdbAEzirFDSgHVJMtWjuNt2HGG8z+vpXeNHwETFQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 11 Jul 2019 10:14:10 -0700
Message-ID: <CAKwvOdkubvsRCnJKCaesB=PF=DgXfsBzwzR8kyE9NzWPU8Gehg@mail.gmail.com>
Subject: Re: [PATCH] vsyscall: use __iter_div_u64_rem()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mips@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Thu, Jul 11, 2019 at 5:28 AM Arnd Bergmann <arnd@arndb.de> wrote:
> clang does not like an inline assembly with a "=q" contraint for
> a 64-bit output:

Seems like starting in GCC 7, GCC may not like it either:
https://godbolt.org/z/UyBUfh
it simply warns then proceeds with code gen.  Another difference may
come from when GCC vs Clang perform dead code elimination (DCE) vs
semantic analysis.

-- 
Thanks,
~Nick Desaulniers
