Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Apr 2018 20:16:16 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:52832 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994585AbeDFSQIGTxi7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Apr 2018 20:16:08 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E23FE60590; Fri,  6 Apr 2018 18:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1523038560;
        bh=zYlSFgEpG8hXuACQR09RzOkbtiNrHIPRlEwhaGdbSl0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DEH12WyfvfYGioKM2szCNY79Ica6P8EfXujLQYfivJM+ASxBt5eBFV7Nbrw0dB6kk
         yehXUQcz9KM87lW5dU2NtI+S+Faidw5O8LkeNkGpb9wWxzn3jad5Ay71J2y9WR2wGE
         F9V5Pm6+rRlW1dadK/JrIeWctX9Rwpo2/fARA2oQ=
Received: from [192.168.0.105] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 904B860C64;
        Fri,  6 Apr 2018 18:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1523038559;
        bh=zYlSFgEpG8hXuACQR09RzOkbtiNrHIPRlEwhaGdbSl0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=m6/EcG6DeSAqE/boRRvb6JgNglXxZOlMO542fX3mALpBJPtCzLVv+KJV+4nVvBWd/
         P7dh7oBrh7armA2AAB6zvMhx7EMnyhlRdflG4OuLFcJbbE32Z9vODd02Sr738ELAz7
         Gjr/AXIxX++BFgfTanZ6AX8LtVq/IsnR/xuwnNds=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 904B860C64
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
To:     linux-mips@linux-mips.org, arnd@arndb.de, timur@codeaurora.org,
        sulrich@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
 <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
 <41e184ae-689e-93c9-7b15-0c68bd624130@codeaurora.org>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <b748fdcb-e09f-9fe3-dc74-30b6a7d40cbe@codeaurora.org>
Date:   Fri, 6 Apr 2018 14:15:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <41e184ae-689e-93c9-7b15-0c68bd624130@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <okaya@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: okaya@codeaurora.org
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

On 4/5/2018 9:34 PM, Sinan Kaya wrote:
> On 4/3/2018 8:55 AM, Sinan Kaya wrote:
>> While a barrier is present in writeX() function before the register write,
>> a similar barrier is missing in the readX() function after the register
>> read. This could allow memory accesses following readX() to observe
>> stale data.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  arch/mips/include/asm/io.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
>> index fd00ddaf..6ac502f 100644
>> --- a/arch/mips/include/asm/io.h
>> +++ b/arch/mips/include/asm/io.h
>> @@ -377,6 +377,7 @@ static inline type pfx##read##bwlq(const volatile void __iomem *mem)	\
>>  		BUG();							\
>>  	}								\
>>  									\
>> +	rmb();								\
>>  	return pfx##ioswab##bwlq(__mem, __val);				\
>>  }
>>  
>>
> 
> Can we get these merged to 4.17? 
> 
> There was a consensus to fix the architectures having API violation issues.
> https://www.mail-archive.com/netdev@vger.kernel.org/msg225971.html
> 
> 

Any news on the MIPS front? Is this something that Arnd can merge? or does it have
to go through the MIPS tree.

It feels like the MIPS is dead since nobody replied to me in the last few weeks on
a very important topic.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
