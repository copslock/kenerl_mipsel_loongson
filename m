Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2016 19:11:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58416 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992123AbcGARL2Ln3XD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Jul 2016 19:11:28 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E1BD7DDEA0B4D;
        Fri,  1 Jul 2016 18:11:17 +0100 (IST)
Received: from [127.0.0.1] (10.100.200.176) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 1 Jul
 2016 18:11:21 +0100
Subject: Re: [RFC PATCH v3 2/2] MIPS: non-exec stack & heap when non-exec
 PT_GNU_STACK is present
To:     David Daney <ddaney.cavm@gmail.com>
References: <20160629143830.526-1-paul.burton@imgtec.com>
 <20160629143830.526-3-paul.burton@imgtec.com>
 <6D39441BF12EF246A7ABCE6654B023537E465A74@HHMAIL01.hh.imgtec.org>
 <fb77e2f2-801d-8dd5-6121-73909ebbd227@imgtec.com>
 <6D39441BF12EF246A7ABCE6654B023537E465F8E@HHMAIL01.hh.imgtec.org>
 <96de1cb3-7bb7-769d-e032-5bd10a3d1633@imgtec.com>
 <57755990.8010807@imgtec.com> <5775BE1A.8050909@gmail.com>
CC:     Faraz Shahbazker <faraz.shahbazker@imgtec.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>,
        Maciej Rozycki <Maciej.Rozycki@imgtec.com>
From:   Paul Burton <paul.burton@imgtec.com>
Message-ID: <ce52dad9-cac3-3693-59c4-92bf90726d4a@imgtec.com>
Date:   Fri, 1 Jul 2016 18:11:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <5775BE1A.8050909@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.100.200.176]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On 01/07/16 01:49, David Daney wrote:
> What ever happens, somebody needs to test kernels with this patch
> against old distros (Debian for example) to make sure you don't break them.
>
> Some of the initial non-exec-stack patch sets intentionally broke
> compatibility with existing binaries, and that is not acceptable.

Hi David,

This patchset definitely doesn't intentionally break backwards 
compatibility, and I am able to run an old debian squeeze distribution 
with iceweasel/firefox etc just fine under QEMU with nofpu (patch 6125 
which this is derived from was capable of that too).

I'm planning to do more testing to try to hammer the multi-threaded case 
where many frames may be in use for a process simultaneously, and check 
the pre-MIPSr6 on MIPSr6 emulation, but besides that I think it should 
be good to go.

Thanks,
     Paul
