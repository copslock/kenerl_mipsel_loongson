Return-Path: <SRS0=ULQD=RZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2D8C43381
	for <linux-mips@archiver.kernel.org>; Fri, 22 Mar 2019 17:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB16A21917
	for <linux-mips@archiver.kernel.org>; Fri, 22 Mar 2019 17:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553274815;
	bh=ZAh4cwuJavt2z9KTEO6p7hKKHwYKJaaWgEufMtMOppI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=t0/VTJeTviPgOhYU3TuzzMwnRLvcTj6ic27oBmQAGwkuu06/hHzGjdHxwwb4Ow6te
	 OVhsH+tHZNSomIqFus/KIYLRna24vJ8RwAHcnXDF7MsYC6Ul7K27GtD7F2bhWx1zQR
	 UO2+V0ZZ3MBL0Ajho392CYpmxdfePxtYRYCq7oJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfCVRNf (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:13:35 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39704 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbfCVRNf (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 22 Mar 2019 13:13:35 -0400
Received: by mail-lf1-f67.google.com with SMTP id m13so1899713lfb.6
        for <linux-mips@vger.kernel.org>; Fri, 22 Mar 2019 10:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K5KpCUavpU6jklxItqvKr4mbyrohs/asqf5NX0BYYpc=;
        b=Xicmuh1ND+AZ9lc/udGkNvWbzi2Lu2j3o6M44sYQ0ZH2WsGeVBgW5f2xPJwNTxlY2d
         JaSMsr2SEVdWRDbZBYCXJ0vB1W1wIN3vVWqOMIiqWhD3oBYZFF9I7ROZZs9bJvkPzu9N
         HN8UN8zBc9zkjew06tZVB45+s5iWpvEon1EZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K5KpCUavpU6jklxItqvKr4mbyrohs/asqf5NX0BYYpc=;
        b=srq0aqn4w1S5d/laofHY0HeiT1EIn5Hv6B8radunpmgbPxx5o36RR6iUhroGd3XiYY
         jCk6TncJIpLnRIQUlKiU51qlNKs6sT7tTwsZVQAefsd+mbEcJOwzS84MGFdGmixV8EwH
         U7sM+13VxO3SwBuWrphWrpX1TaSMkZ34a1zqW4PiI29mvUW8uZn47ljhgWZla8HhKFAj
         i2QzAPSZV2t2EBRjT7OoOu23YOExCStRBTDj9gGziNm4FMWANq68TsqEvjvKoXpxLFEy
         BZoR5IqOOl4+SI4pyrIX2ORH/s2Mb0Jgf0yNz9VwS7mwUwpySBjFajnPbXGPobMMI8x9
         dguw==
X-Gm-Message-State: APjAAAWUkU5HXcHgYL+YibwHXPubrlu21FnD4Me8T3lI9Cig8YXn+q4U
        kUgEMpwgl3rW2/Anm8xpQzqwpwb9JRs=
X-Google-Smtp-Source: APXvYqyHOuCzQ9UnO4N89Y9XW577Fdnd5VWnNG26f/zRcFfwhU4e4C5uKqE3WIbOtIYXhnlD01/Mxg==
X-Received: by 2002:a19:6d01:: with SMTP id i1mr5635962lfc.118.1553274812809;
        Fri, 22 Mar 2019 10:13:32 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id u26sm1803219lfi.41.2019.03.22.10.13.32
        for <linux-mips@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 10:13:32 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id k8so2670775lja.8
        for <linux-mips@vger.kernel.org>; Fri, 22 Mar 2019 10:13:32 -0700 (PDT)
X-Received: by 2002:a2e:9786:: with SMTP id y6mr5380150lji.79.1553274440270;
 Fri, 22 Mar 2019 10:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190322143008.21313-1-longman@redhat.com> <20190322143008.21313-3-longman@redhat.com>
In-Reply-To: <20190322143008.21313-3-longman@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Mar 2019 10:07:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjujKK-Ey7DPnMExaEmphicuEDLmVn-9+W9VzFzR-Ts=A@mail.gmail.com>
Message-ID: <CAHk-=wjujKK-Ey7DPnMExaEmphicuEDLmVn-9+W9VzFzR-Ts=A@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] locking/rwsem: Remove rwsem-spinlock.c & use
 rwsem-xadd.c for all archs
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
> For simplication, we are going to remove rwsem-spinlock.c and make all
> architectures use a single implementation of rwsem - rwsem-xadd.c.

Ack.

               Linus
