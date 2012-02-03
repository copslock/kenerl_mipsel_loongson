Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2012 12:36:04 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:42931 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903943Ab2BCLf5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Feb 2012 12:35:57 +0100
Received: by bke5 with SMTP id 5so3770970bke.36
        for <multiple recipients>; Fri, 03 Feb 2012 03:35:51 -0800 (PST)
Received: by 10.204.152.208 with SMTP id h16mr3430140bkw.6.1328268951437;
        Fri, 03 Feb 2012 03:35:51 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-86-184.pppoe.mtu-net.ru. [91.79.86.184])
        by mx.google.com with ESMTPS id ga13sm16108930bkc.5.2012.02.03.03.35.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Feb 2012 03:35:50 -0800 (PST)
Message-ID: <4F2BC64F.3070306@mvista.com>
Date:   Fri, 03 Feb 2012 15:34:39 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
MIME-Version: 1.0
To:     Jonas Gorski <jonas.gorski@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH] MIPS: BCM63XX: add missing include for bcm63xx_gpio.h
References: <1328215931-24817-1-git-send-email-jonas.gorski@gmail.com> <4F2BB61F.8010708@mvista.com> <CAOiHx=kG+qhzBSn3stNCG7kyRg64zwVs+xiewi0zz8-GErdhXQ@mail.gmail.com>
In-Reply-To: <CAOiHx=kG+qhzBSn3stNCG7kyRg64zwVs+xiewi0zz8-GErdhXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 03-02-2012 15:17, Jonas Gorski wrote:

>>    You should then addd "Cc: stable@vger.kernel.org" line after your signoff.

> Hrm, somehow I misremember this is supposed to be done only after the
> patch got accepted. You are (mostly) right, only the address is now
> stable@kernel.org :) I'll resend shortly.

    I heard the contrary -- that it was stable@kernel.org and now 
stable@vger.kernel.org.

> a bit more confused than usually,
> Jonas

WBR, Sergei
