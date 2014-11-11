Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 10:42:44 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51122 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013349AbaKKJmmHWhFI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Nov 2014 10:42:42 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id ECB54E67AF297;
        Tue, 11 Nov 2014 09:42:33 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 11 Nov 2014 09:42:36 +0000
Received: from [192.168.154.149] (192.168.154.149) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 11 Nov
 2014 09:42:35 +0000
Message-ID: <5461DA0B.2050505@imgtec.com>
Date:   Tue, 11 Nov 2014 09:42:35 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/3] MIPS: kernel: traps: Replace printk with pr_info
 for MC exceptions
References: <1415636404-11979-1-git-send-email-markos.chandras@imgtec.com> <1415636404-11979-2-git-send-email-markos.chandras@imgtec.com> <5460EAFC.8020004@gmail.com>
In-Reply-To: <5460EAFC.8020004@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.149]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43979
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

On 11/10/2014 04:42 PM, David Daney wrote:
> On 11/10/2014 08:20 AM, Markos Chandras wrote:
>> printk should not be used without a KERN_ facility level
>>
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>> ---
>>   arch/mips/kernel/traps.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
>> index 22b19c275044..51fa5c3aa4fe 100644
>> --- a/arch/mips/kernel/traps.c
>> +++ b/arch/mips/kernel/traps.c
>> @@ -1380,12 +1380,12 @@ asmlinkage void do_mcheck(struct pt_regs *regs)
>>       show_regs(regs);
>>
>>       if (multi_match) {
>> -        printk("Index    : %0x\n", read_c0_index());
>> -        printk("Pagemask: %0x\n", read_c0_pagemask());
>> -        printk("EntryHi : %0*lx\n", field, read_c0_entryhi());
>> -        printk("EntryLo0: %0*lx\n", field, read_c0_entrylo0());
>> -        printk("EntryLo1: %0*lx\n", field, read_c0_entrylo1());
>> -        printk("\n");
>> +        pr_info("Index    : %0x\n", read_c0_index());
>> +        pr_info("Pagemask: %0x\n", read_c0_pagemask());
>> +        pr_info("EntryHi : %0*lx\n", field, read_c0_entryhi());
>> +        pr_info("EntryLo0: %0*lx\n", field, read_c0_entrylo0());
>> +        pr_info("EntryLo1: %0*lx\n", field, read_c0_entrylo1());
>> +        pr_info("\n");
> 
> MachineCheck is a serious problem, If we change this at all, I would
> suggest pr_err() instead.
> 
> David Daney
Hi,

Ok I will change all of them to pr_err().

-- 
markos
