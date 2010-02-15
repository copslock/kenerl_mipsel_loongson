Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2010 03:08:37 +0100 (CET)
Received: from mail-yx0-f194.google.com ([209.85.210.194]:52798 "EHLO
        mail-yx0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492125Ab0BOCIe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2010 03:08:34 +0100
Received: by yxe32 with SMTP id 32so4281054yxe.0
        for <multiple recipients>; Sun, 14 Feb 2010 18:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type;
        bh=joZl54JJ4ilC+2KWc/1VE3n+yPOrZTm45AaVcipozto=;
        b=arwOhkDbWAl0HCyo9fsuIpBqw514GwMLh4kETMmXRkSitmo6XNKiFCIzHTRXABw15W
         oXA8lcfp1UPchSosZXlxHg5nrmeUH4M7WUVUqEyFipaYuqDsdPwqxUJb5r7E+9bEP9in
         lxteLIev/K6owuM0kHnxFRAXj2fDtouVId44o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        b=KoZm69duqP8Nf5CQfjPR1umZYqsdwbkTbOba6rJDysbg1xkUx101FoScvJce1YSmTF
         GOdsmZVEABU2rRPbdEJy61wC/NX+oYtH+nCeC7zFHZr0dfbHTBZSiRNcL8BZSiTy6fXK
         K5HGX5pY9NyyrfsahpyC8Z9Yx15pD36Au/GhQ=
Received: by 10.150.175.1 with SMTP id x1mr2906899ybe.37.1266199707063;
        Sun, 14 Feb 2010 18:08:27 -0800 (PST)
Received: from dd_xps.caveonetworks.com (adsl-67-124-151-61.dsl.pltn13.pacbell.net [67.124.151.61])
        by mx.google.com with ESMTPS id 15sm4113943gxk.0.2010.02.14.18.08.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 18:08:26 -0800 (PST)
Message-ID: <4B78AC97.8030404@gmail.com>
Date:   Sun, 14 Feb 2010 18:08:23 -0800
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc11 Thunderbird/3.0.1
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Subject: Re: [PATCH 4/6] MIPS: Implement Read Inhibit/eXecute Inhibit
References: <4B733C71.8030304@caviumnetworks.com>         <1265843569-5786-4-git-send-email-ddaney@caviumnetworks.com> <f861ec6f1002141216t233fde34t1586bcd50dc051b4@mail.gmail.com> <4B78A0C1.1070509@gmail.com>
In-Reply-To: <4B78A0C1.1070509@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------050708080304060801080702"
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050708080304060801080702
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

On 02/14/2010 05:17 PM, David Daney wrote:
> On 02/14/2010 12:16 PM, Manuel Lauss wrote:
>> Hi David,
>>
>> this patch breaks my Alchemy builds:
>>
>> Using /mnt/data/_home/mano/db1200/kernel/linux-2.6.git as source for 
>> kernel
>> GEN /mnt/data/_home/mano/db1200/kernel/kbuild-linux-2.6.git/Makefile
>> CHK include/linux/version.h
>> CHK include/generated/utsrelease.h
>> UPD include/generated/utsrelease.h
>> CC arch/mips/kernel/asm-offsets.s
>> In file included from
>> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/io.h:25, 
>>
>> from
>> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/page.h:46, 
>>
>> from
>> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/include/linux/mm_types.h:15, 
>>
>> from
>> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/include/linux/sched.h:63, 
>>
>> from
>> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/kernel/asm-offsets.c:13: 
>>
>> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/pgtable-bits.h: 
>>
>> In function 'pte_to_entrylo':
>> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/pgtable-bits.h:146: 
>>
>> error: '_PAGE_NO_READ_SHIFT' undeclared (first use in this function)
>> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/pgtable-bits.h:146: 
>>
>> error: (Each undeclared identifier is reported only once
>> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/pgtable-bits.h:146: 
>>
>> error: for each function it appears in.)
>> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/pgtable-bits.h:155: 
>>
>> error: '_PAGE_GLOBAL_SHIFT' undeclared (first use in this function)
>> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/pgtable-bits.h:156: 
>>
>> error: '_PAGE_NO_EXEC' undeclared (first use in this function)
>> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/pgtable-bits.h:156: 
>>
>> error: '_PAGE_NO_READ' undeclared (first use in this function)
>> In file included from
>> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/include/linux/mm.h:39,
>> from
>> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/kernel/asm-offsets.c:14: 
>>
>> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/pgtable.h: 
>>
>> In function 'pte_modify':
>> /mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/pgtable.h:351: 
>>
>> error: '_PFN_MASK' undeclared (first use in this function)
>> make[2]: *** [arch/mips/kernel/asm-offsets.s] Error 1
>> make[1]: *** [prepare0] Error 2
>> make: *** [sub-make] Error 2
> Whoops! I will endeavor to fix this.

Try the attached patch, it allows me to build an au1000 kernel. But 
since I don't have harware, I cannot test it.

I started with pb1500_defconfig, but had to disable au1000_eth.c:

drivers/net/au1000_eth.c: In function ‘au1000_probe’:
drivers/net/au1000_eth.c:1009: error: implicit declaration of function 
‘DECLARE_MAC_BUF’
drivers/net/au1000_eth.c:1009: error: ‘ethaddr’ undeclared (first use in 
this function)
drivers/net/au1000_eth.c:1009: error: (Each undeclared identifier is 
reported only once
drivers/net/au1000_eth.c:1009: error: for each function it appears in.)

David Daney.


--------------050708080304060801080702
Content-Type: text/plain;
 name="dd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dd.patch"

MIPS: Fix RIXI patch for au1000 processors.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/pgtable-bits.h |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index a2e646f..47ca734 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -66,7 +66,6 @@
 #define _PAGE_SILENT_WRITE          (1<<10)
 #define _CACHE_UNCACHED             (1<<11)
 #define _CACHE_MASK                 (1<<11)
-#define _PFN_SHIFT                  PAGE_SHIFT
 
 #else /* 'Normal' r4K case */
 /*
@@ -129,10 +128,22 @@
 #define _CACHE_MASK		(7 << _CACHE_SHIFT)
 
 #define _PFN_SHIFT		(PAGE_SHIFT - 12 + _CACHE_SHIFT + 3)
-#define _PFN_MASK		(~((1 << (_PFN_SHIFT)) - 1))
 
 #endif /* defined(CONFIG_64BIT_PHYS_ADDR && defined(CONFIG_CPU_MIPS32) */
 
+#ifndef _PFN_SHIFT
+#define _PFN_SHIFT                  PAGE_SHIFT
+#endif
+#define _PFN_MASK		(~((1 << (_PFN_SHIFT)) - 1))
+
+#ifndef _PAGE_NO_READ
+#define _PAGE_NO_READ ({BUG(); 0; })
+#define _PAGE_NO_READ_SHIFT ({BUG(); 0; })
+#endif
+#ifndef _PAGE_NO_EXEC
+#define _PAGE_NO_EXEC ({BUG(); 0; })
+#endif
+
 #ifndef __ASSEMBLY__
 /*
  * pte_to_entrylo converts a page table entry (PTE) into a Mips
@@ -152,11 +163,10 @@ static inline uint64_t pte_to_entrylo(unsigned long pte_val)
 		 * followed by a ROTR 2.  Luckily in the fast path
 		 * this is done in assembly
 		 */
-		return (pte_val >> _PAGE_GLOBAL_SHIFT) |
+		return (pte_val >> ilog2(_PAGE_GLOBAL)) |
 			((pte_val & (_PAGE_NO_EXEC | _PAGE_NO_READ)) << sa);
 	}
-
-	return pte_val >> _PAGE_GLOBAL_SHIFT;
+	return pte_val >> ilog2(_PAGE_GLOBAL);
 }
 #endif
 

--------------050708080304060801080702--
