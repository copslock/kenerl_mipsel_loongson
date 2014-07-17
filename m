Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2014 11:02:56 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41266 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861302AbaGQJCwGqtxB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2014 11:02:52 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E88111FD0EC65;
        Thu, 17 Jul 2014 10:02:42 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 17 Jul 2014 10:02:45 +0100
Received: from [192.168.154.89] (192.168.154.89) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 17 Jul
 2014 10:02:44 +0100
Message-ID: <53C7912A.4080404@imgtec.com>
Date:   Thu, 17 Jul 2014 10:02:34 +0100
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Michal Nazarewicz <mina86@mina86.com>, <ralf@linux-mips.org>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <m.szyprowski@samsung.com>
CC:     <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 3/4] x86: use generic dma-contiguous.h
References: <1405525892-60383-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1405525892-60383-4-git-send-email-Zubair.Kakakhel@imgtec.com> <xa1ta989b7ha.fsf@mina86.com>
In-Reply-To: <xa1ta989b7ha.fsf@mina86.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.89]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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



On 16/07/14 17:20, Michal Nazarewicz wrote:
> On Wed, Jul 16 2014, Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com> wrote:
>> dma-contiguous.h is now in asm-generic. Use that to avoid code
>> repetition in x86.
>>
>> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> 
> Acked-by: Michal Nazarewicz <mina86@mina86.com>
> 
> But to be honest, I would fold the three into a single commit.

Thank-you for the acks. I understand as its a trivial change.

But architectures like it separate. They will obviously go
together via one tree.

ZubairLK
