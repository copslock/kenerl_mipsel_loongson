Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2014 09:46:17 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:48125 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817913AbaDJHqPGsH5N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Apr 2014 09:46:15 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C997E81A61039;
        Thu, 10 Apr 2014 08:46:06 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 10 Apr 2014 08:46:08 +0100
Received: from [192.168.154.89] (192.168.154.89) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 10 Apr
 2014 08:46:07 +0100
Message-ID: <53464C52.2060004@imgtec.com>
Date:   Thu, 10 Apr 2014 08:46:26 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To:     Jonas Gorski <jogo@openwrt.org>
CC:     MIPS Mailing List <linux-mips@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 13/14] MIPS: net: Add BPF JIT
References: <1396957635-27071-14-git-send-email-markos.chandras@imgtec.com> <1397059208-27096-1-git-send-email-markos.chandras@imgtec.com> <CAOiHx=kh3+Xzvyx7PsEfNCiEf6cRP3ucQKDfY3brZ6FR2KwW4Q@mail.gmail.com>
In-Reply-To: <CAOiHx=kh3+Xzvyx7PsEfNCiEf6cRP3ucQKDfY3brZ6FR2KwW4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.89]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39758
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

On 04/09/2014 11:28 PM, Jonas Gorski wrote:
>
>> +#ifdef CONFIG_CPU_LITTLE_ENDIAN
>> +                       /* This needs little endian fixup */
>> +                       if (config_enabled(CPU_MIPSR1)) {
>
> Hm, looking at arch/mips/Kconfig, this will falsely identify CPU_BMIPS
> as R2 as it does not select CPU_MIPSR1.
>
> How about "if (cpu_has_mips_r1)"? There are some targets that have
> both R1 and R2 cores (e.g. bcm47xx), and even if we built the kernel
> for R1, it does not prevent us from emitting R2 instructions because
> we do this at runtime when we can check for it.

Sounds about right. Let me have a look


-- 
markos
