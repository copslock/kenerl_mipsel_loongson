Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Feb 2018 03:16:43 +0100 (CET)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:44512
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992917AbeBJCQhORUE3 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 10 Feb 2018 03:16:37 +0100
Received: by mail-pg0-x242.google.com with SMTP id j9so4263654pgp.11
        for <linux-mips@linux-mips.org>; Fri, 09 Feb 2018 18:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=szEmW12x0R9bIZNpkaTr2QMrAly847XuwnRoJkvOB1k=;
        b=GgSwpZjRvNF6DWseXoBP+knNYNJZj9aMDOHU81KM3Imv3BR3yZy8sm4lQVEZkz+trO
         +SfsMXhywiNMYrO2fL4MOVzsmKU2MSZQedjOB/kXOmFSWYcOKsRyPQuj5k4m6nyLS7XE
         TjW3S9YYnyp89cWr2/LLFtJBsLs1AxM1NyP6/P4HQEY83DMPVGHeRUKZ8hqN6hMrkADb
         sg1Mvrmv0TnitE1jd3pHUS2pRewbXbS8u81GAM6GeMqeqlBRfUnI7amc/u5tPn6JvRN6
         vN9LF0t/++aLh79vekspuVGi50b5An7FXtGYHs3zD28VKA3RNa4AjiUHig/UrizaYkEw
         GFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=szEmW12x0R9bIZNpkaTr2QMrAly847XuwnRoJkvOB1k=;
        b=nXXLee5VSk1HMI4aWxeI2vLBQ08q9+iODo6t4byu0vYRzgAUpsIJYmkyspoy92e34s
         usENtd429jIYewst4tGP2PWe9+aym8BapwiKAb3fbvbdgS4FPAMBg89qRSKpj4JP9Snb
         GYJ+PDJ+6fQOSbWWeTyeRqsqk7AmFCE2PjzlyUB8Ff1K7G9bDEi7+IL4XpYdKaD/smEM
         OliwoNYlewzPGWfxgsV1to0McaQB/9QOt3faX7yKct8t0uU5h9ZkLfR54UnykUCTY04O
         n8a2loRiQyPCSjQGyYKNKXpvIcHSUX1O6qGx7pEVB8ErKIQIxSzp/3bpK33suG4LCLs+
         TfNg==
X-Gm-Message-State: APf1xPB1q5qSz/ylwjsDbAqgDDl0S61s5CmkJ0eaKsbPi6fQEs1bR2lP
        9xDfUzWCMRhbbfxiXFksfBw=
X-Google-Smtp-Source: AH8x226JsCIQ4rbTANhhrMNgt5oOssfEVJrabIUFWfyNiUXTFx4le5uf2LLfP4/GKD9rkp+qlZvZKA==
X-Received: by 10.98.196.13 with SMTP id y13mr4800900pff.73.1518228990559;
        Fri, 09 Feb 2018 18:16:30 -0800 (PST)
Received: from [192.168.0.103] ([59.12.167.210])
        by smtp.gmail.com with ESMTPSA id x124sm8240381pfx.105.2018.02.09.18.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 18:16:30 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] irqchip: Use %px to print pointer value
From:   Jaedon Shin <jaedon.shin@gmail.com>
In-Reply-To: <6bf05e81-2334-f3ac-08a7-e53ee59bb4c0@arm.com>
Date:   Sat, 10 Feb 2018 11:16:22 +0900
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Kevin Cernekee <cernekee@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 8BIT
Message-Id: <CAD3828B-6D72-42C6-8D54-78EC35BAF65B@gmail.com>
References: <20180209021031.20631-1-jaedon.shin@gmail.com>
 <ba5fb474-4e45-8d8d-ee5d-9f1a211090e3@arm.com>
 <45424653-235D-4C4B-8908-417943F5283C@gmail.com>
 <6bf05e81-2334-f3ac-08a7-e53ee59bb4c0@arm.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
X-Mailer: Apple Mail (2.3445.5.20)
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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



