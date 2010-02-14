Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Feb 2010 21:16:47 +0100 (CET)
Received: from mail-fx0-f224.google.com ([209.85.220.224]:59654 "EHLO
        mail-fx0-f224.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491925Ab0BNUQn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Feb 2010 21:16:43 +0100
Received: by fxm24 with SMTP id 24so4367317fxm.0
        for <multiple recipients>; Sun, 14 Feb 2010 12:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=ACDiICNnozgUrUucR3zs1M4OF8MADs+lKC2SlRPX63Q=;
        b=VqHKavBCsPPYRbjLsYNxR1j4OEe3NMaAKqOmdDmprxGuZft+uVC0l/wYdvWgHuFKBo
         63gOgSnYCkRBAGPgWHkcDo7/EM9lV2galwjJb1/eu6vjK3DTQOwn0ybiau3UfLgvbrf6
         4+zR14O3Bf40mQJdm9NF1hgI2OjZ387MoA58M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mQgv7A+F+i9XwbjWLENmhiUVS3+euClDioP2poH06iG5AI59JrKmVB3Q0pbZ4p/tOR
         5CcydhLHOnrTgUqh/N1VI0aj4k59ciC6FWPcE06og99EaYyrr79DBC9f8Q773jdfb7KU
         SnAy3K8bmVg9zkSbBsqdM0puDPWXYPc2AtHhk=
MIME-Version: 1.0
Received: by 10.223.7.69 with SMTP id c5mr4948085fac.14.1266178596578; Sun, 14 
        Feb 2010 12:16:36 -0800 (PST)
In-Reply-To: <1265843569-5786-4-git-send-email-ddaney@caviumnetworks.com>
References: <4B733C71.8030304@caviumnetworks.com>
         <1265843569-5786-4-git-send-email-ddaney@caviumnetworks.com>
Date:   Sun, 14 Feb 2010 21:16:36 +0100
Message-ID: <f861ec6f1002141216t233fde34t1586bcd50dc051b4@mail.gmail.com>
Subject: Re: [PATCH 4/6] MIPS: Implement Read Inhibit/eXecute Inhibit
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi David,

this patch breaks my Alchemy builds:

  Using /mnt/data/_home/mano/db1200/kernel/linux-2.6.git as source for kernel
  GEN     /mnt/data/_home/mano/db1200/kernel/kbuild-linux-2.6.git/Makefile
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
  UPD     include/generated/utsrelease.h
  CC      arch/mips/kernel/asm-offsets.s
In file included from
/mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/io.h:25,
                 from
/mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/page.h:46,
                 from
/mnt/data/_home/mano/db1200/kernel/linux-2.6.git/include/linux/mm_types.h:15,
                 from
/mnt/data/_home/mano/db1200/kernel/linux-2.6.git/include/linux/sched.h:63,
                 from
/mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/kernel/asm-offsets.c:13:
/mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/pgtable-bits.h:
In function 'pte_to_entrylo':
/mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/pgtable-bits.h:146:
error: '_PAGE_NO_READ_SHIFT' undeclared (first use in this function)
/mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/pgtable-bits.h:146:
error: (Each undeclared identifier is reported only once
/mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/pgtable-bits.h:146:
error: for each function it appears in.)
/mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/pgtable-bits.h:155:
error: '_PAGE_GLOBAL_SHIFT' undeclared (first use in this function)
/mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/pgtable-bits.h:156:
error: '_PAGE_NO_EXEC' undeclared (first use in this function)
/mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/pgtable-bits.h:156:
error: '_PAGE_NO_READ' undeclared (first use in this function)
In file included from
/mnt/data/_home/mano/db1200/kernel/linux-2.6.git/include/linux/mm.h:39,
                 from
/mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/kernel/asm-offsets.c:14:
/mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/pgtable.h:
In function 'pte_modify':
/mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/include/asm/pgtable.h:351:
error: '_PFN_MASK' undeclared (first use in this function)
make[2]: *** [arch/mips/kernel/asm-offsets.s] Error 1
make[1]: *** [prepare0] Error 2
make: *** [sub-make] Error 2

Thanks!
      Manuel Lauss
