Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Aug 2015 22:32:26 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17776 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010960AbbHDUcYo7HXi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Aug 2015 22:32:24 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0F848476CF4DB;
        Tue,  4 Aug 2015 21:32:15 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 4 Aug
 2015 21:32:18 +0100
Received: from [10.20.3.79] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 4 Aug 2015
 13:32:15 -0700
Message-ID: <55C1214F.8050208@imgtec.com>
Date:   Tue, 4 Aug 2015 13:32:15 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     David Daney <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, David Daney <david.daney@cavium.com>,
        <stable@vger.kernel.org>
Subject: Re: MIPS: Make set_pte() SMP safe.
References: <1438649323-1082-1-git-send-email-ddaney.cavm@gmail.com> <55C10F4B.2050003@imgtec.com> <55C11A37.5070509@caviumnetworks.com>
In-Reply-To: <55C11A37.5070509@caviumnetworks.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48571
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

David,

It is interesting, I still don't understand the effect - if guard page 
is used then two different VMAP allocations can't use two buddy PTEs.

Yes, only one of buddy PTEs in that case can be allocated and attached 
to VMA but caller doesn't know about additional page and two cases are 
possible. Even map_vm_area has no any info about guard page.

(assume VMA1 has low address range and VMA2 has higher address range):

a.  VMA1 (after adjustment) ends at even PTE ==> caller doesn't use that 
PTE and there is no collision with last pair of buddy PTEs, even if VMA2 
uses odd PTE from that pair.
b.  VMA1 (after adjustment) ends at odd PTE ==> again, this buddy pair 
is used only VMA1. Next VMA2 start from next pair.

What is wrong here?

Is it possible that access gone bad and touches a page beyond a 
requested size?
Is it possible that it is not vmap() but some different interface was used?

- Leonid.
