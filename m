Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 04:07:11 +0100 (CET)
Received: from mail-ot0-x244.google.com ([IPv6:2607:f8b0:4003:c0f::244]:36235
        "EHLO mail-ot0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990511AbdCBDHEM5lMl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 04:07:04 +0100
Received: by mail-ot0-x244.google.com with SMTP id i1so6188903ota.3;
        Wed, 01 Mar 2017 19:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=jMRzYvVGInzL5TuZsuPlRib1uI4Tg0tZdPgdNf043h8=;
        b=IrWPEO6bqkA62fLdGH3kEEz+Z2nKfecBuX8MojpHyC4gXjU1YiBYF18Z0V32YEZ3R2
         Uk6Yp/k0NKf23EzsCvXR6HGHoJWkY2+ke+GRmS5cjbVeB8Ao6zgrpxRPiAud38BIyqti
         aeKddDhsYetaRCy4b49G8gdIkbD9GX49ijLVBzz/YClVSvLhLptMPXeNwsSfTyNkRDr2
         OT4k4REdr9THSTGBYpJ5AsC4tjpiokFTLMKe6UHxPCw8rVYZFGp7hCgbQ8nQ1Ah+/1C4
         Ixk5ZqJ4rvzSPE54kcCj4RaE1DAJhIANrA/Cvcqfuor8Dx1DnPjFHfpwg+ED87POhe43
         fLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=jMRzYvVGInzL5TuZsuPlRib1uI4Tg0tZdPgdNf043h8=;
        b=MuVwwugLDB+lh+JwMU9DsCfsX4EF7wuyspXFtZ1rI3ilPcKE8bmQ+MAIH3fRXmvyr0
         HV8ix0x0nqFuyWz/SZbgEjB+jdzfFaEhJwLm8JJ4GZ4/b9kO8VVYg/CP/XbDlKcbMOSf
         06F1u5y1Rq2+VY/k4EjUVoTRS4HlEs1S/FwJ99gXq0kOlKB8oauOZHzHARIKYWGXsWOO
         6xLE/ZMUDPKteBLmbUhQW8c0sn0bZMoK3lVbx9rHpvQsCr9TPnnIS7ZxUOqFEQnkS1T0
         zSiQ1ZzGL6bJ+4zhgU8DYzHhHG20UbwctHD0y9a+9bhlLymmsCGrW1tlTUtOezdM5lcA
         +8BA==
X-Gm-Message-State: AMke39l+GuFehSSFkustq4qynZVUegyIEV5TENwE/Ba3OCGbKd+LGHO3TOA2iAmPOeLkRA==
X-Received: by 10.157.36.85 with SMTP id p79mr6686238ota.84.1488424018011;
        Wed, 01 Mar 2017 19:06:58 -0800 (PST)
Received: from ?IPv6:2001:470:d:73f:a116:863b:e34d:e904? ([2001:470:d:73f:a116:863b:e34d:e904])
        by smtp.gmail.com with ESMTPSA id 61sm2882480otf.28.2017.03.01.19.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Mar 2017 19:06:57 -0800 (PST)
Subject: Re: [PATCH 00/21] MIPS memblock: Remove bootmem code and switch to
 NO_BOOTMEM
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Serge Semin <fancer.lancer@gmail.com>, ralf@linux-mips.org,
        paul.burton@imgtec.com, rabinv@axis.com, matt.redfearn@imgtec.com,
        james.hogan@imgtec.com, alexander.sverdlin@nokia.com,
        robh+dt@kernel.org, frowand.list@gmail.com
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
 <7c333d34-fda6-9302-b84e-c0785c23733e@imgtec.com>
Cc:     Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a40b3b32-ba86-66d7-a5bb-4df42eb5cd62@gmail.com>
Date:   Wed, 1 Mar 2017 19:06:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <7c333d34-fda6-9302-b84e-c0785c23733e@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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



On 01/22/2017 11:55 PM, Marcin Nowakowski wrote:
> Hi Serge,
> 
> Thanks for this patch series, it's really useful. I've tested it on
> Malta and Ci40 and it seems to work well (I've posted a few small
> comments separately).

I have not tested this yet, but this is definitively a very useful patch
series, thanks a lot for doing this Serge!

One thing that was not obvious to me is that you may have to take care
of the "NOMAP" memblock type and avoid mapping these regions, which may
or may not be relevant on MIPS due to the different virtual memory
model. On ARM it's done in arch/arm/mm/mmu.c::map_lowmem.

Please respin, this is very helpful!

> 
> 
> On 19.12.2016 03:07, Serge Semin wrote:
>> Most of the modern platforms supported by linux kernel have already
>> been cleaned up of old bootmem allocator by moving to nobootmem
>> interface wrapping up the memblock. This patchset is the first
>> attempt to do the similar improvement for MIPS for UMA systems
>> only.
>>
>> Even though the porting was performed as much careful as possible
>> there still might be problem with support of some platforms,
>> especially Loonson3 or SGI IP27, which perform early memory manager
>> initialization by their self.
> 
>> The patchset is split so individual patch being consistent in
>> functional and buildable ways. But the MIPS early memory manager
>> will work correctly only either with or without the whole set being
>> applied. For the same reason a reviewer should not pay much attention
>> to methods bootmem_init(), arch_mem_init(), paging_init() and
>> mem_init() until they are fully refactored.
> 
> I'm not sure this can be merged that way? It would be up to Ralf to
> decide, but it is generally expected that all intermediate patches not
> only build, but also work correctly. I understand that this might be
> difficult to achieve given the scale of changes required here.
> 
>> The patchset is applied on top of kernel v4.9.
> 
> Can you please work on cleaning up the issues discussed in the comments
> so far as well as rebasing (and updating) the changes onto linux-next?
> There are a few patches I made related to kexec and kernel relocation
> that will force changes in your code (although I admit that the changes
> I did for kexec/relocation were in some places unnecessarily complex
> because of the mess in the bootmem handling in MIPS that you are now
> trying to clean up).
> 
> 
> Thanks,
> Marcin
> 
>> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
>>
>> Serge Semin (21):
>>   MIPS memblock: Unpin dts memblock sanity check method
>>   MIPS memblock: Add dts mem and reserved-mem callbacks
>>   MIPS memblock: Alter traditional add_memory_region() method
>>   MIPS memblock: Alter user-defined memory parameter parser
>>   MIPS memblock: Alter initrd memory reservation method
>>   MIPS memblock: Alter kexec-crashkernel parameters parser
>>   MIPS memblock: Alter elfcorehdr parameters parser
>>   MIPS memblock: Move kernel parameters parser into individual method
>>   MIPS memblock: Move kernel memory reservation to individual method
>>   MIPS memblock: Discard bootmem allocator initialization
>>   MIPS memblock: Add memblock sanity check method
>>   MIPS memblock: Add memblock print outs in debug
>>   MIPS memblock: Add memblock allocator initialization
>>   MIPS memblock: Alter IO resources initialization method
>>   MIPS memblock: Alter weakened MAAR initialization method
>>   MIPS memblock: Alter paging initialization method
>>   MIPS memblock: Alter high memory freeing method
>>   MIPS memblock: Slightly improve buddy allocator init method
>>   MIPS memblock: Add print out method of kernel virtual memory layout
>>   MIPS memblock: Add free low memory test method call
>>   MIPS memblock: Deactivate old bootmem allocator
>>
>>  arch/mips/Kconfig        |   2 +-
>>  arch/mips/kernel/prom.c  |  32 +-
>>  arch/mips/kernel/setup.c | 958 +++++++++++++++--------------
>>  arch/mips/mm/init.c      | 234 ++++---
>>  drivers/of/fdt.c         |  47 +-
>>  include/linux/of_fdt.h   |   1 +
>>  6 files changed, 739 insertions(+), 535 deletions(-)
>>
> 

-- 
Florian
