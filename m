Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 20:37:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25874 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006628AbbEVShkaxzV9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 20:37:40 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 10DF57EB451D6;
        Fri, 22 May 2015 19:37:34 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 22 May
 2015 19:37:37 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Fri, 22 May
 2015 19:37:36 +0100
Received: from [10.20.3.79] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 22 May
 2015 11:37:34 -0700
Message-ID: <555F776E.3070904@imgtec.com>
Date:   Fri, 22 May 2015 11:37:34 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <rusty@rustcorp.com.au>,
        <alexinbeijing@gmail.com>, <paul.burton@imgtec.com>,
        <david.daney@cavium.com>, <alex@alex-smith.me.uk>,
        <linux-kernel@vger.kernel.org>, <james.hogan@imgtec.com>,
        <markos.chandras@imgtec.com>, <macro@linux-mips.org>,
        <eunb.song@samsung.com>, <manuel.lauss@gmail.com>,
        <andreas.herrmann@caviumnetworks.com>
Subject: Re: [PATCH 1/2] MIPS: MSA: bugfix - disable MSA during thread switch
 correctly
References: <20150519211222.35859.52798.stgit@ubuntu-yegoshin> <20150519211351.35859.80332.stgit@ubuntu-yegoshin> <20150522093812.GH6941@linux-mips.org>
In-Reply-To: <20150522093812.GH6941@linux-mips.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47589
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

On 05/22/2015 02:38 AM, Ralf Baechle wrote:
> Just move the call to finish_arch_switch(). 

It might be a problem later, then a correct MSA partiton starts working. 
It should be tight to saving MSA registers in that case.

> Your rewrite also dropped the if (cpu_has_msa) condition from 
> disable_msa() probably causing havoc on lots of CPUs which will likely 
> not decode the set bits of the MFC0/MTC0 instructions thus end up 
> accessing Config0. Ralf

Right before this chunk of code there is a saving MSA registers. Does it 
causing a havoc or else?

May I ask you to look into switch_to macro to figure out how "if 
(cpu_has_msa)" check works in this case?

- Leonid.
