Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2018 04:56:32 +0100 (CET)
Received: from mail-it0-x243.google.com ([IPv6:2607:f8b0:4001:c0b::243]:55489
        "EHLO mail-it0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990407AbeCND4ZyjpoI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Mar 2018 04:56:25 +0100
Received: by mail-it0-x243.google.com with SMTP id n136-v6so2783164itg.5;
        Tue, 13 Mar 2018 20:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JOUFevJyBQ5ypizLG1wQ82jzNwvVsTOW3QBDLsj5l/c=;
        b=KilrY6RCzhjA9qT14gdCXniXPSm9B/vYygQ+3XbX5nOrBP2dgqj6ZTlxbe6CHBObaf
         F6wMefTejIMZVKbx7EARDll6I62H8vizQ52/DnPeGXgIEZG4W2gFGrgaVWmf3KWWOvJF
         JrrnUdplyBHw5/eCbVw74LXdBifumlZnJ5rypCcWpjyAzpuT87JeATAEUrDrizzrQocw
         PDNxW6xc8r82YeeSEPUcgTbonKwx+HFZfBmXwGeNC7Tvpn8qvY1vidjmEi7Kh3sQ3o3z
         Y+dRM1SkQ6glrw3KjnJPQr2PfrbP9+A36Z/hEjFUVmCdQsys1n4uzy4pUEngbKlRsbUQ
         Hm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JOUFevJyBQ5ypizLG1wQ82jzNwvVsTOW3QBDLsj5l/c=;
        b=SwzpWxUTVnUDK1wXthrI6uIzyXQgbW/jCAR91xTIxoFK2puIO/BegHXlOPkEDZALxh
         iweWBUhvW8lKgSqrwrkgPQ0RgQNqaZiXaS9YWPGHajFayo5PCtpHJo+z8ii1dlYuASEG
         qrmJIK7BAU0bAk83mZFT/KvZa09n7SvRXEsuT2v2YguqtfLvW5u/GBEgnYl88phVfzd6
         UPfNW9I7XAJdYMwWQNWvA+L47VaEX2lxTi08iG24bC2izftwUanGiKBac8FVHtRF9ooq
         oVH/9HwAximelSRXVXWqQ3xLcpzzv5yl+NIBW8XLwj+w9UASyALu70dDcwD09f8chLjz
         0aPw==
X-Gm-Message-State: AElRT7E/tieVupmJZMSc2FsjiXfX6jeHj9TA7Fv6fuQPuLc5yNVUrDD0
        wvpBUTxyGmIrRPvYgy1/OqKs8I25wAJTFwFeHyc=
X-Google-Smtp-Source: AG47ELtAM9PZD/G707pnBMkXrN7JZDJfuXuK6tDs++5zpJCWZmOzctJpg3Th0ulDcIai73AxNg9YsBvet+rgu2YhtfQ=
X-Received: by 2002:a24:6f04:: with SMTP id x4-v6mr442407itb.51.1520999779532;
 Tue, 13 Mar 2018 20:56:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.232.26 with HTTP; Tue, 13 Mar 2018 20:56:19 -0700 (PDT)
In-Reply-To: <201803132351.1SZJ68nV%fengguang.wu@intel.com>
References: <20180312175307.11032-3-deepa.kernel@gmail.com> <201803132351.1SZJ68nV%fengguang.wu@intel.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Tue, 13 Mar 2018 20:56:19 -0700
Message-ID: <CABeXuvp617xkFgMDz8WR_=e6tj2d5LDpF56R-iXCOAqM=tdm+A@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] include: Move compat_timespec/ timeval to compat_time.h
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        devel@driverdev.osuosl.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Helge Deller <deller@gmx.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        sebott@linux.vnet.ibm.com,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Will Deacon <will.deacon@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, oprofile-list@lists.sf.net,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robert Richter <rric@kernel.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Peter Oberparleiter <oberpar@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>,
        gerald.schaefer@de.ibm.com,
        Parisc List <linux-parisc@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, cohuck@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <deepa.kernel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62968
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: deepa.kernel@gmail.com
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

