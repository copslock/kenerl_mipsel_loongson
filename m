Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 17:42:42 +0200 (CEST)
Received: from mail-wi0-f181.google.com ([209.85.212.181]:32860 "EHLO
        mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010556AbbHMPmkoZQmQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Aug 2015 17:42:40 +0200
Received: by wijp15 with SMTP id p15so264073319wij.0
        for <linux-mips@linux-mips.org>; Thu, 13 Aug 2015 08:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=m9gcfP4dp1xOog9x2USAAxdZhlysz6tbfMKLTeiRkh4=;
        b=PNSUBIUTPZURLyOiJe4248COTzsWxWTHH2TZeOUNmGoHbChOsvD1pj3qWWb30RByyP
         F3IrPT3pQqL836dKb4xT2kEcLAfWX2CxVG/aqVGYPMmCB+TtfSwqyKw6ljGu+oq+7Ofu
         n4qKdDDEXU4njW1dNlqqKuHORszCK8Ihw12xnD2wGJZiunScBM+WBXCaqwdjjWQrnakR
         ohqkranTih6coHKb1GmPtPx3XzOEuGG7wsvupAvhdAxXehr75EvYuAdTyyZ2fmjsAzga
         w6noTovEfebOSrPgbIudK3P/JauMj/NCYKX1SZpEpITakor7a/tGDIKY46eW/LHppTif
         mazg==
X-Gm-Message-State: ALoCoQm4zdLzKakk2Gu1yTFpzzW5dWhkVsZ4YMSqAM59So7nIdgOuVEKUJiL8eDYfNIzrJBbWYxF
X-Received: by 10.180.11.194 with SMTP id s2mr7546328wib.33.1439480555502;
        Thu, 13 Aug 2015 08:42:35 -0700 (PDT)
Received: from [10.0.0.5] ([207.232.55.62])
        by smtp.googlemail.com with ESMTPSA id cd16sm3943488wib.19.2015.08.13.08.42.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2015 08:42:34 -0700 (PDT)
Message-ID: <55CCBAE8.8090502@plexistor.com>
Date:   Thu, 13 Aug 2015 18:42:32 +0300
From:   Boaz Harrosh <boaz@plexistor.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Christoph Hellwig <hch@lst.de>
CC:     torvalds@linux-foundation.org, axboe@kernel.dk,
        linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linux-nvdimm@ml01.01.org, dhowells@redhat.com,
        sparclinux@vger.kernel.org, egtvedt@samfundet.no,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        x86@kernel.org, dwmw2@infradead.org, hskinnemoen@gmail.com,
        linux-xtensa@linux-xtensa.org, grundler@parisc-linux.org,
        realmz6@gmail.com, alex.williamson@redhat.com,
        linux-metag@vger.kernel.org, monstr@monstr.eu,
        linux-parisc@vger.kernel.org, vgupta@synopsys.com,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-media@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: RFC: prepare for struct scatterlist entries without page backing
References: <1439363150-8661-1-git-send-email-hch@lst.de> <55CB3F47.3000902@plexistor.com> <20150813144036.GB17375@lst.de>
In-Reply-To: <20150813144036.GB17375@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <boaz@plexistor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boaz@plexistor.com
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

On 08/13/2015 05:40 PM, Christoph Hellwig wrote:
> On Wed, Aug 12, 2015 at 03:42:47PM +0300, Boaz Harrosh wrote:
>> The support I have suggested and submitted for zone-less sections.
>> (In my add_persistent_memory() patchset)
>>
>> Would work perfectly well and transparent for all such multimedia cases.
>> (All hacks removed). In fact I have loaded pmem (with-pages) on a VRAM
>> a few times and it is great easy fun. (I wanted to experiment with cached
>> memory over a pcie)
> 
> And everyone agree that it was both buggy and incomplete.
> 

What? No one ever said anything about bugs. Is the first ever I hear of it.
I was always in the notion that no one even tried it out.

I'm smoking these page-full nvidimms for more than a year. With RDMA to
pears and swap out to disks. So is not that bad I would say

> Dan has done a respin of the page backed nvdimm work with most of
> these comments addressed.
> 

I would love some comments. All I got so far is silence. (And I do not
like Dan's patches comments will come next week)

> I have to say I hate both pfn-based I/O [1] and page backed nvdimms with
> passion, so we're looking into the lesser evil with an open mind.
> 
> [1] not the SGL part posted here, which I think is quite sane.  The bio
>     side is much worse, though.
> 

What can I say. I like the page-backed nvdimms. And the long term for me
is 2M pages. I hope we can sit one day soon and you explain to me whats
evil about it. I would really really like to understand

Thanks though
Boaz
