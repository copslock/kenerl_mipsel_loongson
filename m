Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Feb 2014 16:30:50 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:47182 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816503AbaBLPapG51da (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Feb 2014 16:30:45 +0100
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s1CFUQVv004619
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 12 Feb 2014 07:30:26 -0800 (PST)
Received: from [128.224.146.65] (128.224.146.65) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.2.347.0; Wed, 12 Feb 2014
 07:30:25 -0800
Message-ID: <52FB93BC.8080909@windriver.com>
Date:   Wed, 12 Feb 2014 10:31:08 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Markos Chandras <Markos.Chandras@imgtec.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Subject: Re: [PATCH 0/8] Improved seccomp-bpf support for MIPS
References: <1390401604-11830-1-git-send-email-markos.chandras@imgtec.com> <CAP=VYLoNjfC8ZBgfLtCSv=s638p3faY-wm2cj2rn482KekyA7A@mail.gmail.com> <52FB413B.80902@imgtec.com>
In-Reply-To: <52FB413B.80902@imgtec.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.146.65]
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39281
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

On 14-02-12 04:39 AM, Markos Chandras wrote:
> On 02/12/2014 12:58 AM, Paul Gortmaker wrote:
>> On Wed, Jan 22, 2014 at 9:39 AM, Markos Chandras
>> <markos.chandras@imgtec.com> wrote:
>>> Hi,
>>>
>>> This patch improves the existing seccomp-bpf support for MIPS.
>>> It fixes a bug when copying system call arguments for the filter
>>> checks and it also moves away from strict filtering to actually
>>> use the filter supplied by the userspace process.
>>
>> Hi all,
>>
>> It seems this causes a build fail on linux-next allmodconfig.  I left
>> a mindless "git bisect run .." go against it and it came up with:
>> ----------------------------
>> make[2]: *** [samples/seccomp/bpf-direct.o] Error 1
>> make[1]: *** [samples/seccomp] Error 2
>> make[1]: *** Waiting for unfinished jobs....
>> make: *** [vmlinux] Error 2
>> 5c5df77172430c6377ec3434ce62f2b14a6799fc is the first bad commit
>> commit 5c5df77172430c6377ec3434ce62f2b14a6799fc
>> Author: Markos Chandras <markos.chandras@imgtec.com>
>> Date:   Wed Jan 22 14:40:04 2014 +0000
>>
>>      MIPS: Select HAVE_ARCH_SECCOMP_FILTER
>>
>>      Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>>      Reviewed-by: James Hogan <james.hogan@imgtec.com>
>>      Reviewed-by: Paul Burton <paul.burton@imgtec.com>
>>      Cc: linux-mips@linux-mips.org
>>      Patchwork: https://patchwork.linux-mips.org/patch/6401/
>>      Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>> ---------------------
>>
>> The original linux-next fail is at:
>>
>> http://kisskb.ellerman.id.au/kisskb/buildresult/10601740/
>>
>> Paul.
> 
> Hi Paul,
> 
> I don't think this is caused by my patch. My patch just exposed it. To

Ha, well that is one and the same thing for all intents and purposes.

Would you please formalize your patch below and put it in your
queue, in advance of the patch(es) that cause/trigger the breakage?

That way we won't be introducing a build bisection failure into the
permanent git history.

Thanks,
Paul.
--

> my understanding, the samples/seccomp are not meant to be 
> cross-compiled. The tests use the host toolchain. However, when 
> cross-compiling for MIPS, for example, __NR_write is only defined if
> 
> 1) _MIPS_SIM == _MIPS_SIM_ABI64
> 2) _MIPS_SIM == _MIPS_SIM_ABI32
> 3) _MIPS_SIM == _MIPS_SIM_NABI32
> 
> which clearly makes no sense for the x86_64 toolchain. I would propose a 
> fix like this in order to prevent test from being cross-compiled.
> 
> diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
> index 7203e66..f3a018e 100644
> --- a/samples/seccomp/Makefile
> +++ b/samples/seccomp/Makefile
> @@ -17,9 +17,9 @@ HOSTCFLAGS_bpf-direct.o += -I$(objtree)/usr/include
>   HOSTCFLAGS_bpf-direct.o += -idirafter $(objtree)/include
>   bpf-direct-objs := bpf-direct.o
> 
> +ifndef CROSS_COMPILE
>   # Try to match the kernel target.
>   ifndef CONFIG_64BIT
> -ifndef CROSS_COMPILE
> 
>   # s390 has -m31 flag to build 31 bit binaries
>   ifndef CONFIG_S390
> @@ -36,7 +36,7 @@ HOSTLOADLIBES_bpf-direct += $(MFLAG)
>   HOSTLOADLIBES_bpf-fancy += $(MFLAG)
>   HOSTLOADLIBES_dropper += $(MFLAG)
>   endif
> -endif
> 
>   # Tell kbuild to always build the programs
>   always := $(hostprogs-y)
> +endif
> 
> 
