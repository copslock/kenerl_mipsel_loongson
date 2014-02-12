Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Feb 2014 10:39:14 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:40862 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823984AbaBLJjMbsMWe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 12 Feb 2014 10:39:12 +0100
Message-ID: <52FB413B.80902@imgtec.com>
Date:   Wed, 12 Feb 2014 09:39:07 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
MIME-Version: 1.0
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Subject: Re: [PATCH 0/8] Improved seccomp-bpf support for MIPS
References: <1390401604-11830-1-git-send-email-markos.chandras@imgtec.com> <CAP=VYLoNjfC8ZBgfLtCSv=s638p3faY-wm2cj2rn482KekyA7A@mail.gmail.com>
In-Reply-To: <CAP=VYLoNjfC8ZBgfLtCSv=s638p3faY-wm2cj2rn482KekyA7A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_02_12_09_39_07
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 02/12/2014 12:58 AM, Paul Gortmaker wrote:
> On Wed, Jan 22, 2014 at 9:39 AM, Markos Chandras
> <markos.chandras@imgtec.com> wrote:
>> Hi,
>>
>> This patch improves the existing seccomp-bpf support for MIPS.
>> It fixes a bug when copying system call arguments for the filter
>> checks and it also moves away from strict filtering to actually
>> use the filter supplied by the userspace process.
>
> Hi all,
>
> It seems this causes a build fail on linux-next allmodconfig.  I left
> a mindless "git bisect run .." go against it and it came up with:
> ----------------------------
> make[2]: *** [samples/seccomp/bpf-direct.o] Error 1
> make[1]: *** [samples/seccomp] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [vmlinux] Error 2
> 5c5df77172430c6377ec3434ce62f2b14a6799fc is the first bad commit
> commit 5c5df77172430c6377ec3434ce62f2b14a6799fc
> Author: Markos Chandras <markos.chandras@imgtec.com>
> Date:   Wed Jan 22 14:40:04 2014 +0000
>
>      MIPS: Select HAVE_ARCH_SECCOMP_FILTER
>
>      Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>      Reviewed-by: James Hogan <james.hogan@imgtec.com>
>      Reviewed-by: Paul Burton <paul.burton@imgtec.com>
>      Cc: linux-mips@linux-mips.org
>      Patchwork: https://patchwork.linux-mips.org/patch/6401/
>      Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> ---------------------
>
> The original linux-next fail is at:
>
> http://kisskb.ellerman.id.au/kisskb/buildresult/10601740/
>
> Paul.

Hi Paul,

I don't think this is caused by my patch. My patch just exposed it. To 
my understanding, the samples/seccomp are not meant to be 
cross-compiled. The tests use the host toolchain. However, when 
cross-compiling for MIPS, for example, __NR_write is only defined if

1) _MIPS_SIM == _MIPS_SIM_ABI64
2) _MIPS_SIM == _MIPS_SIM_ABI32
3) _MIPS_SIM == _MIPS_SIM_NABI32

which clearly makes no sense for the x86_64 toolchain. I would propose a 
fix like this in order to prevent test from being cross-compiled.

diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
index 7203e66..f3a018e 100644
--- a/samples/seccomp/Makefile
+++ b/samples/seccomp/Makefile
@@ -17,9 +17,9 @@ HOSTCFLAGS_bpf-direct.o += -I$(objtree)/usr/include
  HOSTCFLAGS_bpf-direct.o += -idirafter $(objtree)/include
  bpf-direct-objs := bpf-direct.o

+ifndef CROSS_COMPILE
  # Try to match the kernel target.
  ifndef CONFIG_64BIT
-ifndef CROSS_COMPILE

  # s390 has -m31 flag to build 31 bit binaries
  ifndef CONFIG_S390
@@ -36,7 +36,7 @@ HOSTLOADLIBES_bpf-direct += $(MFLAG)
  HOSTLOADLIBES_bpf-fancy += $(MFLAG)
  HOSTLOADLIBES_dropper += $(MFLAG)
  endif
-endif

  # Tell kbuild to always build the programs
  always := $(hostprogs-y)
+endif


-- 
markos
