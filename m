Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Oct 2013 20:48:47 +0200 (CEST)
Received: from mail-ye0-f181.google.com ([209.85.213.181]:36322 "EHLO
        mail-ye0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6868678Ab3JCSsniAwvT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Oct 2013 20:48:43 +0200
Received: by mail-ye0-f181.google.com with SMTP id r14so711668yen.12
        for <multiple recipients>; Thu, 03 Oct 2013 11:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=cHjUjD9RudDM8EGd/ZeOTzHa7TYG6q2sivQxO/oWQeg=;
        b=rRD4zbYZrPvRRsXcGVpsEcSWdJPlnUuWBdDFhJQKrtnMLwTrt9U4m8i6OnaN7vPN4v
         MVv0c7JekqBI1IWzig9CLwHkS1fkLbK6XGYUDW24/L04oJ/hiW5CVzCPFLIiPasNFWRT
         A4VBmHuBvhYWZGi51xjxRl7VPsV0o7JWcgE3jOh6rp+Y6Yf945KcZ232GyjuDn+V8wCQ
         Ljiqv81o57IMqbOV3VXlz4lDbS1Nt6f+GFGtbIp6oeCi0gOs3rGDqMal1ypcwEdHb25s
         YPiwlnEMrstVbCJd49kpDisIfsjhhF8u8TbKkwQZCBi3ee0Nv6vOUXkaauK+IA6lEoLK
         ul0g==
X-Received: by 10.236.31.71 with SMTP id l47mr1646685yha.121.1380826117339;
        Thu, 03 Oct 2013 11:48:37 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id a21sm12778055yhc.23.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 03 Oct 2013 11:48:36 -0700 (PDT)
Message-ID: <524DBC02.6020009@gmail.com>
Date:   Thu, 03 Oct 2013 11:48:34 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Prem Mallappa <prem.mallappa@gmail.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Prem Mallappa <pmallappa@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: KDUMP: Fix to access non-sectioned memory
References: <1380786415-24956-1-git-send-email-pmallappa@caviumnetworks.com> <1380786415-24956-2-git-send-email-pmallappa@caviumnetworks.com> <20131003182915.GA15556@linux-mips.org>
In-Reply-To: <20131003182915.GA15556@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 10/03/2013 11:29 AM, Ralf Baechle wrote:
> On Thu, Oct 03, 2013 at 01:16:55PM +0530, Prem Mallappa wrote:
>
>> @@ -41,19 +42,20 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
>>   	if (!csize)
>>   		return 0;
>>
>> -	vaddr = kmap_atomic_pfn(pfn);
>> +	vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
>
> This is not portable, I'm afraid.

It raised a red flag for me too.

I wonder, how does /dev/mem handle it?  We should probably do what the 
mem driver does for this.

David Daney


>
> Ioremap on MIPS is creating uncached mappings - on most systems, that is.
> However there is no guarantee that the data accessed through this mapping
> does not reside in a cache on another CPU or another virtual address
> which would make the operation undefined.
>
> On SGI IP27 and IP35 ioremap is not even able to create RAM mappings at
> all.  If you're lucky this would result in a bus error; if you're unlucky
> it'll make the SCSI controller scribble the answer to the universe, life
> and everything on the disk drive only to corrupt it again before you have
> a chance to read it ;-)
>
> I think this is bulletproof on Octeon so until there's a better patch you
> may want to keep this around for the SDK.
>
> I wonder, does commit 5395d97b675986e7e8f3140f9e0819d20b1d22cd
> in upstream-sfr.git fix your issue?
>
> Cheers,
>
>    Ralf
>
>
>
