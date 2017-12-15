Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Dec 2017 15:05:28 +0100 (CET)
Received: from mail-lf0-x241.google.com ([IPv6:2a00:1450:4010:c07::241]:39362
        "EHLO mail-lf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992176AbdLOOFV2oiFs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Dec 2017 15:05:21 +0100
Received: by mail-lf0-x241.google.com with SMTP id 6so2065677lfa.6
        for <linux-mips@linux-mips.org>; Fri, 15 Dec 2017 06:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=L108c2RYQVfbSSBJykedDU9j03DmiZ3R3pZXsKHPj4g=;
        b=bxdjOcyjZyDin8iuZLBO3JJXGng8zIQbZWPxPVzRIEsZ/tdTVWgOUNyMJYTX5o4hhx
         Y7xa9Cyu6qfp7SfRSOl/WAuiAeJmQx0uAdl8XQ1bw5117NsQbU0ou5ylyRuhgeKs4slg
         gzRpxCFCTAxL6YcICyP3YqDUbUheY3yXe8pKgK4mAwGk+ENt6zX+d9y7aQd65/hx4DXK
         6ZggX4ktq9kjnEB8+ZTbKpRqo2JmMnpzYaVjmdtfnR6KvfrHQLMv9V+5endNfwsRcLJc
         087iOfFJaxqvfzGGdW6zQgiZpWLwE6NRTxeQmCPNLK0WfcakJ5c3Gpauuxd1uP+J5qsf
         LO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=L108c2RYQVfbSSBJykedDU9j03DmiZ3R3pZXsKHPj4g=;
        b=nYLsTdCYJFfbAseS/nNbNUZe+L3WJ/QBvhOoyjaXLi5V5EucyMJjxEyUZiBTjB7ZB1
         qkjGyWSPCsPJuTE/4dYwYT+c0OOSV/6SFe1R0xJCZu3HJfJXEBu4WGutsxh3o1VLkVv1
         U5Lbav6eGay1BETsin5+mkhvGsAt4BH9RjGChg4BfZyXGKNn/7sgrs7XaGDvK75zbXsG
         fKRWpE0ZVu/NRuhWbsLhlUc2G08/RUx2OPib6NAvVUYq/D8iv+3xH1enzPaHlkd0I6SD
         27wStfiW8OyiBlph8ldaw1RVNFxymDeXyUkAz1Dsz58ZLQZ+ZvVxS3Nxj35CrGew6nGz
         lNcw==
X-Gm-Message-State: AKGB3mKxaCw63YDS3sNZaovSdrV6oLi99lgRtuU5ujQ3hQoMWU9tzBVx
        5cJTF8yC+dVV3TwckK0gGBM=
X-Google-Smtp-Source: ACJfBouKWQ8zDYg0vrOPW7CN93JZml/O1enU5XN1WS/fF6tkI7NAHQw9xgGNQS6zGy7ECWqKbFmkgA==
X-Received: by 10.25.147.221 with SMTP id w90mr6501407lfk.126.1513346715673;
        Fri, 15 Dec 2017 06:05:15 -0800 (PST)
Received: from upc8.baikal.int (mail.baikalelectronics.com. [87.245.175.226])
        by smtp.gmail.com with ESMTPSA id 39sm1268777ljb.49.2017.12.15.06.05.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Dec 2017 06:05:14 -0800 (PST)
Subject: Re: [P5600 && EVA memory caching question] PCI region
To:     James Hogan <james.hogan@mips.com>
Cc:     linux-mips@linux-mips.org, paul.burton@mips.com
References: <6132c323-32a7-1d38-b77c-a191be22faa4@gmail.com>
 <20171206114611.GM5027@jhogan-linux.mipstec.com>
 <330a5200-531f-fcfa-674a-c81fb3144e92@gmail.com>
 <20171214152138.GV5027@jhogan-linux.mipstec.com>
From:   Yuri Frolov <crashing.kernel@gmail.com>
Message-ID: <ca9adcbc-9777-46a0-ce0b-15e83e01fc72@gmail.com>
Date:   Fri, 15 Dec 2017 17:05:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171214152138.GV5027@jhogan-linux.mipstec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Return-Path: <crashing.kernel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: crashing.kernel@gmail.com
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

Hi, James

On 12/14/2017 06:21 PM, James Hogan wrote:
> Hi Yuri,
>
> On Thu, Dec 14, 2017 at 06:03:11PM +0300, Yuri Frolov wrote:
>> Hi, James.
>>
>> Do I understand correctly, that in case of CONFIG_EVA=y, any logical
>> address from 0x00000000 - 0xBFFFFFFF (3G) range accessed from the kernel
>> space is:
>> 1) Unmapped (no TLB translations)
>> 2) Is mapped 1:1 to physical addresses? E.g, readl from 0x20000000 is,
>> in fact a read from physical address 0x20000000? I mean, in legacy
>> memory mapping scheme, logical addresses 0x80000000 - 0xBFFFFFFF in
>> kernel space were being translated to the physical addresses from the
>> low 512Mb (phys 0x00000000 - 0x20000000), no such bits stripping or
>> something for EVA, the mapping is 1:1?
> That depends on the EVA configuration. The hardware is fairly flexible
> (which is both useful and painful - making supporting EVA from
> multiplatform kernels particularly awkward), but that is one possible
> configuration.
>
> E.g. ideally you probably want to keep seg5 (0x00000000..0x3FFFFFFF)
> MUSK (TLB mapped for user & kernel) so that null dereferences from
> kernel code are safely caught, but that costs you 1GB of directly
> accessible physical address space from kernel mode.
So, do I understand correctly, that provided we have these TLB entries 
in kernel,

Index: 71 pgmask=16kb va=c0038000 asid=00
         [ri=0 xi=0 pa=200e0000 c=2 d=1 v=1 g=1] [ri=0 xi=0 pa=00000000 
c=0 d=0 v=0 g=1]
Index: 72 pgmask=16kb va=c0040000 asid=00
         [ri=0 xi=0 pa=200c0000 c=2 d=1 v=1 g=1] [ri=0 xi=0 pa=200c4000 
c=2 d=1 v=1 g=1]

u32 l;

l = readl((const volatile void *)(0x200c0000 + 0x20))
and
l = *(u32 *)(0xc0040000+ 0x20)

should return the same value?
>
>> As for userspace addresses, the addresses from the 0x00000000 -
>> 0xBFFFFFFF range are:
>> 1) Overlayed with the range which is directly accessible from the kernel
>> space
> Yes. Userland accesses access through tlb, kernel direct, and kernel eva
> accesses (LWE/SWE etc) access through tlb from kernel
>
>> 2) These addresses are mapped in userland, so, read from logical address
>> 0x20000000 in userland may result in read from any physical address
>> located in range 0x00000000 - 0xBFFFFFFF as defined by TLB for that
>> particular userland thread?
> Yes, though it could in theory be any physical address mapped by the
> TLB, not just that range.
>
> Cheers
> James
