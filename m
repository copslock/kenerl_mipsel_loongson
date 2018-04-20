Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Apr 2018 09:58:40 +0200 (CEST)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:40169
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990424AbeDTH6cC5fgU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Apr 2018 09:58:32 +0200
Received: by mail-qk0-x244.google.com with SMTP id o64so8051658qkl.7;
        Fri, 20 Apr 2018 00:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=wp4ZumWAO4S4m00Wxjc05/8zWx7MRQmaV8jT3x+PC3M=;
        b=k37mhGlX3t9RDGBgioIzM7TBA1IpdSS6bzxZrZ9uzScwGSOmxVmxie+KxfjdZcXj6l
         UY9f7rwBrN3Oham0GerA9slTDv8t+HpG5e55eJcRMESrh6MsRVMZx1PpeHi6vH1InNcH
         cIuG8RQhAK11CG/zKY8x26/bzM1crlP8vOGTaZ1GFaewYRn6ehadWs/ZgXYvxL6jenEd
         j0JgnlyigtaflWLkIxklZPFvYr17zvUtKvgMPhG3fOR/nTqgSsexM4BdI+rgbmSrM+fh
         AxuHRj3VHX5j+VKINjHG9f68IbNhwR/W3xbKG/zMvBu3b37YQyvFPBCiH9GDjqz6cEgf
         rmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=wp4ZumWAO4S4m00Wxjc05/8zWx7MRQmaV8jT3x+PC3M=;
        b=pP051JTRDiG1kUXG5WLf0vsphRz2ErBwqupDbRzWRVq5LM/DRHFOjHeyBZk9OuFRye
         vjhjvVu4CRae8NWRSQSlOwZ4BMEJL0uox/lt/ArM8mqRHiNR+3VkUN4GBP6azvUr44lA
         meoeqhR8MSc53l4KqSdX/1K3P9oprYZZWgVNEnNgeUdoSPSXbOSqgTycF0xjmXDvsoJm
         X3q9X1EzU2l8TCk+LTWHChpW7a0Ct7Qg7oNn3wv03U3wEB/PSAs4bJ3zMdP2fcr7AcVI
         w2AsL+t52EDn18/sTplckHxVKtc9B1PwTlO+jJUHrAtr+X1Q8MPVkalZWb8V0nuM6zRJ
         9/5Q==
X-Gm-Message-State: ALQs6tAuIVTD/cyBe+srJauNM0B8cY/HlXrBG8v3Cy+IVw5LwMhoOfNG
        fjEMTHg9pqwnZcTH3aGSXRfudEwU5rHzB92zAV0=
X-Google-Smtp-Source: AB8JxZrRyZ6k002QS9Q1occohyKgpunn2fXCxVeCrcoLr1KtLtdkKWSVfze8QRo+8GFnEBnHRVkLV04/b5K3sp7pNkM=
X-Received: by 10.55.76.146 with SMTP id z140mr9967865qka.224.1524211104879;
 Fri, 20 Apr 2018 00:58:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.185.25 with HTTP; Fri, 20 Apr 2018 00:58:24 -0700 (PDT)
In-Reply-To: <20180420075407.GA7119@osiris>
References: <20180419143737.606138-1-arnd@arndb.de> <20180419143737.606138-5-arnd@arndb.de>
 <20180420075407.GA7119@osiris>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 20 Apr 2018 09:58:24 +0200
X-Google-Sender-Auth: eVOYssfyI36gGjjuqQplKA-NT7Y
Message-ID: <CAK8P3a1_TLs=QZuMVbbAGMEct+SBg2wZ663Kq2RJN5mgU1ZCtw@mail.gmail.com>
Subject: Re: [PATCH v3 04/17] y2038: s390: Remove unneeded ipc uapi header files
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Albert ARIBAUD <albert.aribaud@3adev.fr>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Fri, Apr 20, 2018 at 9:54 AM, Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
> On Thu, Apr 19, 2018 at 04:37:24PM +0200, Arnd Bergmann wrote:
>> The s390 msgbuf/sembuf/shmbuf header files are all identical to the
>> version from asm-generic.
>>
>> This patch removes the files and replaces them with 'generic-y'
>> statements, to avoid having to modify each copy when we extend sysvipc
>> to deal with 64-bit time_t in 32-bit user space.
>>
>> Note that unlike alpha and ia64, the ipcbuf.h header file is slightly
>> different here, so I'm leaving the private copy.
>>
>> To deal with 32-bit compat tasks, we also have to adapt the definitions
>> of compat_{shm,sem,msg}id_ds to match the changes to the respective
>> asm-generic files.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  arch/s390/include/asm/compat.h      | 32 ++++++++++++------------
>>  arch/s390/include/uapi/asm/Kbuild   |  3 +++
>>  arch/s390/include/uapi/asm/msgbuf.h | 38 ----------------------------
>>  arch/s390/include/uapi/asm/sembuf.h | 30 -----------------------
>>  arch/s390/include/uapi/asm/shmbuf.h | 49 -------------------------------------
>>  5 files changed, 19 insertions(+), 133 deletions(-)
>>  delete mode 100644 arch/s390/include/uapi/asm/msgbuf.h
>>  delete mode 100644 arch/s390/include/uapi/asm/sembuf.h
>>  delete mode 100644 arch/s390/include/uapi/asm/shmbuf.h
>
> FWIW,
>
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Thanks, added to the patch.

     Arnd
