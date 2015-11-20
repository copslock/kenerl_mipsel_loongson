Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Nov 2015 11:48:30 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16104 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012943AbbKTKs1jw5TP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Nov 2015 11:48:27 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id A32AA8532181E;
        Fri, 20 Nov 2015 10:48:19 +0000 (GMT)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.235.1; Fri, 20 Nov
 2015 10:48:21 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Fri, 20 Nov 2015 10:48:21 +0000
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 20 Nov
 2015 10:48:20 +0000
Subject: Re: [PATCH 10/14] irqchip/mips-gic: Add a IPI hierarchy domain
To:     Thomas Gleixner <tglx@linutronix.de>
References: <1446549181-31788-1-git-send-email-qais.yousef@imgtec.com>
 <1446549181-31788-11-git-send-email-qais.yousef@imgtec.com>
 <alpine.DEB.2.11.1511071323471.4032@nanos> <56407F3C.4060404@imgtec.com>
 <alpine.DEB.2.11.1511161610070.3761@nanos>
CC:     <linux-kernel@vger.kernel.org>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
From:   Qais Yousef <qais.yousef@imgtec.com>
Message-ID: <564EFA74.90606@imgtec.com>
Date:   Fri, 20 Nov 2015 10:48:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1511161610070.3761@nanos>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qais.yousef@imgtec.com
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

Hi Thomas,

On 11/16/2015 05:17 PM, Thomas Gleixner wrote:
> 1) IPI as per_cpu interrupts
>
>     Single hwirq represented by a single irq descriptor
>
> 2) IPI with consecutive mapping space
>
>     No extra mapping from virq base to target cpu required as its just
>     linear. Everything can be handled via the base virq.
>


I think I am seeing a major issue with this approach.

Take the case where we reserve an IPI with ipi_mask that has cpu 5 and 6 
set only. When allocating a per_cpu or consectuve mapping, we will 
require 2 consecutive virqs and hwirqs. But since the cpu location is 
not starting from 0, we can't use the cpu as an offset anymore.

So when a user wants to send an IPI to cpu 6 only, the code can't easily 
tell what's the correct offset from base virq or hwirq to use.

Same applies when doing the reverse mapping.

In other words, the ipi_mask won't always necessarily be linear to 
facilitate the 1:1 mapping that this approach assumes.

It is a solvable problem, but I think we're losing the elegance that 
promoted going into this direction and I think sticking to using struct 
ipi_mapping (with some enhancements to how it's exposed an integrated 
by/into generic code) is a better approach.

Thoughts?

I still don't have a working implementation otherwise I would have sent 
my patches, but I thought I'd raise this up before I spend more time on 
it unnecessarily.

Thanks,
Qais
