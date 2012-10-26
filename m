Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Oct 2012 00:31:48 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:40836 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823102Ab2JZWbrrMUUV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Oct 2012 00:31:47 +0200
Received: by mail-pa0-f49.google.com with SMTP id bi5so2045805pad.36
        for <multiple recipients>; Fri, 26 Oct 2012 15:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Vn68WuMIa0bQ1bzoxH8HhgZxpsLsaPTWLXZm8+1p38k=;
        b=zHG5Wg3gJlUeb0EQIbKLAe/RgcKuyETtUHvJ0avarlQlHMEzeGvT1p5CjPBoOK99DR
         cjzOnp/6f2KgKS5FdJrcSNIWirsK3WZbrsVmA3B7a+mmEkx45+VNupsd1sCot1VQhhtC
         noU/As0ZQmdpY/TnjvTDk6LOX9vcS2DomTYTSaykLy9GiZDGXhDf/uhcXYcCWHO3u4nc
         gzWz/17TuVIAlnZ9Aj54A/HOhUCxJvUW9S1JDLaf9yPHNy6/0xYeLgJdxnGe/ryRxW6D
         oxbL3shCCGq6roDefIm9QVUvEnDFfkUi4VQAxw45rodOFp2NQa7B91R1idhtSW35te1O
         Fudw==
Received: by 10.68.220.2 with SMTP id ps2mr73396529pbc.61.1351290700842;
        Fri, 26 Oct 2012 15:31:40 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id iq3sm1787061pbc.5.2012.10.26.15.31.39
        (version=SSLv3 cipher=OTHER);
        Fri, 26 Oct 2012 15:31:40 -0700 (PDT)
Message-ID: <508B0F4B.80601@gmail.com>
Date:   Fri, 26 Oct 2012 15:31:39 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
MIME-Version: 1.0
To:     shuah.khan@hp.com
CC:     ralf@linux-mips.org, kyungmin.park@samsung.com, arnd@arndb.de,
        andrzej.p@samsung.com, m.szyprowski@samsung.com,
        linux-mips@linux-mips.org, LKML <linux-kernel@vger.kernel.org>,
        shuahkhan@gmail.com
Subject: Re: [PATCH RFT RESEND linux-next] mips: dma-mapping: support debug_dma_mapping_error
References: <1351208193.6851.17.camel@lorien2>  <1351267298.4013.12.camel@lorien2> <508ABE1D.5010106@gmail.com>  <1351271198.4013.35.camel@lorien2> <508AED66.3040808@gmail.com> <1351288264.6885.11.camel@lorien2>
In-Reply-To: <1351288264.6885.11.camel@lorien2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34780
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 10/26/2012 02:51 PM, Shuah Khan wrote:

>>>> On 10/26/2012 09:01 AM, Shuah Khan wrote:
>>>>> Add support for debug_dma_mapping_error() call to avoid warning from
>>>>> debug_dma_unmap() interface when it checks for mapping error checked
>>>>> status. Without this patch, device driver failed to check map error
>>>>> warning is generated.

I'm confused.

Your claim that a 'warning is generated' seems to be in conflict with...


[...]
> Got it. Thanks. I would volunteer to look at fixing all the problems,
> but unfortunately I don't have a MIPS box handy

This statement that you don't have hardware that exhibits the problem.

How was the patch tested?  How do you even know there is a problem?

David Daney
