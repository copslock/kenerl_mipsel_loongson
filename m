Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Apr 2018 17:20:41 +0200 (CEST)
Received: from mail-qt0-x22d.google.com ([IPv6:2607:f8b0:400d:c0d::22d]:46740
        "EHLO mail-qt0-x22d.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992821AbeDSPUfFtweB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Apr 2018 17:20:35 +0200
Received: by mail-qt0-x22d.google.com with SMTP id h4-v6so6120188qtn.13;
        Thu, 19 Apr 2018 08:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=NYguA8jYH//dgqip0jb2uvH/skODyyYlSWUMM7xZmW0=;
        b=TazQzDctNnEgbgTlfKdCzWonkECBpt6TDdgh08WNoeKlZOvddjO6S69V/4Gvt2Rzoc
         yuakpAkWz37UiaT5JP1pCMHKNcc2EVkBtNIXuOS0JqPQabyoAesfVNwksD+wLghTG5/u
         RsOs/2aylSJ2ocDImNUKrVXNkgM41+Kwik1FmED1pJY4u0f4SO0gPDwXOvgvCSNDpb3y
         pT97A4ttnmTY6bQHCzQnJSozsN2wQds4f4fVcWZxbeUt25fg23aDVNQQ6zYrN4Q68iQb
         9IYuP6uq9Utz4yvDKNEyZMtyxBBTDoBcINTrKTVzWF1p0/4UXwLHAx5z5fc6YubKWz20
         56yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=NYguA8jYH//dgqip0jb2uvH/skODyyYlSWUMM7xZmW0=;
        b=mwvzHGBTZAJl8jqyZOCt1IjwAInnSRzaXU7P0EU2zQzPxJtsyh/MSDqVqc4Egjv3vc
         GI9Ga2HVEdI2PfxB+pwASKahsTzcStsHiT2Qm96p/ZJ0B8DMTBCgTNQ6aK5r4UEgpLje
         67U46hU/l1LtzEaD5bJdOUHwtD7xLhs8EB/QaxbBfLR5ExgMFiY+BM8fclOprCtttmRJ
         g/biIGV2Y4Zhj/Kwb2Yep+qnr3/W/eQvyBXSDgY9l5TVCRprvO86StJkEa/Zi+cgAw8q
         L/qaz+AGkeooF0Mg5fMkXeYIx8OsAGQhD9fUtu4+soIPZKXp2K2nHx4VY1yl8IM9PrH+
         2Jpg==
X-Gm-Message-State: ALQs6tBVMA8/4fNMkxoIhpxNHO6VnjnBThHGm+KPG/dHAmjsQQtCWZSw
        oNs/1QzD7/TPMVx32DNopMj/QN//mB9StBNVxhg=
X-Google-Smtp-Source: AB8JxZrrZngmnrtPSk6mU3jvw75Zmlsqb9D0zZU0PNL7l1XQAxqeJp51o+E7zonRlr/9b9Gf4W/xtxh+42p/hno0yCA=
X-Received: by 2002:ac8:1c12:: with SMTP id a18-v6mr6690839qtk.280.1524151227466;
 Thu, 19 Apr 2018 08:20:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.185.25 with HTTP; Thu, 19 Apr 2018 08:20:26 -0700 (PDT)
In-Reply-To: <87efjbnswr.fsf@xmission.com>
References: <20180419143737.606138-1-arnd@arndb.de> <20180419143737.606138-2-arnd@arndb.de>
 <87efjbnswr.fsf@xmission.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 19 Apr 2018 17:20:26 +0200
X-Google-Sender-Auth: IR-EMjEf3Q0OPA5FsBjeRvhowTg
Message-ID: <CAK8P3a196QYoM1egagMuZw4WhiwRiO83Qpj0CxoCeVQBEaj-gw@mail.gmail.com>
Subject: Re: [PATCH v3 01/17] y2038: asm-generic: Extend sysvipc data structures
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
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
X-archive-position: 63623
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

On Thu, Apr 19, 2018 at 4:59 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
>>
>>  struct msqid64_ds {
>>       struct ipc64_perm msg_perm;
>> +#if __BITS_PER_LONG == 64
>>       __kernel_time_t msg_stime;      /* last msgsnd time */
>> -#if __BITS_PER_LONG != 64
>> -     unsigned long   __unused1;
>> -#endif
>>       __kernel_time_t msg_rtime;      /* last msgrcv time */
>> -#if __BITS_PER_LONG != 64
>> -     unsigned long   __unused2;
>> -#endif
>>       __kernel_time_t msg_ctime;      /* last change time */
>> -#if __BITS_PER_LONG != 64
>> -     unsigned long   __unused3;
>> +#else
>> +     unsigned long   msg_stime;      /* last msgsnd time */
>> +     unsigned long   msg_stime_high;
>> +     unsigned long   msg_rtime;      /* last msgrcv time */
>> +     unsigned long   msg_rtime_high;
>> +     unsigned long   msg_ctime;      /* last change time */
>> +     unsigned long   msg_ctime_high;
>>  #endif
>
> I suspect you want to use __kernel_ulong_t here instead of a raw
> unsigned long.  If nothing else it seems inconsistent to use typedefs
> in one half of the structure and no typedefs in the other half.

Good catch, there is definitely something wrong here, but I think using
__kernel_ulong_t for all members would also be wrong, as that
still changes the layout on x32, which effectively is

struct msqid64_ds {
     ipc64_perm msg_perm;
     u64 msg_stime;
     u32 __unused1;
     /* 32 bit implict padding */
     u64 msg_rtime;
     u32 __unused2;
     /* 32 bit implict padding */
     u64 msg_ctime;
     u32 __unused3;
     /* 32 bit implict padding */
     __kernel_pid_t          shm_cpid;       /* pid of creator */
     __kernel_pid_t          shm_lpid;       /* pid of last operator */
     ....
};

The choices here would be to either use a mix of
__kernel_ulong_t and unsigned long, or taking the x32
version back into arch/x86/include/uapi/asm/ so the
generic version at least makes some sense.

I can't use __kernel_time_t for the lower half on 32-bit
since it really should be unsigned.

        Arnd
