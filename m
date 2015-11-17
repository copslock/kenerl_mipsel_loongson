Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Nov 2015 11:30:58 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32227 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013925AbbKQKa4TSEo- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Nov 2015 11:30:56 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id CD2E95A05E565;
        Tue, 17 Nov 2015 10:30:48 +0000 (GMT)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.235.1; Tue, 17 Nov
 2015 10:30:50 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 17 Nov 2015 10:30:50 +0000
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 17 Nov
 2015 10:30:49 +0000
Subject: Re: [PATCH 10/14] irqchip/mips-gic: Add a IPI hierarchy domain
To:     Thomas Gleixner <tglx@linutronix.de>
References: <1446549181-31788-1-git-send-email-qais.yousef@imgtec.com>
 <1446549181-31788-11-git-send-email-qais.yousef@imgtec.com>
 <alpine.DEB.2.11.1511071323471.4032@nanos> <56407F3C.4060404@imgtec.com>
 <alpine.DEB.2.11.1511161610070.3761@nanos> <564AFC9A.9080505@imgtec.com>
 <alpine.DEB.2.11.1511171108500.3761@nanos>
CC:     <linux-kernel@vger.kernel.org>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
From:   Qais Yousef <qais.yousef@imgtec.com>
Message-ID: <564B01D8.2090000@imgtec.com>
Date:   Tue, 17 Nov 2015 10:30:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1511171108500.3761@nanos>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49965
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

On 11/17/2015 10:11 AM, Thomas Gleixner wrote:
> Right, I was assuming a consecutive available space and your hardware
> folks should really avoid to break that assumption.
>
> Now you still need some DT support to describe the space which is
> available for IPIs and that should be part of that series.


It's a simple change that shouldn't be a problem adding it to this 
series. I just wanted to avoid having to take more acks from more 
maintainers for this series to go in. But if it's needed, then it is 
what it is.

Maybe I'm better off sending this change separately actually as it's 
independent from other changes and could be merged in first.

> Thanks for being patient and persistant on that!

Thanks a lot for your help and patience too!

Qais
