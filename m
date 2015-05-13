Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 May 2015 00:58:49 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20280 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012138AbbEMW6sJxOv- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 May 2015 00:58:48 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 43AE6E22C421E;
        Wed, 13 May 2015 23:58:41 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 13 May
 2015 23:58:44 +0100
Received: from [10.20.3.79] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 13 May
 2015 15:58:42 -0700
Message-ID: <5553D722.1030205@imgtec.com>
Date:   Wed, 13 May 2015 15:58:42 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS64: 48 bit physaddr support in memory maps
References: <20150513185519.27601.4253.stgit@ubuntu-yegoshin> <5553C68C.6000000@gmail.com>
In-Reply-To: <5553C68C.6000000@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47388
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

On 05/13/2015 02:47 PM, David Daney wrote:
> On 05/13/2015 11:55 AM, Leonid Yegoshin wrote:
>> Originally, it was set to 40bits only but I6400 has 48bits of physaddr.
>>
>
> Why not go to the architectural limit of 59 bits?
>

Because any physaddr should fit PTE and EntryLo register and we also 
need 5 or 7 SW bits in PTE.

Even with fixed PTE bits layout from

     http://patchwork.linux-mips.org/patch/7613/

we need 5 or 7 additional bits, so the real limit is 54. And 54 is 
actually specified as a limit in EntryLo starting from MIPS R2.
