Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Apr 2014 16:49:47 +0200 (CEST)
Received: from mail-we0-f174.google.com ([74.125.82.174]:34351 "EHLO
        mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816615AbaDGOto6LYVs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Apr 2014 16:49:44 +0200
Received: by mail-we0-f174.google.com with SMTP id t60so7016515wes.33
        for <linux-mips@linux-mips.org>; Mon, 07 Apr 2014 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RnSHQaEC5SvRwGuRQaYW521cZeX+0Z/D4PoTxK7xF3M=;
        b=i97gOLXv1hPStRuZFQ80ltqQ+t+OL4XnfA9pAKgdDdf8TTrDk0Rgj9JHIP+AhwaJzH
         o01I7R2HKAZTKMVqrcmIAxkrtz2a9nAUqoyHOm2pXz4baVevI9ZuEikq+zL9skyBwTwW
         a2EhfPcNI5zVbkXwmqWjYcrrKHM5NVAryf1iMczmyJ9eXIIMofsUesah8x4NZEoFRS4L
         wp9+FuoLcmmgG74v2jsqZzJxw+hNoO5FQG6arHZgSfkP9VxrJ0i21RhLWVL4Ki6wfMcj
         iD89fG1bbw9YcpzfrwXrWuf6K2cwi8dEY6PA0PRmd1Ij4byEkNeFE4uypouwW03W+td7
         aDZA==
X-Received: by 10.180.98.67 with SMTP id eg3mr5698933wib.38.1396882179575;
 Mon, 07 Apr 2014 07:49:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.216.148.136 with HTTP; Mon, 7 Apr 2014 07:48:58 -0700 (PDT)
In-Reply-To: <20140407135315.GX14803@pburton-linux.le.imgtec.org>
References: <1396868224-252888-1-git-send-email-manuel.lauss@gmail.com>
 <1396868224-252888-2-git-send-email-manuel.lauss@gmail.com> <20140407135315.GX14803@pburton-linux.le.imgtec.org>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Mon, 7 Apr 2014 16:48:58 +0200
Message-ID: <CAOLZvyEZvVQb-3UdXtZa3P8V+fckqT4aCUY9=aKrkdX_GNGc1g@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/2] MIPS: make FPU emulator optional
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Mon, Apr 7, 2014 at 3:53 PM, Paul Burton <paul.burton@imgtec.com> wrote:
> On Mon, Apr 07, 2014 at 12:57:04PM +0200, Manuel Lauss wrote:
>> This small patch makes the MIPS FPU emulator optional. The kernel
>> kills float-users on systems without a hardware FPU by sending a SIGILL.
>
> One issue with this is that if someone runs a kernel with the FPU
> emulator disabled on hardware that has an FPU, they're likely to hit
> seemingly odd behaviour where FP works just fine until they hit a
> condition the hardware doesn't support. To make it clear that using FP
> without the emulator is a bad idea, perhaps it would be safer to disable
> FP entirely rather than only the emulator? Then userland can die the
> first time it uses FP instead of when it happens to operate on a
> denormal.

Very good point, I understand.
How about this addon-patch?  I don't want to sprinkle the whole codebase
with #ifdef MIPS_FPU_SUPPORT lines.
Untested, since I don't have any hardware with FPU.


> Unless there are FPUs which never generate an unimplemented operation
> exception, in which case perhaps more Kconfig is needed to identify such
> systems & allow the emulator to be disabled for those only.

I'd rather keep the simple patch I sent, and maybe hide the option behind
CONFIG_EXPERT so only people who want to save space and know what
they're doing can disable it (e.g. OpenWRT).


diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3924396..52de5b8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2482,19 +2482,16 @@ config MIPS_O32_FP64_SUPPORT

          If unsure, say N.

-config MIPS_FPU_EMULATOR
-       bool "MIPS FPU Emulator"
+config MIPS_FPU_SUPPORT
+       bool "MIPS FPU Support"
        default y
        help
-         This option lets you disable the built-in MIPS FPU (Coprocessor 1)
-         emulator, which handles floating-point instructions on processors
-         without a hardware FPU.  It is generally a good idea to keep the
-         emulator built-in, unless you are perfectly sure you have a
-         complete soft-float environment.  With the emulator disabled, all
-         users of float operations will be killed with an illegal instr-
-         uction exception.
+         Enable support for floating point math, be it hardware FPU or the
+         kernels' FPU emulator.  With this option disabled, any user of
+         float math will be killed by illegal instruction exception,
+         regardless of the availability of hardware floating point support.

-         Say Y, please.
+         Say Y, unless you have a pure soft-float userspace.

 config USE_OF
        bool
diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
index c5203bb..ed68719 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -156,13 +156,14 @@ static inline int init_fpu(void)
        int ret = 0;

        preempt_disable();
-       if (cpu_has_fpu) {
-               ret = __own_fpu();
-               if (!ret)
-                       _init_fpu();
-       } else if (IS_ENABLED(CONFIG_MIPS_FPU_EMULATOR))
-               fpu_emulator_init_fpu();
-       else
+       if (IS_ENABLED(CONFIG_MIPS_FPU_SUPPORT)) {
+               if (cpu_has_fpu) {
+                       ret = __own_fpu();
+                       if (!ret)
+                               _init_fpu();
+               } else
+                       fpu_emulator_init_fpu();
+       } else
                ret = SIGILL;

        preempt_enable();


Thanks,
       Mano
