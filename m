Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 May 2013 11:55:13 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:43797 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818020Ab3ECJzLg0m64 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 May 2013 11:55:11 +0200
Received: from mail-ve0-f169.google.com (mail-ve0-f169.google.com [209.85.128.169])
        by mail.nanl.de (Postfix) with ESMTPSA id 24D2145F61;
        Fri,  3 May 2013 09:54:55 +0000 (UTC)
Received: by mail-ve0-f169.google.com with SMTP id jz10so1318672veb.14
        for <multiple recipients>; Fri, 03 May 2013 02:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=SpuRA1kQVD/ZMd12IkjmV2pCC7DdDkhS8ZIYOFB568c=;
        b=hetnlnkuUkIZ/Q2MSPi7IyNlJCKas4rf4rbQEF7fynInl58ayznIp3ddIrzdTE+g3t
         2gpKYDlvGzdh/4NJAvkPRHDMe5x+hgkV5HdGjC4a0AiyPz5MT5J/WmlLTqIpGD0hns9D
         cOHr+pNYUXBv2TxZJhKNwjzv6oRypycOGSzP17L1Fg8f08Km0nws1Fe8eCfOO5gcaXZK
         bERH2wbQISSFDEn8XjouR0KIzt98/YOBbi1QqogKMJFEuBTIZ1q9gKjmSMZCpd8QquuZ
         8zOrQIZjqUTojzOvTbTOAFMOyoanI3X9UDCCTKV35kf0r2816CK0IKXFt4fm4HL/zOc6
         jWMw==
X-Received: by 10.58.75.46 with SMTP id z14mr3400473vev.52.1367574904837; Fri,
 03 May 2013 02:55:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.220.219.198 with HTTP; Fri, 3 May 2013 02:54:43 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1305022303510.2891@ionos>
References: <CA+55aFwDGyHOzu=Qh7SJOBK6QvAwAh7pMDL6LfMUE=AW_kapAw@mail.gmail.com>
 <1367527692-25809-1-git-send-email-ddaney.cavm@gmail.com> <alpine.LFD.2.02.1305022303510.2891@ionos>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Fri, 3 May 2013 11:54:43 +0200
Message-ID: <CAOiHx=khrx+kx_Dv8-DOtm2U9Pv5qW+9HUZyFZQ1joHKY+91-w@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Enable interrupts before WAIT instruction.
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Thu, May 2, 2013 at 11:04 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>
>
> On Thu, 2 May 2013, David Daney wrote:
>
>> From: David Daney <david.daney@cavium.com>
>>
>> As noted by Thomas Gleixner:
>>
>>    commit cdbedc61c8 (mips: Use generic idle loop) broke MIPS as I did
>>    not realize that MIPS wants to invoke the wait instructions with
>>    interrupts enabled.
>>
>> Instead of enabling interrupts in arch_cpu_idle() as Thomas' initial
>> patch does, we follow Linus' suggestion of doing it in the assembly
>> code to prevent the compiler from rearranging things.
>
> Yeah, that looks way more sane.

In a first quick test I can also confirm that it seems to work (as an
alternative to the other fix).


Jonas
