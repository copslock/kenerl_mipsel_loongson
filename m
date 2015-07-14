Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 14:21:37 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41685 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009286AbbGNMVgYWfo0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jul 2015 14:21:36 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id F390C698E1018;
        Tue, 14 Jul 2015 13:21:27 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 14 Jul 2015 13:21:30 +0100
Received: from [192.168.154.48] (192.168.154.48) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 14 Jul
 2015 13:21:29 +0100
Subject: Re: [PATCH v2 14/19] drivers: irqchip: irq-mips-gic: Extend GIC
 accessors for 64-bit CMs
To:     Jonas Gorski <jogo@openwrt.org>
References: <1436434853-30001-15-git-send-email-markos.chandras@imgtec.com>
 <1436865969-2977-1-git-send-email-markos.chandras@imgtec.com>
 <CAOiHx=nk21aCw-ZFQJDrPX2W29e5GNZ1s5huFwpJ8b0+88BrTw@mail.gmail.com>
CC:     MIPS Mailing List <linux-mips@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Bresticker <abrestic@chromium.org>,
        Paul Burton <paul.burton@imgtec.com>
From:   Markos Chandras <Markos.Chandras@imgtec.com>
Message-ID: <55A4FEC9.5050706@imgtec.com>
Date:   Tue, 14 Jul 2015 13:21:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
MIME-Version: 1.0
In-Reply-To: <CAOiHx=nk21aCw-ZFQJDrPX2W29e5GNZ1s5huFwpJ8b0+88BrTw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48269
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 07/14/2015 12:57 PM, Jonas Gorski wrote:
> Hi,
> 
> On Tue, Jul 14, 2015 at 11:26 AM, Markos Chandras
> <markos.chandras@imgtec.com> wrote:
>> Previously, the GIC accessors were only accessing u32 registers but
>> newer CMs may actually be 64-bit on MIPS64 cores. As a result of which,
>> extended these accessors to support 64-bit reads and writes.
> 
> Have you tested this with a 32-bit build? IIRC the *q accessors are
> only available on 64-bit builds.
> 
> 
> Jonas
> 
Yes but mips_cm_is64 is 0 for 32-bit kernels (see
https://patchwork.linux-mips.org/patch/10707/) so it does not matter.
but mips implements *q for 32-bit in arch/mips/include/asm/io.h anyway

-- 
markos
