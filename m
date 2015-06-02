Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2015 01:56:55 +0200 (CEST)
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35742 "EHLO
        mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008055AbbFBX4xchz5- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2015 01:56:53 +0200
Received: by igbyr2 with SMTP id yr2so99979522igb.0;
        Tue, 02 Jun 2015 16:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=297y+H5qq8W/6Njed/iu26S7WkFJZ5ZSrj4cdqnOooo=;
        b=MD1gwJlTFs5WIbye3YhSlSEVEDXUrpTjjybR0jLPz3FbltJ8nNdxzZRlYuM4hfAnU0
         SEWgeRS/WgPtwxtPbDLP2ONFq4KXcIZCKbCDlV6sTKK7lX9MChN5fPwertIuI7YaJbCh
         VDcPlNB1dLrGR1UL4byIa9u3CdRtvhBL/cSRH89SaxsChXiyoNt2SFROJ5EQUIrWAm/U
         ILmrqrVfiHKQPr9o9S8hnYjrRrd02ZzTSFDCx6SwjVAZSeBSJvVDxPe0yELYl3kCAGed
         NMxM4JL9xj/m+ASEK2/hyHklx+Vts9FuzTwMGwMilBfmoHPpOeE91dVJX0DcnOW/qU/B
         nH8w==
X-Received: by 10.107.26.207 with SMTP id a198mr36685393ioa.5.1433289407526;
        Tue, 02 Jun 2015 16:56:47 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id 196sm935172ioe.23.2015.06.02.16.56.44
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 16:56:45 -0700 (PDT)
Message-ID: <556E42BB.4060705@gmail.com>
Date:   Tue, 02 Jun 2015 16:56:43 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, benh@kernel.crashing.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, markos.chandras@imgtec.com,
        Steven.Hill@imgtec.com, alexander.h.duyck@redhat.com,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/3] MIPS: R6: Use lightweight SYNC instruction in smp_*
 memory barriers
References: <20150602000818.6668.76632.stgit@ubuntu-yegoshin> <20150602000934.6668.43645.stgit@ubuntu-yegoshin> <556D8A03.9080201@imgtec.com> <alpine.LFD.2.11.1506021709420.6751@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1506021709420.6751@eddie.linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47815
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

On 06/02/2015 09:15 AM, Maciej W. Rozycki wrote:
> On Tue, 2 Jun 2015, James Hogan wrote:
>
>>> diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
>>> index 2b8bbbcb9be0..d2a63abfc7c6 100644
>>> --- a/arch/mips/include/asm/barrier.h
>>> +++ b/arch/mips/include/asm/barrier.h
>>> @@ -96,9 +96,15 @@
>>>   #  define smp_rmb()	barrier()
>>>   #  define smp_wmb()	__syncw()
>>>   # else
>>> +#  ifdef CONFIG_MIPS_LIGHTWEIGHT_SYNC
>>> +#  define smp_mb()      __asm__ __volatile__("sync 0x10" : : :"memory")
>>> +#  define smp_rmb()     __asm__ __volatile__("sync 0x13" : : :"memory")
>>> +#  define smp_wmb()     __asm__ __volatile__("sync 0x4" : : :"memory")
>>
>> binutils appears to support the sync_mb, sync_rmb, sync_wmb aliases
>> since version 2.21. Can we safely use them?
>
>   I suggest that we don't -- we still officially support binutils 2.12 and
> have other places where we even use `.word' to insert instructions current
> versions of binutils properly handle.  It may be worth noting in a comment
> though that these encodings correspond to these operations that you named.
>

Surely the other MIPSr6 instructions are not supported in binutils 2.12 
either.  So if it is for r6, why not require modern tools, and put 
something user readable in here?

David Daney
