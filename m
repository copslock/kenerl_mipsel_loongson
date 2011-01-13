Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jan 2011 16:02:16 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:53034 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492678Ab1AMPCN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Jan 2011 16:02:13 +0100
Message-ID: <4D2F143A.2000708@openwrt.org>
Date:   Thu, 13 Jan 2011 16:03:22 +0100
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100913 Icedove/3.0.7
MIME-Version: 1.0
To:     Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 01/10] MIPS: lantiq: add initial support for Lantiq SoCs
References: <1294257379-417-1-git-send-email-blogic@openwrt.org>        <1294257379-417-2-git-send-email-blogic@openwrt.org>        <AANLkTinBovWsPak3cCNRMigC8mxUwEik2oB3kSsw-YQL@mail.gmail.com>        <4D2EDE92.40203@openwrt.org> <AANLkTingxSonua3v+9rqCJeuV-TjiMBX_BfxxHYOcBoe@mail.gmail.com>
In-Reply-To: <AANLkTingxSonua3v+9rqCJeuV-TjiMBX_BfxxHYOcBoe@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

On 13/01/11 13:47, Daniel Schwierzeck wrote:
> Hi John,
>
> 2011/1/13 John Crispin <blogic@openwrt.org>:
>   
>>     
>>>> +
>>>> +/* all access to the ebu must be locked */
>>>> +DEFINE_SPINLOCK(ebu_lock);
>>>> +EXPORT_SYMBOL_GPL(ebu_lock);
>>>>
>>>>         
>>> This lock is only needed if you want to use software arbitration.
>>> Normally the EBU does hardware arbitration and can be accessed safely
>>> without lock.
>>>
>>>
>>>       
>> openwrt borks up on mini_fo init when this lock is not in-place. we saw
>> a lot of issues in the past which lead to this lock being added. i will
>> retry it with out the lock to verify
>>
>>     
> Ok I never tried mini_fo bit it's working fine with squashfs. Maybe
> it's a problem with your EBU setup. We always reset
> the EBU_ADDR_SEL0 and EBU_CON_0 registers in U-Boot's lowlevel_init.S.
> The values are EBU_ADDR_SEL0 = 0x10000021
> and EBU_CON_0 = 0x8001F7FF.
> My suggestion is to wrap the locking mechanism into separate inline
> functions and define them only if really needed and enabled in kernel
> config.
>
> Daniel
>
>
>   
Ok, i will try with those values to see if the EBU is setup incorrectly,
thx for the pointers !
