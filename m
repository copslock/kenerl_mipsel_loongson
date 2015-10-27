Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Oct 2015 22:15:34 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25075 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011425AbbJ0VPdQjApJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Oct 2015 22:15:33 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 679C26FD0DD17;
        Tue, 27 Oct 2015 21:15:24 +0000 (GMT)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 27 Oct
 2015 21:15:27 +0000
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.235.1; Tue, 27 Oct
 2015 21:15:27 +0000
Received: from [10.20.3.92] (10.20.3.92) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 27 Oct
 2015 14:15:25 -0700
Message-ID: <562FE96C.3070002@imgtec.com>
Date:   Tue, 27 Oct 2015 14:15:24 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        <linux-mips@linux-mips.org>, Alex Smith <alex.smith@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [v3, 3/3] MIPS: VDSO: Add implementations of gettimeofday() and
 clock_gettime()
References: <1445417864-31453-1-git-send-email-markos.chandras@imgtec.com> <5629904A.2070400@imgtec.com> <20151027144748.GA23785@linux-mips.org> <562FE29C.8040106@imgtec.com> <562FE678.2030307@gmail.com>
In-Reply-To: <562FE678.2030307@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.92]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 10/27/2015 02:02 PM, David Daney wrote:
> On 10/27/2015 01:46 PM, Leonid Yegoshin wrote:
> [...]
>>
>> And finally. clock scaling - what we would do if there are two CPUs with
>> different clock ratios in system? It seems like common kernel timing
>> subsystem can handle that.
>>
>
> The code that executes in userspace must have access to a consistent 
> clock source.  If you are running on a SMP system that doesn't have 
> synchronized CP0.Count registers, then your gettimeofday() cannot use 
> CP0.Count (RDHWR $2).

Right, I agree.

>
> As far as I know, CP0.Count is the only available counter visible to 
> userspace, so you would have to disable the accelerated versions of 
> gettimeofday() where you cannot assert that the counters are always 
> synchronized.

Any system with GIC may have access to the same GIC global counter in a 
special separate page available for mapping by user in RO mode and it 
seems Alex did that.

Besides that this GIC global counter is used as a major system 
clocksource in systems with GIC.

- Leonid
