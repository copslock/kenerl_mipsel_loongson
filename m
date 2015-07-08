Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jul 2015 18:38:40 +0200 (CEST)
Received: from mail-la0-f52.google.com ([209.85.215.52]:34219 "EHLO
        mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010243AbbGHQijTG2B- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Jul 2015 18:38:39 +0200
Received: by lagx9 with SMTP id x9so229153878lag.1
        for <linux-mips@linux-mips.org>; Wed, 08 Jul 2015 09:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Q6Kze5reNlRD2JFezAlnTpThtzGYXChwGMtqaOJ8iEw=;
        b=lCah8EP/MsUoY0Xe2DG6+nLXwoatB0blU8xG5Rq33w32exVthj+8V/zVp81tEQodNC
         WvakKdLb16pEE9X4kLyYq2I50YSB+PkAVVnQVDzk2LXA6LCgiX9KxLETBAHsuZaxuGe8
         Q74GjPQNacj4W2Ao/XoqoLD6VnDWEJJMRJoQCUEJdjFOys5ofs8Blsis/j5XluSkCX4A
         i3Ued/GbmD1Us9sv0QwohTlix7mwK4F3agcqiHMdrWG5cYqC1EguBaEvYSzvk1KVU2Wi
         UWJCOJnqzROAy1YGicTsvdL0vOkjg0HePRnVZcK86869GJEa+PMUVsc8ae6mkfb1caTX
         GpYQ==
X-Gm-Message-State: ALoCoQlpzBYB76urUdtXn25A3rDY9hDqo3oMVsGIkDYqzJ7Yfft0LyaOgz1yjVleSQXftoUvsxpS
X-Received: by 10.152.121.99 with SMTP id lj3mr10187118lab.37.1436373513902;
        Wed, 08 Jul 2015 09:38:33 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp27-103.pppoe.mtu-net.ru. [81.195.27.103])
        by smtp.gmail.com with ESMTPSA id km9sm763894lbb.44.2015.07.08.09.38.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2015 09:38:32 -0700 (PDT)
Message-ID: <559D5206.80209@cogentembedded.com>
Date:   Wed, 08 Jul 2015 19:38:30 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH] MIPS, IRQCHIP: Move i8259 irqchip driver to drivers/irqchip.
References: <20150708124608.GS18167@linux-mips.org>
In-Reply-To: <20150708124608.GS18167@linux-mips.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

On 07/08/2015 03:46 PM, Ralf Baechle wrote:

    I don't see any signoffs.

>   arch/mips/Kconfig           |   4 -
>   arch/mips/kernel/Makefile   |   1 -
>   arch/mips/kernel/i8259.c    | 384 --------------------------------------------
>   drivers/irqchip/Kconfig     |   4 +
>   drivers/irqchip/Makefile    |   1 +
>   drivers/irqchip/irq-i8259.c | 383 +++++++++++++++++++++++++++++++++++++++++++

    Please use the -M switch with 'git format-patch'.

>   6 files changed, 388 insertions(+), 389 deletions(-)

WBR, Sergei
