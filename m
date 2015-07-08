Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jul 2015 09:02:33 +0200 (CEST)
Received: from mail-oi0-f41.google.com ([209.85.218.41]:34816 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009478AbbGHHCbqe8NL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Jul 2015 09:02:31 +0200
Received: by oihr66 with SMTP id r66so103313430oih.2
        for <linux-mips@linux-mips.org>; Wed, 08 Jul 2015 00:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zCpnqflIuc1gRBaiES/4lSn/nj6HgKH90eL+VveLNkk=;
        b=otCIjhksZ6WWmGlOS3UnhgArZFJdzjr0jXcVs+tfi7LbNEePIdN4IaOqcNTmPJ2RA7
         f735buX7Exe46g6mmSlYEJRBnIs1Kx2UrNXNf0AnF+fAs5t7ZnYVgLjS/mBXv3WH6ev8
         DjXM2wJoBwLaR5qLvRspOahf2yK0k7Fm5R8ag2Jn9wf8sWR0uiJvxWcMSCVbzK2CJxTy
         ON9K8sN8KrS/LtwKgwLJmT7R4jtTcJTL7GYzwG6LI4iUXjhndm/B+UHeQqhPZOqNQKBf
         VGkccrzZLgozfH3Hr+ExKe0i6RsideVgK0nouIXOHNSqTYM5iCIpVF5mw7bTdenzGKZ+
         /rWg==
MIME-Version: 1.0
X-Received: by 10.202.72.4 with SMTP id v4mr1215386oia.82.1436338945859; Wed,
 08 Jul 2015 00:02:25 -0700 (PDT)
Received: by 10.60.168.5 with HTTP; Wed, 8 Jul 2015 00:02:25 -0700 (PDT)
In-Reply-To: <20150708064607.GB7079@osiris>
References: <1436288623-13007-1-git-send-email-emunson@akamai.com>
        <1436288623-13007-3-git-send-email-emunson@akamai.com>
        <20150708064607.GB7079@osiris>
Date:   Wed, 8 Jul 2015 09:02:25 +0200
X-Google-Sender-Auth: vgROwd9gi1WQOCVKMrjq0QyXu08
Message-ID: <CAMuHMdUS72nYDo=chtcZMv-ZNVU0RhxvVLvMYvSFLtRk_wXrgw@mail.gmail.com>
Subject: Re: [PATCH V3 2/5] mm: mlock: Add new mlock, munlock, and munlockall
 system calls
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Eric B Munson <emunson@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Vlastimil Babka <vbabka@suse.cz>,
        alpha <linux-alpha@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        Cris <linux-cris-kernel@axis.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "moderated list:PANASONIC MN10300..." <linux-am33-list@redhat.com>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Wed, Jul 8, 2015 at 8:46 AM, Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
>> diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
>> index 1acad02..f6d81d6 100644
>> --- a/arch/s390/kernel/syscalls.S
>> +++ b/arch/s390/kernel/syscalls.S
>> @@ -363,3 +363,6 @@ SYSCALL(sys_bpf,compat_sys_bpf)
>>  SYSCALL(sys_s390_pci_mmio_write,compat_sys_s390_pci_mmio_write)
>>  SYSCALL(sys_s390_pci_mmio_read,compat_sys_s390_pci_mmio_read)
>>  SYSCALL(sys_execveat,compat_sys_execveat)
>> +SYSCALL(sys_mlock2,compat_sys_mlock2)                        /* 355 */
>> +SYSCALL(sys_munlock2,compat_sys_munlock2)
>> +SYSCALL(sys_munlockall2,compat_sys_munlockall2)
>
> FWIW, you would also need to add matching lines to the two files
>
> arch/s390/include/uapi/asm/unistd.h
> arch/s390/kernel/compat_wrapper.c
>
> so that the system call would be wired up on s390.

Similar comment for m68k:

arch/m68k/include/asm/unistd.h
arch/m68k/include/uapi/asm/unistd.h

I think you best look at the last commits that added system calls, for all
architectures, to make sure you don't do partial updates.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
