Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2015 03:56:56 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59916 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006820AbbFCB4wrrd8s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2015 03:56:52 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A58CD60E3DB09;
        Wed,  3 Jun 2015 02:56:46 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 3 Jun
 2015 02:56:46 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Wed, 3 Jun
 2015 02:56:46 +0100
Received: from [10.20.3.79] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 2 Jun 2015
 18:56:44 -0700
Message-ID: <556E5EDC.9030209@imgtec.com>
Date:   Tue, 2 Jun 2015 18:56:44 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <benh@kernel.crashing.org>, <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        <markos.chandras@imgtec.com>, <Steven.Hill@imgtec.com>,
        <alexander.h.duyck@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/3] MIPS: R6: Use lightweight SYNC instruction in smp_*
 memory barriers
References: <20150602000818.6668.76632.stgit@ubuntu-yegoshin> <20150602000934.6668.43645.stgit@ubuntu-yegoshin> <556D8A03.9080201@imgtec.com> <alpine.LFD.2.11.1506021709420.6751@eddie.linux-mips.org> <556E42BB.4060705@gmail.com>
In-Reply-To: <556E42BB.4060705@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47816
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

On 06/02/2015 04:56 PM, David Daney wrote:
> On 06/02/2015 09:15 AM, Maciej W. Rozycki wrote:
>> On Tue, 2 Jun 2015, James Hogan wrote:
>>
>>>
>>> binutils appears to support the sync_mb, sync_rmb, sync_wmb aliases
>>> since version 2.21. Can we safely use them?
>>
>>   I suggest that we don't -- we still officially support binutils 
>> 2.12 and
>> have other places where we even use `.word' to insert instructions 
>> current
>> versions of binutils properly handle.  It may be worth noting in a 
>> comment
>> though that these encodings correspond to these operations that you 
>> named.
>>
>
> Surely the other MIPSr6 instructions are not supported in binutils 
> 2.12 either.  So if it is for r6, why not require modern tools, and 
> put something user readable in here?
>
>
No, it can be used for MIPS R2 also.
