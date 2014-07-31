Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2014 10:25:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28267 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6818481AbaGaIZIMaEj0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Jul 2014 10:25:08 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1B219CAA0F532;
        Thu, 31 Jul 2014 09:24:59 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 31 Jul 2014 09:25:00 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 31 Jul
 2014 09:25:00 +0100
Message-ID: <53D9FD5C.6030903@imgtec.com>
Date:   Thu, 31 Jul 2014 09:25:00 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Alex Smith <alex@alex-smith.me.uk>, Ralf <ralf@linux-mips.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-mips <linux-mips@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Aaro Koskinen" <aaro.koskinen@iki.fi>,
        "Markos (GMail)" <markos.chandras@gmail.com>,
        Markos <markos.chandras@imgtec.com>,
        Paul <paul.burton@imgtec.com>,
        Rob Kendrick <rob.kendrick@codethink.co.uk>,
        "Huacai Chen" <chenhc@lemote.com>
Subject: Re: Please add my temporary MIPS fixes branch to linux-next
References: <53D9169D.3020705@imgtec.com> <CAOFt0_C1mCsnn56uhpQy8zR-zhT9T_rK6P8YNAKKkoHrgnT_9g@mail.gmail.com>
In-Reply-To: <CAOFt0_C1mCsnn56uhpQy8zR-zhT9T_rK6P8YNAKKkoHrgnT_9g@mail.gmail.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Hi Alex,

On 30/07/14 19:17, Alex Smith wrote:
> On 30 July 2014 17:00, James Hogan <james.hogan@imgtec.com> wrote:
>> This one fixes mips32 debian boot, but changes the layout of the
>> NT_PRSTATUS regset which is accessible through ptrace. I don't believe
>> this will break anything, but there are other patches pending in the
>> patchset to fix up the regset stuff properly anyway (as it is already
>> broken for core dumps) and I don't really want to take the risk without
>> Ralf's okay.
>>
>> Alex Smith (1):
>>       MIPS: O32/32-bit: Fix bug which can cause incorrect system call
>> restarts
> 
> Right now the NT_PRSTATUS regset can't be relied upon to return the
> same layout anyway, as it can differ depending on whether the kernel
> is 32- or 64-bit, as well as with a couple of other Kconfig options.
> Changing it in this patch shouldn't make things any worse.

Yeh, that is true, and it does fix a real regression.

Since Ralf does appear to be online I'll apply the patch unless he objects.

Cheers
James
