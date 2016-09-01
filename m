Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 16:48:36 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:36848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992172AbcIAOs3h5kjg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Sep 2016 16:48:29 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 896DE462;
        Thu,  1 Sep 2016 07:48:22 -0700 (PDT)
Received: from [10.1.207.16] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 673AD3F47F;
        Thu,  1 Sep 2016 07:48:20 -0700 (PDT)
Subject: Re: [Patch v3 03/11] irqchip: axi-intc: Add support for parent intc
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        monstr@monstr.eu, ralf@linux-mips.org, tglx@linutronix.de,
        jason@lakedaemon.net
References: <1472661352-11983-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1472661352-11983-4-git-send-email-Zubair.Kakakhel@imgtec.com>
 <57C70C71.3060603@arm.com> <81b5f75c-51b5-0482-50d1-f51c5687edbc@imgtec.com>
 <57C81BB5.3060807@arm.com> <f45ffb5f-fb66-4083-4754-f8e50689216b@imgtec.com>
Cc:     soren.brinkmann@xilinx.com, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, michal.simek@xilinx.com,
        netdev@vger.kernel.org
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <57C83FB2.607@arm.com>
Date:   Thu, 1 Sep 2016 15:48:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
MIME-Version: 1.0
In-Reply-To: <f45ffb5f-fb66-4083-4754-f8e50689216b@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54924
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

On 01/09/16 14:52, Zubair Lutfullah Kakakhel wrote:
> Hi,

[...]

>> But that still doesn't address the case I had in mind, which is when you
>> have *two* AXI-intc, one cascaded into the other. Is that something that
>> could be built? You should at least make sure that there is a big fat
>> warning if you don't want to support that case, because that will be
>> hell to debug.
> 
> Oo. I didn't think of that one. tbh, I'm not sure if that is currently supported
> because this driver came out of arch/microblaze. And it didn't have any code that
> looked supportive of chained interrupt handling.
> 
> 'Technically', it should be possible to synthesize two daisy chained axi interrupt
> controllers on an FPGA. But I don't see it being supported before.
> 
> A warning would be nice. Any suggestions on the most suitable way?

Check if you've already allocated a xintc_irqc. If so, abort the probing
early...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
