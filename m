Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Sep 2016 09:51:17 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:53194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991960AbcIPHvKhgsm6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Sep 2016 09:51:10 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B09C022E;
        Fri, 16 Sep 2016 00:51:03 -0700 (PDT)
Received: from [10.1.207.16] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 833B23F317;
        Fri, 16 Sep 2016 00:51:02 -0700 (PDT)
Subject: Re: genirq: Setting trigger mode 0 for irq 11 failed
 (txx9_irq_set_type+0x0/0xb8)
To:     Alban Browaeys <alban.browaeys@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>
References: <CAMuHMdVW1eTn20=EtYcJ8hkVwohaSuH_yQXrY2MGBEvZ8fpFOg@mail.gmail.com>
 <1473980577.17787.21.camel@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jon Hunter <jonathanh@nvidia.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
X-Enigmail-Draft-Status: N1110
Organization: ARM Ltd
Message-ID: <57DBA464.9010506@arm.com>
Date:   Fri, 16 Sep 2016 08:51:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
MIME-Version: 1.0
In-Reply-To: <1473980577.17787.21.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marc.zyngier@arm.com
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

Hi Alban,

On 16/09/16 00:02, Alban Browaeys wrote:
> Le mercredi 14 septembre 2016 à 21:25 +0200, Geert Uytterhoeven a
> écrit :
>> JFYI, with v4.8-rc6 I'm seeing
>>
>>     genirq: Setting trigger mode 0 for irq 11 failed
>> (txx9_irq_set_type+0x0/0xb8)
>>
>> on rbtx4927. This did not happen with v4.8-rc3.
> 
> 
> txx9_irq_set_type receives a type IRQ_TYPE_NONE from the call to
> __irq_set_trigger added in:
> 1e12c4a939 ("genirq: Correctly configure the trigger on chained interrupts")
> 
> 
> This patch is a regression fix for :
> 
> Desc: irqdomain: Don't set type when mapping an IRQ breaks nexus7 gpio buttons
> Repo: 2016-07-30 https://marc.info/?l=linux-kernel&m=146985356305280&w=2
> 
> I am seeing this on arm odroid u2 devicetree :
> genirq: Setting trigger mode 0 for irq 16 failed (gic_set_type+0x0/0x64)

Passing IRQ_TYPE_NONE to a cascading interrupt is risky at best...
Can you point me to the various DTs and their failing interrupts?

Also, can you please give the following patch a go and let me know
if that fixes the issue (I'm interested in the potential warning here).

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 6373890..8422779 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -820,6 +820,8 @@ __irq_do_set_handler(struct irq_desc *desc, irq_flow_handler_t handle,
 	desc->name = name;
 
 	if (handle != handle_bad_irq && is_chained) {
+		unsigned int type = irqd_get_trigger_type(&desc->irq_data);
+
 		/*
 		 * We're about to start this interrupt immediately,
 		 * hence the need to set the trigger configuration.
@@ -828,8 +830,10 @@ __irq_do_set_handler(struct irq_desc *desc, irq_flow_handler_t handle,
 		 * chained interrupt. Reset it immediately because we
 		 * do know better.
 		 */
-		__irq_set_trigger(desc, irqd_get_trigger_type(&desc->irq_data));
-		desc->handle_irq = handle;
+		if (!(WARN_ON(type == IRQ_TYPE_NONE))) {
+			__irq_set_trigger(desc, type);
+			desc->handle_irq = handle;
+		}
 
 		irq_settings_set_noprobe(desc);
 		irq_settings_set_norequest(desc);

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
