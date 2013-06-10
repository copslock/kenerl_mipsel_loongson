Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 19:14:52 +0200 (CEST)
Received: from mail-ie0-f177.google.com ([209.85.223.177]:65359 "EHLO
        mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835158Ab3FJROgsbSZN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Jun 2013 19:14:36 +0200
Received: by mail-ie0-f177.google.com with SMTP id u16so16239624iet.8
        for <multiple recipients>; Mon, 10 Jun 2013 10:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=4EYNFZo9lNFTIj9qk9m5ALZHpGtPbv55aY5xOXVXWHQ=;
        b=a7uMAU2nX7hXBpg8gFHdd7/mlva4uyTfkfTQGYS95eyAZ+CBzjdwzWSKT0DJSETjfI
         kQS0EF+JBx4vLWKHGFx3MoTn5TSTEjVJ640Ms3nvAF5uG9dK4Nl8smO5XgVfQJjBVyCE
         etl6bGS+rLDrdY+iKHVjTtDPqmunkblUQadQDE3082KusduKkHSAZkxQKRhzxEpKJsbk
         huYZVUjMsSOnvdWwtQ8d+Mm5h837kMyjyRlE1sCU9NYfoeTuhlM0CsqSeb/miAJYKUrI
         RR4BLwCa/WRWOZbqV6/bRSG1ydNAtEHuRWkd7o2mP8TF/0A6I8Pzu5nlmnNFuykyLG+o
         ygMQ==
X-Received: by 10.50.55.39 with SMTP id o7mr3182032igp.86.1370884470398;
        Mon, 10 Jun 2013 10:14:30 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id r20sm8805885ign.8.2013.06.10.10.14.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 10 Jun 2013 10:14:29 -0700 (PDT)
Message-ID: <51B60973.1080506@gmail.com>
Date:   Mon, 10 Jun 2013 10:14:27 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Sanjay Lal <sanjayl@kymasys.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 00/31] KVM/MIPS: Implement hardware virtualization via
 the MIPS-VZ extensions.
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com> <8D7771A4-B51E-4FA8-9342-621FE41792DE@kymasys.com>
In-Reply-To: <8D7771A4-B51E-4FA8-9342-621FE41792DE@kymasys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36811
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

On 06/10/2013 09:43 AM, Sanjay Lal wrote:
>
> On Jun 7, 2013, at 4:03 PM, David Daney wrote:
>
>> From: David Daney <david.daney@cavium.com>
>>
>> These patches take a somewhat different approach to MIPS
>> virtualization via the MIPS-VZ extensions than the patches previously
>> sent by Sanjay Lal.
>>
>> Several facts about the code:
>>
>>
>> o Currently probably only usable on the OCTEON III CPU model, as some
>>   MIPS-VZ implementation-defined behaviors were assumed to have the
>>   OCTEON III behavior.
>>
>
>
> I've only briefly gone over the patches, but I was wondering if the Cavium implementation has support for GuestIDs, which are optional in the VZ-ASE?
>

No, OCTEON III does not support this optional behavior.  For the most 
part this only impacts TLB management.  I think in the context of KVM, 
you cannot leave foreign Guest's TLB entries present in the Guest TLB 
anyhow, so the feature is of little use.

Since MIPS TLBs are managed by software, it is valid for a guest to 
populate the TLB in any way it desires.  To have the hypervisor (KVM) 
come and randomly invalidate the TLB, via the GuestID mechanism, would 
both be detectable by the guest, and potentially make the guest operate 
incorrectly.

David Daney

> Regards
> Sanjay
>
>
>
>
