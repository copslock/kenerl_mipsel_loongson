Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 16:33:12 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:55200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992267AbeJLOdHOt0Ad (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Oct 2018 16:33:07 +0200
Received: from linux-8ccs (nat.nue.novell.com [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3A5820835;
        Fri, 12 Oct 2018 14:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539354780;
        bh=5jXZlJ/dIGQIyx/TGvkuXSH4shejyurjFKIYiEAaWHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0tgJQdtsIQlm5EX9oqkDFhZGBp4uUusjg7pZXbiGskPo7Wbp2TnRXmVYkInLCN2G3
         QUdvr8o+AQIFTHIxbzZC8pL6XBhyzWdceosm2U/YOm0Yib0HU5g7pNV/NTS0JTeo3F
         EH20X8PXubW3NYhuhVLo3vxEf15pWXFL0SXWMbwA=
Date:   Fri, 12 Oct 2018 16:32:54 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        kernel-hardening@lists.openwall.com, daniel@iogearbox.net,
        keescook@chromium.org, catalin.marinas@arm.com,
        will.deacon@arm.com, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, kristen@linux.intel.com,
        arjan@linux.intel.com, deneen.t.dock@intel.com
Subject: Re: [PATCH v2 4/7] arm64/modules: Add rlimit checking for arm64
 modules
Message-ID: <20181012143254.idy65qbvaaw5k3ge@linux-8ccs>
References: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
 <20181011233117.7883-5-rick.p.edgecombe@intel.com>
 <25951d99-8ba7-5c9e-938e-baf92395f9e0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <25951d99-8ba7-5c9e-938e-baf92395f9e0@intel.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.16-default x86_64
User-Agent: NeoMutt/20170912 (1.9.0)
Return-Path: <jeyu@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeyu@kernel.org
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

+++ Dave Hansen [11/10/18 16:47 -0700]:
>On 10/11/2018 04:31 PM, Rick Edgecombe wrote:
>> +	if (check_inc_mod_rlimit(size))
>> +		return NULL;
>> +
>>  	p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
>>  				module_alloc_base + MODULES_VSIZE,
>>  				gfp_mask, PAGE_KERNEL_EXEC, 0,
>> @@ -65,6 +68,8 @@ void *module_alloc(unsigned long size)
>>  		return NULL;
>>  	}
>>
>> +	update_mod_rlimit(p, size);
>
>Is there a reason we couldn't just rename all of the existing per-arch
>module_alloc() calls to be called, say, "arch_module_alloc()", then put
>this new rlimit code in a generic helper that does:
>
>
>	if (check_inc_mod_rlimit(size))
>		return NULL;
>
>	p = arch_module_alloc(...);
>
>	...
>
>	update_mod_rlimit(p, size);
>

I second this suggestion. Just make module_{alloc,memfree} generic,
non-weak functions that call the rlimit helpers in addition to the
arch-specific arch_module_{alloc,memfree} functions.

Jessica