This is again a tricky include file ordering when linux/compat.h is
included instead of asm/compat.h. is_compat_task() is unconditionally
defined in linux/compat.h as a macro which conflicts with inline
function define in asm/compat.h for this arch.
As before, I will do the simple thing here and leave the asm/compat.h
to keep this series simple.
I will submit follow up patches to eliminate direct inclusion asm/compat.h.

I will include this also in the update.

-Deepa

On Tue, Mar 13, 2018 at 8:30 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Deepa,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on ]
>
> url:    https://github.com/0day-ci/linux/commits/Deepa-Dinamani/posix_clocks-Prepare-syscalls-for-64-bit-time_t-conversion/20180313-203305
> base:
> config: powerpc-iss476-smp_defconfig (attached as .config)
> compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=powerpc
>
> All errors (new ones prefixed by >>):
>
>    arch/powerpc/oprofile/backtrace.c: In function 'user_getsp32':
>>> arch/powerpc/oprofile/backtrace.c:31:19: error: implicit declaration of function 'compat_ptr'; did you mean 'complete'? [-Werror=implicit-function-declaration]
>      void __user *p = compat_ptr(sp);
>                       ^~~~~~~~~~
>                       complete
>>> arch/powerpc/oprofile/backtrace.c:31:19: error: initialization makes pointer from integer without a cast [-Werror=int-conversion]
>    cc1: all warnings being treated as errors
>
> vim +31 arch/powerpc/oprofile/backtrace.c
>
> 6c6bd754 Brian Rogan 2006-03-27  27
> 6c6bd754 Brian Rogan 2006-03-27  28  static unsigned int user_getsp32(unsigned int sp, int is_first)
> 6c6bd754 Brian Rogan 2006-03-27  29  {
> 6c6bd754 Brian Rogan 2006-03-27  30     unsigned int stack_frame[2];
> 62034f03 Al Viro     2006-09-23 @31     void __user *p = compat_ptr(sp);
> 6c6bd754 Brian Rogan 2006-03-27  32
> 62034f03 Al Viro     2006-09-23  33     if (!access_ok(VERIFY_READ, p, sizeof(stack_frame)))
> 6c6bd754 Brian Rogan 2006-03-27  34             return 0;
> 6c6bd754 Brian Rogan 2006-03-27  35
> 6c6bd754 Brian Rogan 2006-03-27  36     /*
> 6c6bd754 Brian Rogan 2006-03-27  37      * The most likely reason for this is that we returned -EFAULT,
> 6c6bd754 Brian Rogan 2006-03-27  38      * which means that we've done all that we can do from
> 6c6bd754 Brian Rogan 2006-03-27  39      * interrupt context.
> 6c6bd754 Brian Rogan 2006-03-27  40      */
> 62034f03 Al Viro     2006-09-23  41     if (__copy_from_user_inatomic(stack_frame, p, sizeof(stack_frame)))
> 6c6bd754 Brian Rogan 2006-03-27  42             return 0;
> 6c6bd754 Brian Rogan 2006-03-27  43
> 6c6bd754 Brian Rogan 2006-03-27  44     if (!is_first)
> 6c6bd754 Brian Rogan 2006-03-27  45             oprofile_add_trace(STACK_LR32(stack_frame));
> 6c6bd754 Brian Rogan 2006-03-27  46
> 6c6bd754 Brian Rogan 2006-03-27  47     /*
> 6c6bd754 Brian Rogan 2006-03-27  48      * We do not enforce increasing stack addresses here because
> 6c6bd754 Brian Rogan 2006-03-27  49      * we may transition to a different stack, eg a signal handler.
> 6c6bd754 Brian Rogan 2006-03-27  50      */
> 6c6bd754 Brian Rogan 2006-03-27  51     return STACK_SP(stack_frame);
> 6c6bd754 Brian Rogan 2006-03-27  52  }
> 6c6bd754 Brian Rogan 2006-03-27  53
>
> :::::: The code at line 31 was first introduced by commit
> :::::: 62034f03380a64c0144b6721f4a2aa55d65346c1 [POWERPC] powerpc oprofile __user annotations
>
> :::::: TO: Al Viro <viro@ftp.linux.org.uk>
> :::::: CC: Paul Mackerras <paulus@samba.org>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
