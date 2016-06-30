Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2016 12:50:00 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26808 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992617AbcF3Ktj1FMfj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Jun 2016 12:49:39 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 29F57C5E37A67;
        Thu, 30 Jun 2016 11:49:31 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 30 Jun 2016 11:49:33 +0100
Received: from [127.0.0.1] (10.100.200.138) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 30 Jun
 2016 11:49:33 +0100
Subject: Re: [RFC PATCH v3 1/2] MIPS: use per-mm page to execute branch delay
 slot instructions
To:     Matt Redfearn <matt.redfearn@imgtec.com>
References: <20160629143830.526-1-paul.burton@imgtec.com>
 <20160629143830.526-2-paul.burton@imgtec.com> <5774DFDC.4000607@imgtec.com>
 <9c74a08a-afbb-68c6-e022-a4f01713f01c@imgtec.com>
 <5774F70B.2050300@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "Leonid Yegoshin" <leonid.yegoshin@imgtec.com>,
        Matthew Fortune <matthew.fortune@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>
From:   Paul Burton <paul.burton@imgtec.com>
Message-ID: <f989340b-1e4e-68a0-6715-c1b350e22e72@imgtec.com>
Date:   Thu, 30 Jun 2016 11:49:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <5774F70B.2050300@imgtec.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.100.200.138]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54188
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

On 30/06/16 11:40, Matt Redfearn wrote:
> OK cool, sounds good to me. BTW, there was an additional comment (which
> I failed to space correctly) that asm/dsemul.h seems to be missing from
> the patch?
>
> Thanks,
> Matt

D'oh! Included in v4.

Thanks,
     Paul
