Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Sep 2018 20:09:08 +0200 (CEST)
Received: from rcdn-iport-2.cisco.com ([173.37.86.73]:55827 "EHLO
        rcdn-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992501AbeI0SJEb27JS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Sep 2018 20:09:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=843; q=dns/txt; s=iport;
  t=1538071744; x=1539281344;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=cAG8rOD6AL/BWLmyRIVLF6FwD6JtQPyY8cfvn+rw6AM=;
  b=cLr6yvOtc2iKCkvbs6IxcdGvC7RPGTFajKvwabNJXTco20g/SwDYY4HS
   ExcWRAH8MNqU6JgfF3hUU15Yd7ApPdu1Kw+aQt6m2BPX+9rIrWUk/aJdA
   CaeUs87njLK3tMW+ZVopVDtIcP06rWrzDAg+x1rnXeVzTar/84N4m0i1g
   o=;
X-IronPort-AV: E=Sophos;i="5.54,311,1534809600"; 
   d="scan'208";a="461535457"
Received: from alln-core-10.cisco.com ([173.36.13.132])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2018 18:08:56 +0000
Received: from [10.24.65.89] ([10.24.65.89])
        by alln-core-10.cisco.com (8.15.2/8.15.2) with ESMTP id w8RI8pMg000694;
        Thu, 27 Sep 2018 18:08:54 GMT
Subject: Re: [PATCH 0/8] add generic builtin command line
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Maksym Kokhan <maksym.kokhan@globallogic.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Walker <dwalker@fifo99.com>,
        Andrii Bordunov <aborduno@cisco.com>,
        Ruslan Bilovol <rbilovol@cisco.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
 <CAKv+Gu-AxtOO04iwPSri12tkb9NRugXV9E2LGrfJT-LJjf4_ow@mail.gmail.com>
From:   Daniel Walker <danielwa@cisco.com>
Message-ID: <3320a561-2287-63f7-2162-84a639a22a8a@cisco.com>
Date:   Thu, 27 Sep 2018 11:08:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-AxtOO04iwPSri12tkb9NRugXV9E2LGrfJT-LJjf4_ow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Outbound-SMTP-Client: 10.24.65.89, [10.24.65.89]
X-Outbound-Node: alln-core-10.cisco.com
Return-Path: <danielwa@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: danielwa@cisco.com
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

On 09/27/2018 10:05 AM, Ard Biesheuvel wrote:
> On 27 September 2018 at 18:55, Maksym Kokhan
> <maksym.kokhan@globallogic.com> wrote:
>> There were series of patches [1] for 4.3.0-rc3, that allowed
>> architectures to use a generic builtin command line. I have rebased
>> these patches on kernel 4.19.0-rc4.
>>
> 
> Could you please elaborate on the purpose of this series? Is it simply
> to align between architectures? Does it solve an actual problem?

1) It removed a lot of code duplication between architecture

2) At Cisco we have issues where our bootloaders having default boot 
arguments. Some platforms we can't update the boot loader and it's 
helpful to be able to have boot arguments which are prepended to the 
bootloader arguments , and some parameters which are appended. These 
changes allow that.

Daniel
