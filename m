Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 May 2013 18:55:02 +0200 (CEST)
Received: from mail-ia0-f178.google.com ([209.85.210.178]:53704 "EHLO
        mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823037Ab3EOQyhzbLrD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 May 2013 18:54:37 +0200
Received: by mail-ia0-f178.google.com with SMTP id i9so2426571iad.9
        for <multiple recipients>; Wed, 15 May 2013 09:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=zh2H1qWk66SwHyZCH8ymY5mS+PsW6VEGiSnMMgpOa70=;
        b=YYJllalUIa+KZjc1SXgvgq8udGI8ukA5eXdFfEd1JQ6wjDJ/dejLT4bZ9bJtAxOBAD
         X4mcYpcVOQtQ2FdBnxY3+gdrNzIejIo1hxCKNi3HhHYPmjgwx2RUCtsQvjutSFYcIcLW
         Be3xw6ozsZJpAv+tU7opgoNFXJIlVgSaXkLSpZkp3ekPTRSWWqXoY6JhlrQpOHrbVvqo
         0Q3o5+yiOu3OSw+DjwbqIdkWgNLRO/gxYc6MAicF98D+yPBV/w4cVgODaqkWUpQMC+JE
         4EXZxEOOldhweYxiJJzgI00vr+qXjN2FTLs/BzcMgSbI9F9v70Gw6s8lSj7Gu8XT1PJG
         +VSw==
X-Received: by 10.50.77.73 with SMTP id q9mr5984445igw.97.1368636867732;
        Wed, 15 May 2013 09:54:27 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id d4sm30659521igc.3.2013.05.15.09.54.25
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 15 May 2013 09:54:26 -0700 (PDT)
Message-ID: <5193BDC0.6090103@gmail.com>
Date:   Wed, 15 May 2013 09:54:24 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Sanjay Lal <sanjayl@kymasys.com>
CC:     Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, mtosatti@redhat.com, ralf@linux-mips.org
Subject: Re: [PATCH 2/2] KVM/MIPS32: Wrap calls to gfn_to_pfn() with srcu_read_lock/unlock()
References: <n> <1368476500-20031-1-git-send-email-sanjayl@kymasys.com> <1368476500-20031-3-git-send-email-sanjayl@kymasys.com> <20130514092705.GD20995@redhat.com> <63B7D172-E75E-4AB4-8515-9A18360B66A2@kymasys.com>
In-Reply-To: <63B7D172-E75E-4AB4-8515-9A18360B66A2@kymasys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36407
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

On 05/15/2013 08:54 AM, Sanjay Lal wrote:
>
> On May 14, 2013, at 2:27 AM, Gleb Natapov wrote:
>
>>>
>>>
>>> +EXPORT_SYMBOL(min_low_pfn);     /* defined by bootmem.c, but not exported by generic code */
>>> +
>> What you need this for? It is not used anywhere in this patch and by
>> mips/kvm code in general.
>
> I did some digging around myself, since the linker keeps complaining that it can't find min_low_pfn when compiling the KVM module.  It seems that it is indirectly pulled in by the cache management functions.
>

If it is really needed, then the export should probably be done at the 
site of the min_low_pfn definition, not in some random architecture file.

An alternative is to fix the cache management functions so they don't 
require the export.

David Daney

>
> Regards
> Sanjay
>
>
>
>
>
