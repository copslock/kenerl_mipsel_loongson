Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2014 12:24:54 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40402 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009738AbaIYKYxGLjhS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Sep 2014 12:24:53 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A167789CB82BE
        for <linux-mips@linux-mips.org>; Thu, 25 Sep 2014 11:24:43 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 25 Sep
 2014 11:24:45 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 25 Sep 2014 11:24:45 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 25 Sep
 2014 11:24:45 +0100
Message-ID: <5423ED6D.903@imgtec.com>
Date:   Thu, 25 Sep 2014 11:24:45 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH 04/11] MIPS: wrap cfcmsa & ctcmsa accesses for toolchains
 with MSA support
References: <1411551942-11153-1-git-send-email-paul.burton@imgtec.com> <1411551942-11153-5-git-send-email-paul.burton@imgtec.com> <5422B434.2020405@imgtec.com> <20140925092350.GV17248@pburton-laptop>
In-Reply-To: <20140925092350.GV17248@pburton-laptop>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 25/09/14 10:23, Paul Burton wrote:
> On Wed, Sep 24, 2014 at 01:08:20PM +0100, James Hogan wrote:
>> On 24/09/14 10:45, Paul Burton wrote:
>>> and provide
>>> implementations for the TOOLCHAIN_SUPPORTS_MSA case which ".set msa" as
>>> appropriate.
>>
>> nit: which *uses* ".set msa"?
>>
>> Cheers
>> James
> 
> In my head I read that without the ".", so "which set msa" seems quite
> natural to me. But if you/others are bothered enough let me know, I
> don't mind adding "uses".

Meh, fair enough, I'm reading it like that too now :)

Cheers
James
