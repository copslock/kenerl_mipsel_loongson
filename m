Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jun 2017 00:09:16 +0200 (CEST)
Received: from mail-pf0-x241.google.com ([IPv6:2607:f8b0:400e:c00::241]:34348
        "EHLO mail-pf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993867AbdFWWJJgzHQ- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jun 2017 00:09:09 +0200
Received: by mail-pf0-x241.google.com with SMTP id d5so9185435pfe.1
        for <linux-mips@linux-mips.org>; Fri, 23 Jun 2017 15:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:to:to:to:to:to:to:to:to:to:to:to:to:to:to:to:to:to:to:to:to
         :to:to:to:to:to:to:subject:date:message-id:in-reply-to:references;
        bh=BbbXQ9TxIFSlaYQfNVciTNl5Rer90HRKrh8uRVHMC+Q=;
        b=AX0ppT5JiQR2/Mpx9ScIYJZqxzFq5QAJCulcUhouSRavqi8c3f7ycrRiYN4uZv3ZUP
         E20242wvkc+7HDUuycDbG+0k3A1mBT8ddvM0hg50xe2STgV40RPpJvPlSUkjwjGYIqHp
         6fuMJML/uJihaAnIiVWkJY70LYhzkp3D48mAeMzz+XIj0myWorOwqTWofl1jY0UxRSbn
         qytAMDES7MQcInCliYrAFZr/3mc1u2HFzV9b8k3shCcGlV85fSoUGn0ontRYHptiZM8T
         9VO9F76cxFi9IrSKhNAC4mR96vOCAAoDne7U0epuJhL9TiK2ls67CQQDQIl4N63LGuUJ
         ZvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:to:to:to:to:to:to:to:to:to:to:to:to:to
         :to:to:to:to:to:to:to:to:to:to:to:to:to:subject:date:message-id
         :in-reply-to:references;
        bh=BbbXQ9TxIFSlaYQfNVciTNl5Rer90HRKrh8uRVHMC+Q=;
        b=MyGzZkVe7NMXzVE40PzUSpdAvEezjFGDi4TRR9+e3RZji3v4UhrgAPmifZytfY4hnk
         sF8l8lSX935mW5SXEd0Zi3r7vJQ3KVr7J+yBYW/6FW8nYJuOLO1NdoiAqul5zXSWcYnC
         Zk/n7SACsPJSBQKvYUEXJBwWdVQhngcWRYhEXcpf7T5b3blui+OIt0JCQ5p0S3QfP9cf
         oj3B7YqTIkA+wUR5QPiW1+QfUUz1uy7j/OZ/8QD2xvCwhOhykM+R0WoG8CGg6X5qP3S0
         P4CKl5JD+uLG7NQ1NgdmTZ9qkcEiC3zWUm7TfKZ3NNhXjrZJ9QGn0n01MPnQeRtdHOqF
         xk2A==
X-Gm-Message-State: AKS2vOwR9BmyjwFXr9zDWje8bCAO5mHbL42PL+wAr/ww7dIltK18Bqax
        LgANijox2KbilSLT
X-Received: by 10.98.30.65 with SMTP id e62mr10391690pfe.127.1498255743624;
        Fri, 23 Jun 2017 15:09:03 -0700 (PDT)
Received: from localhost ([216.38.154.21])
        by smtp.gmail.com with ESMTPSA id c75sm13824545pga.38.2017.06.23.15.09.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jun 2017 15:09:02 -0700 (PDT)
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     rth@twiddle.net
To:     ink@jurassic.park.msu.ru
To:     mattst88@gmail.com
To:     vgupta@synopsys.com
To:     linux@armlinux.org.uk
To:     catalin.marinas@arm.com
To:     will.deacon@arm.com
To:     geert@linux-m68k.org
To:     ralf@linux-mips.org
To:     ysato@users.sourceforge.jp
To:     dalias@libc.org
To:     davem@davemloft.net
To:     cmetcalf@mellanox.com
To:     gxt@mprc.pku.edu.cn
To:     bhelgaas@google.com
To:     viro@zeniv.linux.org.uk
To:     akpm@linux-foundation.org
To:     linux-alpha@vger.kernel.org
To:     linux-kernel@vger.kernel.org
To:     linux-snps-arc@lists.infradead.org
To:     linux-arm-kernel@lists.infradead.org
To:     linux-m68k@lists.linux-m68k.org
To:     linux-mips@linux-mips.org
To:     linux-sh@vger.kernel.org
To:     sparclinux@vger.kernel.org
To:     linux-pci@vger.kernel.org
To:     hch@infradead.org
Subject: Re: [PATCH] pci:  Add and use PCI_GENERIC_SETUP Kconfig entry
Date:   Fri, 23 Jun 2017 15:08:56 -0700
Message-Id: <20170623220857.28774-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170623220104.GE31455@jhogan-linux.le.imgtec.org>
References: <20170623220104.GE31455@jhogan-linux.le.imgtec.org>
Return-Path: <palmer@dabbelt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: palmer@dabbelt.com
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

On Fri, 23 Jun 2017 15:01:04 PDT (-0700), james.hogan@imgtec.com wrote:
> On Fri, Jun 23, 2017 at 02:45:38PM -0700, Palmer Dabbelt wrote:
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 4c1a35f15838..86872246951c 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -96,6 +96,7 @@ config ARM
>>      select PERF_USE_VMALLOC
>>      select RTC_LIB
>>      select SYS_SUPPORTS_APM_EMULATION
>> +    select PCI_GENERIC_SETUP
>>      # Above selects are sorted alphabetically; please add new ones
>>      # according to that.  Thanks.
>
> This comment seems to suggest PCI_GENERIC_SETUP should be added a few
> lines up to preserve the alphabetical sorting.
>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index b2024db225a9..6c684d8c8816 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -115,6 +115,7 @@ config ARM64
>>      select SPARSE_IRQ
>>      select SYSCTL_EXCEPTION_TRACE
>>      select THREAD_INFO_IN_TASK
>> +    select PCI_GENERIC_SETUP
>
> Here too.
>
>> diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
>> index 4583c0320059..6679af85a882 100644
>> --- a/arch/tile/Kconfig
>> +++ b/arch/tile/Kconfig
>> @@ -33,6 +33,7 @@ config TILE
>>      select USER_STACKTRACE_SUPPORT
>>      select USE_PMC if PERF_EVENTS
>>      select VIRT_TO_BUS
>> +    select PCI_GENERIC_SETUP
>
> and here
>
> Otherwise
> Reviewed-by: James Hogan <james.hogan@imgtec.com>

Whoops -- I guess I was just on autopilot after seeing the first one not be
alphabetized.  A fixed patch is in a threaded message.
