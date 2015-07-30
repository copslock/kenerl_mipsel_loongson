Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jul 2015 17:32:24 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:60495 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011420AbbG3PcW4vl3e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Jul 2015 17:32:22 +0200
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail.windriver.com (8.15.1/8.15.1) with ESMTPS id t6UFW6Pe027745
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 30 Jul 2015 08:32:06 -0700 (PDT)
Received: from [128.224.56.57] (128.224.56.57) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.3.235.1; Thu, 30 Jul 2015
 08:31:47 -0700
Message-ID: <55BA4375.7010400@windriver.com>
Date:   Thu, 30 Jul 2015 11:32:05 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     David Herrmann <dh.herrmann@gmail.com>
CC:     David Herrmann <dh.herrmann@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Mack <daniel@zonque.org>,
        Djalal Harouni <tixxdz@opendz.org>,
        <linux-mips@linux-mips.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Subject: Re: samples/kdbus/kdbus-workers.c and cross compiling MIPS
References: <20150729161912.GF18685@windriver.com>      <CANq1E4TgWK-8JkUtOYfTOL9Dx=jWeVpA-h881TXSA3BNjp+MPw@mail.gmail.com>    <55BA2B91.5070107@windriver.com> <CANq1E4S7awCfPaNduoG8ENHmnGhR7-VT-9LvGwREZs-h8zNmzQ@mail.gmail.com>
In-Reply-To: <CANq1E4S7awCfPaNduoG8ENHmnGhR7-VT-9LvGwREZs-h8zNmzQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [128.224.56.57]
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

On 2015-07-30 10:23 AM, David Herrmann wrote:
> Hi
> 
> On Thu, Jul 30, 2015 at 3:50 PM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
>> On 2015-07-29 12:31 PM, David Herrmann wrote:
>>> Hi
>>>
>>> On Wed, Jul 29, 2015 at 6:19 PM, Paul Gortmaker
>>> <paul.gortmaker@windriver.com> wrote:
>>>> Hi David,
>>>>
>>>> Does it make sense to build this sample when cross compiling?
>>>>
>>>> The reason I ask is that it has been breaking the linux-next build of
>>>> allmodconfig for a while now, with:
>>>>
>>>>   HOSTCC  samples/kdbus/kdbus-workers
>>>> samples/kdbus/kdbus-workers.c: In function ‘prime_new’:
>>>> samples/kdbus/kdbus-workers.c:934:18: error: ‘__NR_memfd_create’ undeclared (first use in this function)
>>>>   p->fd = syscall(__NR_memfd_create, "prime-area", MFD_CLOEXEC);
>>>>                   ^
>>>> samples/kdbus/kdbus-workers.c:934:18: note: each undeclared identifier is reported only once for each function it appears in
>>>> scripts/Makefile.host:91: recipe for target 'samples/kdbus/kdbus-workers' failed
>>>> make[2]: *** [samples/kdbus/kdbus-workers] Error 1
>>>
>>> mips does have this syscall, so I assume the problem is out-of-date
>>> kernel headers. You can fix this by running:
>>>
>>>     $ make headers_install
>>
>> No, let me try and clarify. Please note the emphasis on cross compiling
>> and automated build coverage, i.e. there is no place for manual steps.
> 
> User-space samples in ./samples/ are compiled with HOSTCC, which is
> the compiler for the _local_ machine. Regardless of cross-compiling
> the same local compiler is used. So I cannot understand why this is
> even remotely related to cross compiling. Please elaborate.

Well, it only shows up when we cross compile for mips.  It does not
seem to be showing up for any other arch (and we cover ~10 of them).
Nor does it show up for x86 builds.  Also note that the main linux-next
build machine is actually a PowerPC host.

> Please note that this is HOSTCC running, so it does *NOT* require the
> toolchain for your cross-compiled architecture.
> 
> Also, please tell me why your system has "linux/memfd.h" available,
> but __NR_memfd_create is undefined?

My local system is a bog standard ubuntu 14.10 and it sees it.  I dont
know what distro the linux-next IBM powerpc builder is based on but it
also sees it....

Here is what V=1 output looks like:

(cat /dev/null; ) > samples/kdbus/modules.order
  gcc -Wp,-MD,samples/kdbus/.kdbus-workers.d -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu89    -I./usr/include -o samples/kdbus/kdbus-workers samples/kdbus/kdbus-workers.c  -lrt
samples/kdbus/kdbus-workers.c: In function ‘prime_new’:
samples/kdbus/kdbus-workers.c:934:18: error: ‘__NR_memfd_create’ undeclared (first use in this function)
  p->fd = syscall(__NR_memfd_create, "prime-area", MFD_CLOEXEC);
                  ^
samples/kdbus/kdbus-workers.c:934:18: note: each undeclared identifier is reported only once for each function it appears in
scripts/Makefile.host:91: recipe for target 'samples/kdbus/kdbus-workers' failed
make[2]: *** [samples/kdbus/kdbus-workers] Error 1
scripts/Makefile.build:403: recipe for target 'samples/kdbus' failed
make[1]: *** [samples/kdbus] Error 2
Makefile:1569: recipe for target 'samples/' failed
make: *** [samples/] Error 2

and here is what is in ./usr/include:

paul@yow-lpgnfs-02:~/git/linux-head$ grep -R __NR_memfd_create ./usr/include/
./usr/include/asm-generic/unistd.h:#define __NR_memfd_create 279
./usr/include/asm-generic/unistd.h:__SYSCALL(__NR_memfd_create, sys_memfd_create)
./usr/include/asm/unistd.h:#define __NR_memfd_create            (__NR_Linux + 354)
./usr/include/asm/unistd.h:#define __NR_memfd_create            (__NR_Linux + 314)
./usr/include/asm/unistd.h:#define __NR_memfd_create            (__NR_Linux + 318)
paul@yow-lpgnfs-02:~/git/linux-head$ 

..so it is in there, but presumably something wrt mips ifdeffery
means it is thrown out by cpp.

> 
> Anyway, patch is attached. Can you verify it works?

Yes, after I fixed up the mangling from it being sent as
quoted-printable, it fixes the issue; or at least avoids it.

Tested-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Thanks,
Paul.
--

> David
> 
> diff --git a/samples/kdbus/Makefile b/samples/kdbus/Makefile
> index 137f842..dbd9de8 100644
> --- a/samples/kdbus/Makefile
> +++ b/samples/kdbus/Makefile
> @@ -1,9 +1,13 @@
>  # kbuild trick to avoid linker error. Can be omitted if a module is built.
>  obj- := dummy.o
> 
> +ifndef CROSS_COMPILE
> +
>  hostprogs-$(CONFIG_SAMPLE_KDBUS) += kdbus-workers
> 
>  always := $(hostprogs-y)
> 
>  HOSTCFLAGS_kdbus-workers.o += -I$(objtree)/usr/include
>  HOSTLOADLIBES_kdbus-workers := -lrt
> +
> +endif
> 
