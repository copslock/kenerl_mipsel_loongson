Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2016 15:53:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14272 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993058AbcITNxYaaO-Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Sep 2016 15:53:24 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 47958C209EBD2;
        Tue, 20 Sep 2016 14:53:05 +0100 (IST)
Received: from [10.150.130.83] (10.150.130.83) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 20 Sep
 2016 14:53:08 +0100
Subject: Re: [PATCH v2 6/6] MIPS: Deprecate VPE Loader
To:     Ralf Baechle <ralf@linux-mips.org>
References: <1474361249-31064-1-git-send-email-matt.redfearn@imgtec.com>
 <1474361249-31064-7-git-send-email-matt.redfearn@imgtec.com>
 <20160920131934.GE14137@linux-mips.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-mips@linux-mips.org>, <linux-remoteproc@vger.kernel.org>,
        <lisa.parratt@imgtec.com>, <linux-kernel@vger.kernel.org>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <fc65f123-6e32-4637-ac16-458e08029944@imgtec.com>
Date:   Tue, 20 Sep 2016 14:53:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160920131934.GE14137@linux-mips.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Hi Ralf,


On 20/09/16 14:19, Ralf Baechle wrote:
> On Tue, Sep 20, 2016 at 09:47:29AM +0100, Matt Redfearn wrote:
>
>> The MIPS remote processor driver (CONFIG_MIPS_RPROC) provides a more
>> standard mechanism for using one or more VPs as coprocessors running
>> separate firmware.
>>
>> Here we deprecate this mechanism before it is removed.
> The world will be a better place once this is removed.

Indeed :-)

>
> I receive the occasional minor cleanup or robopatch (coccinelle or similar)
> for the VPE loader but I have no indication this is actually being used
> by anybody, so is thee any reason why not to delete it right away?

I'd like to get the remote processor implementation in, then delete the 
VPE loader in the next kernel revision, if that's ok with you. Once it 
is removed, we should also be able to remove the CMP SMP implementation, 
and other bits of infrastructure that'll no longer be needed.

Thanks,
Matt

>
>    Ralf
