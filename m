Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Sep 2015 17:04:12 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:33282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006770AbbI1PEKniqVv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Sep 2015 17:04:10 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DA6728;
        Mon, 28 Sep 2015 08:04:04 -0700 (PDT)
Received: from [10.1.209.148] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47A353F2E5;
        Mon, 28 Sep 2015 08:04:00 -0700 (PDT)
Message-ID: <560956DE.60402@arm.com>
Date:   Mon, 28 Sep 2015 16:03:58 +0100
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
MIME-Version: 1.0
To:     Qais Yousef <qais.yousef@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
CC:     linux-mips@linux-mips.org, alex@alex-smith.me.uk,
        Alex Smith <alex.smith@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] irqchip: irq-mips-gic: Provide function to map GIC
 user section
References: <1443434629-14325-1-git-send-email-markos.chandras@imgtec.com> <1443435117-17144-1-git-send-email-markos.chandras@imgtec.com> <56091CA1.1030808@arm.com> <56094BCD.6000600@imgtec.com>
In-Reply-To: <56094BCD.6000600@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49390
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

On 28/09/15 15:16, Qais Yousef wrote:
> On 09/28/2015 11:55 AM, Marc Zyngier wrote:
>> On 28/09/15 11:11, Markos Chandras wrote:
>>
>>> +
>>> +	pfn = (gic_base_addr + USM_VISIBLE_SECTION_OFS) >> PAGE_SHIFT;
>>> +	return io_remap_pfn_range(vma, base, pfn, size,
>>> +				  pgprot_noncached(PAGE_READONLY));
>>
>> - Does this code have to be in the irqchip driver? It really feels out
>> of place, and I'd rather see a function that returns the mappable range
>> to the VDSO code, where the mapping would occur.
>>
> 
> 
> I don't think it's a good idea either for the VDSO code to know about 
> gic_base_addr. Maybe this function could be split to return the pfn and 
> let the caller do io_remap_pfn_range(). Though I think it's nice to have 
> it all there. USM stands for USer Mode - GIC wants to make some stuff 
> visible to user mode and it puts them in that special section. So it 
> makes sense to do it all there IMO.

Maybe I wasn't clear enough. My suggestion was to expose this in
the VDSO setup code:

@@ -90,8 +133,15 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 		goto out;
 	}
 
+	/* Map GIC user page. */
+	if (gic_size) {
+		ret = gic_map_user_section(vma, base, gic_size);
+		if (ret)
+			goto out;
+	}
+

This could easily be written as:

	if (gic_size) {
		struct resource gic_res;
		ret = gic_get_usm_range(&gic_res);
		if (ret)
			goto out;
		... and perform the mapping here...
	}

You can also rewrite the hunks above to actually get the present/size
information from the GIC. And if you have DT, you should be able to
directly find the memory region there, without involving the GIC
driver at all.

I don't really fancy having some userspace visible stuff in an
interrupt controller driver, and I tend to find it nicer to split
the responsabilities: the VDSO code deals with the userspace mapping,
and the interrupt controller deals with interrupts.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
