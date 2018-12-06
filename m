Return-Path: <SRS0=dj/1=OP=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440F2C04EB8
	for <linux-mips@archiver.kernel.org>; Thu,  6 Dec 2018 20:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2B72064D
	for <linux-mips@archiver.kernel.org>; Thu,  6 Dec 2018 20:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2B72064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbeLFUPZ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:15:25 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:65401 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbeLFUPZ (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 6 Dec 2018 15:15:25 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 439n0B71Wvz9tyh6;
        Thu,  6 Dec 2018 21:15:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 2mtvfETmqdqw; Thu,  6 Dec 2018 21:15:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 439n0B5jmwz9tyh5;
        Thu,  6 Dec 2018 21:15:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DA3368B89D;
        Thu,  6 Dec 2018 21:15:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id aMlPjUKYU4SA; Thu,  6 Dec 2018 21:15:22 +0100 (CET)
Received: from [192.168.232.3] (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2DD788B88E;
        Thu,  6 Dec 2018 21:15:18 +0100 (CET)
Subject: Re: [PATCH 2/2] kgdb/treewide: constify struct kgdb_arch
 arch_kgdb_ops
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Kuo <rkuo@codeaurora.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ley Foon Tan <lftan@altera.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net
References: <75bbcdd1e9277d66ebb06e349dda304bd01ce761.1543957194.git.christophe.leroy@c-s.fr>
 <6b1a19ffa0da02cff9b82b866ba31d57478501ce.1543957194.git.christophe.leroy@c-s.fr>
 <20181206140716.apapnpmdk3nrn7i3@holly.lan>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <0aeb76ee-7250-3833-82f9-44db98cc142a@c-s.fr>
Date:   Thu, 6 Dec 2018 21:15:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181206140716.apapnpmdk3nrn7i3@holly.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org



Le 06/12/2018 à 15:07, Daniel Thompson a écrit :
> On Wed, Dec 05, 2018 at 04:41:11AM +0000, Christophe Leroy wrote:
>> checkpatch.pl reports the following:
>>
>>    WARNING: struct kgdb_arch should normally be const
>>    #28: FILE: arch/mips/kernel/kgdb.c:397:
>>    +struct kgdb_arch arch_kgdb_ops = {
>>
>> This report makes sense, as all other ops struct, this
>> one should also be const. This patch does the change.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Similar to https://patchwork.kernel.org/patch/10701129/ I would be more
> comfortable to see a resend with the relevant arch maintainers
> explicitly called out with a Cc: entry here.

Done in v2

And
Acked-by: Paul Burton <paul.burton@mips.com>

Thanks
Christophe

> 
> 
>> ---
>>   arch/arc/kernel/kgdb.c        | 2 +-
>>   arch/arm/kernel/kgdb.c        | 2 +-
>>   arch/arm64/kernel/kgdb.c      | 2 +-
>>   arch/h8300/kernel/kgdb.c      | 2 +-
>>   arch/hexagon/kernel/kgdb.c    | 2 +-
>>   arch/microblaze/kernel/kgdb.c | 2 +-
>>   arch/mips/kernel/kgdb.c       | 2 +-
>>   arch/nios2/kernel/kgdb.c      | 2 +-
>>   arch/powerpc/kernel/kgdb.c    | 2 +-
>>   arch/sh/kernel/kgdb.c         | 2 +-
>>   arch/sparc/kernel/kgdb_32.c   | 2 +-
>>   arch/sparc/kernel/kgdb_64.c   | 2 +-
>>   arch/x86/kernel/kgdb.c        | 2 +-
>>   include/linux/kgdb.h          | 2 +-
>>   14 files changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arc/kernel/kgdb.c b/arch/arc/kernel/kgdb.c
>> index 9a3c34af2ae8..bfd04b442e36 100644
>> --- a/arch/arc/kernel/kgdb.c
>> +++ b/arch/arc/kernel/kgdb.c
>> @@ -204,7 +204,7 @@ void kgdb_roundup_cpus(unsigned long flags)
>>   	local_irq_disable();
>>   }
>>   
>> -struct kgdb_arch arch_kgdb_ops = {
>> +const struct kgdb_arch arch_kgdb_ops = {
>>   	/* breakpoint instruction: TRAP_S 0x3 */
>>   #ifdef CONFIG_CPU_BIG_ENDIAN
>>   	.gdb_bpt_instr		= {0x78, 0x7e},
>> diff --git a/arch/arm/kernel/kgdb.c b/arch/arm/kernel/kgdb.c
>> index caa0dbe3dc61..21a6d5958955 100644
>> --- a/arch/arm/kernel/kgdb.c
>> +++ b/arch/arm/kernel/kgdb.c
>> @@ -274,7 +274,7 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
>>    * and we handle the normal undef case within the do_undefinstr
>>    * handler.
>>    */
>> -struct kgdb_arch arch_kgdb_ops = {
>> +const struct kgdb_arch arch_kgdb_ops = {
>>   #ifndef __ARMEB__
>>   	.gdb_bpt_instr		= {0xfe, 0xde, 0xff, 0xe7}
>>   #else /* ! __ARMEB__ */
>> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
>> index a20de58061a8..fe1d1f935b90 100644
>> --- a/arch/arm64/kernel/kgdb.c
>> +++ b/arch/arm64/kernel/kgdb.c
>> @@ -357,7 +357,7 @@ void kgdb_arch_exit(void)
>>   	unregister_die_notifier(&kgdb_notifier);
>>   }
>>   
>> -struct kgdb_arch arch_kgdb_ops;
>> +const struct kgdb_arch arch_kgdb_ops;
>>   
>>   int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
>>   {
>> diff --git a/arch/h8300/kernel/kgdb.c b/arch/h8300/kernel/kgdb.c
>> index 1a1d30cb0609..602e478afbd5 100644
>> --- a/arch/h8300/kernel/kgdb.c
>> +++ b/arch/h8300/kernel/kgdb.c
>> @@ -129,7 +129,7 @@ void kgdb_arch_exit(void)
>>   	/* Nothing to do */
>>   }
>>   
>> -struct kgdb_arch arch_kgdb_ops = {
>> +const struct kgdb_arch arch_kgdb_ops = {
>>   	/* Breakpoint instruction: trapa #2 */
>>   	.gdb_bpt_instr = { 0x57, 0x20 },
>>   };
>> diff --git a/arch/hexagon/kernel/kgdb.c b/arch/hexagon/kernel/kgdb.c
>> index 16c24b22d0b2..f1924d483e78 100644
>> --- a/arch/hexagon/kernel/kgdb.c
>> +++ b/arch/hexagon/kernel/kgdb.c
>> @@ -83,7 +83,7 @@ struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
>>   	{ "syscall_nr", GDB_SIZEOF_REG, offsetof(struct pt_regs, syscall_nr)},
>>   };
>>   
>> -struct kgdb_arch arch_kgdb_ops = {
>> +const struct kgdb_arch arch_kgdb_ops = {
>>   	/* trap0(#0xDB) 0x0cdb0054 */
>>   	.gdb_bpt_instr = {0x54, 0x00, 0xdb, 0x0c},
>>   };
>> diff --git a/arch/microblaze/kernel/kgdb.c b/arch/microblaze/kernel/kgdb.c
>> index 6366f69d118e..130cd0f064ce 100644
>> --- a/arch/microblaze/kernel/kgdb.c
>> +++ b/arch/microblaze/kernel/kgdb.c
>> @@ -143,7 +143,7 @@ void kgdb_arch_exit(void)
>>   /*
>>    * Global data
>>    */
>> -struct kgdb_arch arch_kgdb_ops = {
>> +const struct kgdb_arch arch_kgdb_ops = {
>>   #ifdef __MICROBLAZEEL__
>>   	.gdb_bpt_instr = {0x18, 0x00, 0x0c, 0xba}, /* brki r16, 0x18 */
>>   #else
>> diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
>> index 31eff1bec577..edfdc2ec2d16 100644
>> --- a/arch/mips/kernel/kgdb.c
>> +++ b/arch/mips/kernel/kgdb.c
>> @@ -394,7 +394,7 @@ int kgdb_arch_handle_exception(int vector, int signo, int err_code,
>>   	return -1;
>>   }
>>   
>> -struct kgdb_arch arch_kgdb_ops = {
>> +const struct kgdb_arch arch_kgdb_ops = {
>>   #ifdef CONFIG_CPU_BIG_ENDIAN
>>   	.gdb_bpt_instr = { spec_op << 2, 0x00, 0x00, break_op },
>>   #else
>> diff --git a/arch/nios2/kernel/kgdb.c b/arch/nios2/kernel/kgdb.c
>> index 117859122d1c..37b25f844a2d 100644
>> --- a/arch/nios2/kernel/kgdb.c
>> +++ b/arch/nios2/kernel/kgdb.c
>> @@ -165,7 +165,7 @@ void kgdb_arch_exit(void)
>>   	/* Nothing to do */
>>   }
>>   
>> -struct kgdb_arch arch_kgdb_ops = {
>> +const struct kgdb_arch arch_kgdb_ops = {
>>   	/* Breakpoint instruction: trap 30 */
>>   	.gdb_bpt_instr = { 0xba, 0x6f, 0x3b, 0x00 },
>>   };
>> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
>> index 59c578f865aa..bdb588b1d8fb 100644
>> --- a/arch/powerpc/kernel/kgdb.c
>> +++ b/arch/powerpc/kernel/kgdb.c
>> @@ -477,7 +477,7 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
>>   /*
>>    * Global data
>>    */
>> -struct kgdb_arch arch_kgdb_ops;
>> +const struct kgdb_arch arch_kgdb_ops;
>>   
>>   static int kgdb_not_implemented(struct pt_regs *regs)
>>   {
>> diff --git a/arch/sh/kernel/kgdb.c b/arch/sh/kernel/kgdb.c
>> index 4f04c6638a4d..a24c48446e98 100644
>> --- a/arch/sh/kernel/kgdb.c
>> +++ b/arch/sh/kernel/kgdb.c
>> @@ -382,7 +382,7 @@ void kgdb_arch_exit(void)
>>   	unregister_die_notifier(&kgdb_notifier);
>>   }
>>   
>> -struct kgdb_arch arch_kgdb_ops = {
>> +const struct kgdb_arch arch_kgdb_ops = {
>>   	/* Breakpoint instruction: trapa #0x3c */
>>   #ifdef CONFIG_CPU_LITTLE_ENDIAN
>>   	.gdb_bpt_instr		= { 0x3c, 0xc3 },
>> diff --git a/arch/sparc/kernel/kgdb_32.c b/arch/sparc/kernel/kgdb_32.c
>> index 639c8e54530a..7580775a14b9 100644
>> --- a/arch/sparc/kernel/kgdb_32.c
>> +++ b/arch/sparc/kernel/kgdb_32.c
>> @@ -166,7 +166,7 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long ip)
>>   	regs->npc = regs->pc + 4;
>>   }
>>   
>> -struct kgdb_arch arch_kgdb_ops = {
>> +const struct kgdb_arch arch_kgdb_ops = {
>>   	/* Breakpoint instruction: ta 0x7d */
>>   	.gdb_bpt_instr		= { 0x91, 0xd0, 0x20, 0x7d },
>>   };
>> diff --git a/arch/sparc/kernel/kgdb_64.c b/arch/sparc/kernel/kgdb_64.c
>> index a68bbddbdba4..5d6c2d287e85 100644
>> --- a/arch/sparc/kernel/kgdb_64.c
>> +++ b/arch/sparc/kernel/kgdb_64.c
>> @@ -195,7 +195,7 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long ip)
>>   	regs->tnpc = regs->tpc + 4;
>>   }
>>   
>> -struct kgdb_arch arch_kgdb_ops = {
>> +const struct kgdb_arch arch_kgdb_ops = {
>>   	/* Breakpoint instruction: ta 0x72 */
>>   	.gdb_bpt_instr		= { 0x91, 0xd0, 0x20, 0x72 },
>>   };
>> diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
>> index 8e36f249646e..e7effc02f13c 100644
>> --- a/arch/x86/kernel/kgdb.c
>> +++ b/arch/x86/kernel/kgdb.c
>> @@ -804,7 +804,7 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
>>   				  (char *)bpt->saved_instr, BREAK_INSTR_SIZE);
>>   }
>>   
>> -struct kgdb_arch arch_kgdb_ops = {
>> +const struct kgdb_arch arch_kgdb_ops = {
>>   	/* Breakpoint instruction: */
>>   	.gdb_bpt_instr		= { 0xcc },
>>   	.flags			= KGDB_HW_BREAKPOINT,
>> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
>> index e465bb15912d..3bf313311cca 100644
>> --- a/include/linux/kgdb.h
>> +++ b/include/linux/kgdb.h
>> @@ -281,7 +281,7 @@ struct kgdb_io {
>>   	int			is_console;
>>   };
>>   
>> -extern struct kgdb_arch		arch_kgdb_ops;
>> +extern const struct kgdb_arch		arch_kgdb_ops;
>>   
>>   extern unsigned long kgdb_arch_pc(int exception, struct pt_regs *regs);
>>   
>> -- 
>> 2.13.3
>>
