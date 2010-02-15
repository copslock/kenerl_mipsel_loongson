Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2010 02:18:08 +0100 (CET)
Received: from mail-yw0-f187.google.com ([209.85.211.187]:58805 "EHLO
        mail-yw0-f187.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492046Ab0BOBSE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2010 02:18:04 +0100
Received: by ywh17 with SMTP id 17so4120695ywh.23
        for <multiple recipients>; Sun, 14 Feb 2010 17:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=pSVCPE7dT9pQpZgn2fqnpAL4DZdvvKJQ7pWK1YHlYHY=;
        b=rfhHJB4OKHn8GbIkjIo25FbRntkWoL+s4deBJyyazlrNqaTkOChf13kiJS9PMGwyMn
         qvtmdUClojnoj77EzOCGPc7Py7nbiab9zycyur2M798UfrUUQf3KJRDcDMoB7uYeXN9Z
         Iv970fixmSX0MMg+QhwoCUWHn2rQG0I1DB04s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=hZGUqO1pybmFPWZn7SKjF5nBdh3eY7Kql08LxoHWW9xkBfpiUHwB7CjCZIvcZLCRBj
         iJlYoB8P2k9xHYXIp0h8P6cx47reC4AFq6Nei5kHkuafUKtHJzp6DRMANP2DUh3lvOGk
         ql2oHLDSyVwioFbZIUAq4pL5BF7iUTIANCALs=
Received: by 10.151.92.5 with SMTP id u5mr1323107ybl.114.1266196677559;
        Sun, 14 Feb 2010 17:17:57 -0800 (PST)
Received: from dd_xps.caveonetworks.com (adsl-67-124-151-61.dsl.pltn13.pacbell.net [67.124.151.61])
        by mx.google.com with ESMTPS id 9sm2138027yxf.41.2010.02.14.17.17.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 17:17:56 -0800 (PST)
Message-ID: <4B78A0C1.1070509@gmail.com>
Date:   Sun, 14 Feb 2010 17:17:53 -0800
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc11 Thunderbird/3.0.1
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Subject: Re: [PATCH 4/6] MIPS: Implement Read Inhibit/eXecute Inhibit
References: <4B733C71.8030304@caviumnetworks.com>         <1265843569-5786-4-git-send-email-ddaney@caviumnetworks.com> <f861ec6f1002141216t233fde34t1586bcd50dc051b4@mail.gmail.com>
In-Reply-To: <f861ec6f1002141216t233fde34t1586bcd50dc051b4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 02/14/2010 12:16 PM, Manuel Lauss wrote:
> Hi David,
>
> this patch breaks my Alchemy builds:
>
>    Using /mnt/data/_home/mano/db1200/kernel/linux-2.6.git as source for kernel
>    GEN     /mnt/data/_home/mano/db1200/kernel/kbuild-linux-2.6.git/Makefile
>    CHK     include/linux/version.h
>    CHK     include/generated/utsrelease.h
>    UPD     include/generated/utsrelease.h
>    CC      arch/mips/kernel/asm-offsets.s
> In file included from
> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/io.h:25,
>                   from
> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/page.h:46,
>                   from
> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/include/linux/mm_types.h:15,
>                   from
> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/include/linux/sched.h:63,
>                   from
> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/kernel/asm-offsets.c:13:
> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/pgtable-bits.h:
> In function 'pte_to_entrylo':
> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/pgtable-bits.h:146:
> error: '_PAGE_NO_READ_SHIFT' undeclared (first use in this function)
> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/pgtable-bits.h:146:
> error: (Each undeclared identifier is reported only once
> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/pgtable-bits.h:146:
> error: for each function it appears in.)
> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/pgtable-bits.h:155:
> error: '_PAGE_GLOBAL_SHIFT' undeclared (first use in this function)
> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/pgtable-bits.h:156:
> error: '_PAGE_NO_EXEC' undeclared (first use in this function)
> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/pgtable-bits.h:156:
> error: '_PAGE_NO_READ' undeclared (first use in this function)
> In file included from
> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/include/linux/mm.h:39,
>                   from
> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/kernel/asm-offsets.c:14:
> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/pgtable.h:
> In function 'pte_modify':
> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/pgtable.h:351:
> error: '_PFN_MASK' undeclared (first use in this function)
> make[2]: *** [arch/mips/kernel/asm-offsets.s] Error 1
> make[1]: *** [prepare0] Error 2
> make: *** [sub-make] Error 2
>    
Whoops!  I will endeavor to fix this.

Thanks for testing,
David Daney
