Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Apr 2018 23:24:50 +0200 (CEST)
Received: from mail-io0-x244.google.com ([IPv6:2607:f8b0:4001:c06::244]:39413
        "EHLO mail-io0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994591AbeDSVYoFRWRX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Apr 2018 23:24:44 +0200
Received: by mail-io0-x244.google.com with SMTP id v13-v6so8283279iob.6;
        Thu, 19 Apr 2018 14:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=TNNvxt/jOfO4nxX6IZlUGxBso8HHjDoce+ZhmRAVAks=;
        b=PwCk3/d0XN/9CJvxEtVZCncc6TXVB5Ck9UoYUwGq9aF3jhi3XQI5WRtjDEh/AkAjnu
         Ah9Yd6TGdet5bKWoA96u/mC4+9XBpFH+LaZrPeZPkGm26CV2HKek3oTeTMxlY+tkew+m
         WPaYCesfz5sRG82Z+q5CqrfqyYGeBNx0mk+4ntQ7xxpnDO7+Zsdjp/p5AOmajAqPYti1
         dzQxGc585mLsA3lTGt2tjo9tHLA99rCBFUj+URdOrYBQ5cjBerN02f0gs3tKfLQeHLzF
         WzGJGQG0sQHFBsnPleUL1PhGT4nmJLbXsFNm1yf2yzZ5Dzg76CPTAgsUWGBJ3oAHYn8d
         NBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=TNNvxt/jOfO4nxX6IZlUGxBso8HHjDoce+ZhmRAVAks=;
        b=PZT1yT9eS/FxHsyS8GpEs6vAI7NEwcheyQ3Jm69K5EjDWoKefMYZMtREzWhrf3Y7tA
         20gBYYh+Ejn4L9/MZq6x0Qb6GvwjImKujoSx8qiOXnq0QL1K+G9kLc/Px4zMAR/ljJy5
         SK9YrcoWytVzrnIEewfrx16r2Iq//n8aO1IqLwqrGqfU2ZrZf2fmomla8t0kRbxqhb1e
         G/Fq08sEoisG5nPP31AFCqKorUZLC6d4GW/U38Dn+qNzl7wHKKGgjl1ek6JbZNFzIQ5K
         4g0j7TTuC2sAbSaxPiJGtjqgbYzdtAyQsvlwOZIHZf3zYI3XHnehFo5G3adQe0U/ThfQ
         HvPw==
X-Gm-Message-State: ALQs6tCWmWEMjSn/obq/6xv8InPru1EeVJFCZba+pIpS8HwnAGi7XGHj
        yFoOohDFNMvqyzngu0NivSoTse0kgFTcizEBYoY=
X-Google-Smtp-Source: AB8JxZrhXLgdJ1+Jfq+pp9JoGaTu2YgiLLK1OoJtno7XhBLVHJyz7JVvJI3qt8ir5mfG9d6tFRBsjJzovpLtVgmOcBU=
X-Received: by 2002:a6b:2cc7:: with SMTP id s190-v6mr8473726ios.0.1524173077726;
 Thu, 19 Apr 2018 14:24:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:935b:0:0:0:0:0 with HTTP; Thu, 19 Apr 2018 14:24:36
 -0700 (PDT)
In-Reply-To: <CAK8P3a196QYoM1egagMuZw4WhiwRiO83Qpj0CxoCeVQBEaj-gw@mail.gmail.com>
References: <20180419143737.606138-1-arnd@arndb.de> <20180419143737.606138-2-arnd@arndb.de>
 <87efjbnswr.fsf@xmission.com> <CAK8P3a196QYoM1egagMuZw4WhiwRiO83Qpj0CxoCeVQBEaj-gw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 19 Apr 2018 23:24:36 +0200
X-Google-Sender-Auth: sfBM_45QNy4kZ-7Da423oVXWhFk
Message-ID: <CAK8P3a2KR+0ZE5jHSmO6pSuiRPH83p75KetuQuHL1atChcTJGA@mail.gmail.com>
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
X-archive-position: 63627
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

On Thu, Apr 19, 2018 at 5:20 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Apr 19, 2018 at 4:59 PM, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> I suspect you want to use __kernel_ulong_t here instead of a raw
>> unsigned long.  If nothing else it seems inconsistent to use typedefs
>> in one half of the structure and no typedefs in the other half.
>
> Good catch, there is definitely something wrong here, but I think using
> __kernel_ulong_t for all members would also be wrong, as that
> still changes the layout on x32, which effectively is
>
> struct msqid64_ds {
>      ipc64_perm msg_perm;
>      u64 msg_stime;
>      u32 __unused1;
>      /* 32 bit implict padding */
>      u64 msg_rtime;
>      u32 __unused2;
>      /* 32 bit implict padding */
>      u64 msg_ctime;
>      u32 __unused3;
>      /* 32 bit implict padding */
>      __kernel_pid_t          shm_cpid;       /* pid of creator */
>      __kernel_pid_t          shm_lpid;       /* pid of last operator */
>      ....
> };
>
> The choices here would be to either use a mix of
> __kernel_ulong_t and unsigned long, or taking the x32
> version back into arch/x86/include/uapi/asm/ so the
> generic version at least makes some sense.
>
> I can't use __kernel_time_t for the lower half on 32-bit
> since it really should be unsigned.

After thinking about it some more, I conclude that the structure is simply
incorrect on x32: The __kernel_ulong_t usage was introduced in 2013
in commit b9cd5ca22d67 ("uapi: Use __kernel_ulong_t in struct
msqid64_ds") and apparently was correct initially as __BITS_PER_LONG
evaluated to 64, but it broke with commit f4b4aae18288 ("x86/headers/uapi:
Fix __BITS_PER_LONG value for x32 builds") that changed the value
of __BITS_PER_LONG and introduced the extra padding in 2015.

The same change apparently also broke a lot of other definitions, e.g.

$ echo "#include <linux/types.h>" | gcc -mx32 -E -xc - | grep -A3
__kernel_size_t
typedef unsigned int __kernel_size_t;
typedef int __kernel_ssize_t;
typedef int __kernel_ptrdiff_t;

Those used to be defined as 'unsigned long long' and 'long long'
respectively, so now all kernel interfaces using those on x32
became incompatible!

       Arnd