> On 10 Feb 2018, at 1:04 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> 
> On 09/02/18 15:54, Florian Fainelli wrote:
>> On February 9, 2018 12:51:33 AM PST, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> On 09/02/18 02:10, Jaedon Shin wrote:
>>>> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
>>>> pointers printed with %p are hashed. Use %px instead of %p to print
>>>> pointer value.
>>>> 
>>>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>>>> ---
>>>> drivers/irqchip/irq-bcm7038-l1.c | 2 +-
>>>> drivers/irqchip/irq-bcm7120-l2.c | 2 +-
>>>> drivers/irqchip/irq-brcmstb-l2.c | 2 +-
>>>> 3 files changed, 3 insertions(+), 3 deletions(-)
>>>> 
>>>> diff --git a/drivers/irqchip/irq-bcm7038-l1.c
>>> b/drivers/irqchip/irq-bcm7038-l1.c
>>>> index 55cfb986225b..f604c1d89b3b 100644
>>>> --- a/drivers/irqchip/irq-bcm7038-l1.c
>>>> +++ b/drivers/irqchip/irq-bcm7038-l1.c
>>>> @@ -339,7 +339,7 @@ int __init bcm7038_l1_of_init(struct device_node
>>> *dn,
>>>> 		goto out_unmap;
>>>> 	}
>>>> 
>>>> -	pr_info("registered BCM7038 L1 intc (mem: 0x%p, IRQs: %d)\n",
>>>> +	pr_info("registered BCM7038 L1 intc (mem: 0x%px, IRQs: %d)\n",
>>>> 		intc->cpus[0]->map_base, IRQS_PER_WORD * intc->n_words);
>>>> 
>>>> 	return 0;
>>>> diff --git a/drivers/irqchip/irq-bcm7120-l2.c
>>> b/drivers/irqchip/irq-bcm7120-l2.c
>>>> index 983640eba418..1cc4dd1d584a 100644
>>>> --- a/drivers/irqchip/irq-bcm7120-l2.c
>>>> +++ b/drivers/irqchip/irq-bcm7120-l2.c
>>>> @@ -318,7 +318,7 @@ static int __init bcm7120_l2_intc_probe(struct
>>> device_node *dn,
>>>> 		}
>>>> 	}
>>>> 
>>>> -	pr_info("registered %s intc (mem: 0x%p, parent IRQ(s): %d)\n",
>>>> +	pr_info("registered %s intc (mem: 0x%px, parent IRQ(s): %d)\n",
>>>> 			intc_name, data->map_base[0], data->num_parent_irqs);
>>>> 
>>>> 	return 0;
>>>> diff --git a/drivers/irqchip/irq-brcmstb-l2.c
>>> b/drivers/irqchip/irq-brcmstb-l2.c
>>>> index 691d20eb0bec..6760edeeb666 100644
>>>> --- a/drivers/irqchip/irq-brcmstb-l2.c
>>>> +++ b/drivers/irqchip/irq-brcmstb-l2.c
>>>> @@ -262,7 +262,7 @@ static int __init brcmstb_l2_intc_of_init(struct
>>> device_node *np,
>>>> 		ct->chip.irq_set_wake = irq_gc_set_wake;
>>>> 	}
>>>> 
>>>> -	pr_info("registered L2 intc (mem: 0x%p, parent irq: %d)\n",
>>>> +	pr_info("registered L2 intc (mem: 0x%px, parent irq: %d)\n",
>>>> 			base, parent_irq);
>>>> 
>>>> 	return 0;
>>>> 
>>> 
>>> Why is that something useful to do? This just tells you where the
>>> device
>>> is mapped in the VA space, and I doubt that's a useful information,
>>> hashed pointers or not. Am I missing something obvious?
>> 
>> No you are right there is not much value in printing the register
>> virtual address (sometimes there is e.g: on MIPS) either we fix the
>> prints to show the physical address of the base register or we could
>> possibly drop the prints entirely.
> 
> Displaying the PA can be useful if you have several identical blocks in
> your system and you want to be able to identify them. Given that there
> is probably only one of these controllers per system, the address is
> pretty pointless.
> 
> If you send me a patch removing the prints, I'll queue it.
> 
> Thanks,
> 
> 	M.
> -- 
> Jazz is not dead. It just smells funny...

I'll submit a new one to drop the entire print.

Thanks,
Jaedon
From ben@decadent.org.uk Sun Feb 11 05:34:10 2018
Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Feb 2018 05:34:22 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60810 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990398AbeBKEeKs8uej (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Feb 2018 05:34:10 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1ekjKv-0002py-MG; Sun, 11 Feb 2018 04:33:57 +0000
Received: from ben by deadeye with local (Exim 4.90)
        (envelope-from <ben@decadent.org.uk>)
        id 1ekjKo-0004iI-RK; Sun, 11 Feb 2018 04:33:50 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Djordje Todorovic" <djordje.todorovic@rt-rk.com>,
        "Maciej W. Rozycki" <macro@mips.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "James Hogan" <jhogan@kernel.org>, linux-mips@linux-mips.org
Date:   Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.320638011@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 070/136] MIPS: Fix an n32 core file generation regset
 support regression
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Maciej W. Rozycki" <macro@mips.com>

commit 547da673173de51f73887377eb275304775064ad upstream.

Fix a commit 7aeb753b5353 ("MIPS: Implement task_user_regset_view.")
regression, then activated by commit 6a9c001b7ec3 ("MIPS: Switch ELF
core dumper to use regsets.)", that caused n32 processes to dump o32
core files by failing to set the EF_MIPS_ABI2 flag in the ELF core file
header's `e_flags' member:

$ file tls-core
tls-core: ELF 32-bit MSB executable, MIPS, N32 MIPS64 rel2 version 1 (SYSV), [...]
$ ./tls-core
Aborted (core dumped)
$ file core
core: ELF 32-bit MSB core file MIPS, MIPS-I version 1 (SYSV), SVR4-style
$

Previously the flag was set as the result of a:

statement placed in arch/mips/kernel/binfmt_elfn32.c, however in the
regset case, i.e. when CORE_DUMP_USE_REGSET is set, ELF_CORE_EFLAGS is
no longer used by `fill_note_info' in fs/binfmt_elf.c, and instead the
`->e_flags' member of the regset view chosen is.  We have the views
defined in arch/mips/kernel/ptrace.c, however only an o32 and an n64
one, and the latter is used for n32 as well.  Consequently an o32 core
file is incorrectly dumped from n32 processes (the ELF32 vs ELF64 class
is chosen elsewhere, and the 32-bit one is correctly selected for n32).

Correct the issue then by defining an n32 regset view and using it as
appropriate.  Issue discovered in GDB testing.

Fixes: 7aeb753b5353 ("MIPS: Implement task_user_regset_view.")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Djordje Todorovic <djordje.todorovic@rt-rk.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/17617/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/ptrace.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -522,6 +522,19 @@ static const struct user_regset_view use
 	.n		= ARRAY_SIZE(mips64_regsets),
 };
 
+#ifdef CONFIG_MIPS32_N32
+
+static const struct user_regset_view user_mipsn32_view = {
+	.name		= "mipsn32",
+	.e_flags	= EF_MIPS_ABI2,
+	.e_machine	= ELF_ARCH,
+	.ei_osabi	= ELF_OSABI,
+	.regsets	= mips64_regsets,
+	.n		= ARRAY_SIZE(mips64_regsets),
+};
+
+#endif /* CONFIG_MIPS32_N32 */
+
 #endif /* CONFIG_64BIT */
 
 const struct user_regset_view *task_user_regset_view(struct task_struct *task)
@@ -533,6 +546,10 @@ const struct user_regset_view *task_user
 	if (test_tsk_thread_flag(task, TIF_32BIT_REGS))
 		return &user_mips_view;
 #endif
+#ifdef CONFIG_MIPS32_N32
+	if (test_tsk_thread_flag(task, TIF_32BIT_ADDR))
+		return &user_mipsn32_view;
+#endif
 	return &user_mips64_view;
 #endif
 }
