Return-Path: <SRS0=ULQD=RZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1714DC43381
	for <linux-mips@archiver.kernel.org>; Fri, 22 Mar 2019 17:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA7521900
	for <linux-mips@archiver.kernel.org>; Fri, 22 Mar 2019 17:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553274976;
	bh=NPONG8wAWdU8frpkBP04ZDC1Cm0k8bBvTC60p9VG0bk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uroE0cQIwPTXa3aOuuFl11cwNUbR2jHDnLgc+jZZLtuqL8quuOTfeTnp1kc/aFaei
	 lq0eXV0mHFQG8Jhj+6FLdQ92dIYjm8HgFvlwBRiFa/5yqruJZoQunQzk2F9D8yafWy
	 tzaswaSn89toouLWAWXILQNmQBKHYI/ASmJFZhSQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfCVRQQ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:16:16 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45028 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbfCVRQQ (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 22 Mar 2019 13:16:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id n18so2651233ljg.11
        for <linux-mips@vger.kernel.org>; Fri, 22 Mar 2019 10:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=syf5FC/PD4cN6FgIJM2ms3RJG343jtrhSP64Oe75Sac=;
        b=IuhoI3hZaIxE4YvOC0/zFIRPXbZPqr4mch9fB87bJI50v/CesoGw5jPm0Ymj36S+8D
         SIzDojt4m/q1uwaK9P5Is2rLt7NY0cQwo3oRCrDKYwFF22+ZwEkj5rWc3XCpMkx/lh21
         i/oyaRFuahvewUzvmGuDcKpmqMK2Pff6AsG6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=syf5FC/PD4cN6FgIJM2ms3RJG343jtrhSP64Oe75Sac=;
        b=l6h7oeHXWdx9HBZmtQQZEVDoaRj3ST14EZVaNUW9Iis8tf2+vPd4liIsY1KFsP0Gan
         cCdEKXd2ZVbh1mA1SL9pnoY8kk143Q+bq/zZGNNo4ez5KJqGr+7s4Y5nS2BeH+K1Vm3Z
         SWtQ0wYQcoQLe7RgAQ3phjywzbgvjxMHF4G89KMpeXpAemePD2viNTLIgspP44IqcLhn
         MpCf/N/XiYUNyIKP/30I2mihdY+ZJy5mdI1b6W4cNFJgNLe0MwbplUBOtBfWHjqQ8Fnx
         EtC9ETP88Rwu2waWkKR1qrP3e0na2ElG5GNT40B3E23pl3z9GxuQnYRnwBtcCy1w9QUv
         3qAg==
X-Gm-Message-State: APjAAAWUR/O3P+TwOS0Wcw9Ik1jUhgKetZPmfXP5abl8ej8ixtXRN0SA
        1bSharRLXneo8xrEj+A2Bz5JjliGMvk=
X-Google-Smtp-Source: APXvYqzsZ2s9Bb0qu97QWt6XnPkvQWMVHjUAexnJQlZT1jm5FIB7fXZDUgZnHfRTCRD12Aam6u2Nkg==
X-Received: by 2002:a2e:86ca:: with SMTP id n10mr5898274ljj.135.1553274973918;
        Fri, 22 Mar 2019 10:16:13 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id o3sm1835964lfd.53.2019.03.22.10.16.13
        for <linux-mips@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 10:16:13 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id t13so2693928lji.2
        for <linux-mips@vger.kernel.org>; Fri, 22 Mar 2019 10:16:13 -0700 (PDT)
X-Received: by 2002:a2e:86ca:: with SMTP id n10mr5880284ljj.135.1553274524897;
 Fri, 22 Mar 2019 10:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190322143008.21313-1-longman@redhat.com> <20190322143008.21313-4-longman@redhat.com>
In-Reply-To: <20190322143008.21313-4-longman@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Mar 2019 10:08:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0wwmY-waC1-2SmBz4-XK-Eru2RTx6PrGzUK=P1nwexQ@mail.gmail.com>
Message-ID: <CAHk-=wi0wwmY-waC1-2SmBz4-XK-Eru2RTx6PrGzUK=P1nwexQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] locking/rwsem: Optimize down_read_trylock()
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org, uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Fri, Mar 22, 2019 at 7:30 AM Waiman Long <longman@redhat.com> wrote:
>
> Modify __down_read_trylock() to optimize for an unlocked rwsem and make
> it generate slightly better code.

Oh, that should teach me to read all patches in the series before
starting to comment on them.

So ignore my comment on #1.

                Linus
