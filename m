Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jun 2013 11:59:46 +0200 (CEST)
Received: from mail-ve0-f172.google.com ([209.85.128.172]:56773 "EHLO
        mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823036Ab3EGFrmGdRD4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 May 2013 07:47:42 +0200
Received: by mail-ve0-f172.google.com with SMTP id b10so152919vea.31
        for <multiple recipients>; Mon, 06 May 2013 22:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=mDlAnYHtLxmoweKXswjjISl88iOn0OPeWoUjqEmRShU=;
        b=U/efzdQmwPsxcrn1SnToVzcVtfEhKo7k7nzvS7KnQc1EMgZ8uMq9dpE7MK1LuXjVjk
         sKllsuElemcsEX2RnWXdBhKvH+4pd2lK5ba4S52kt2Yj5c6sRWZdcMS2x4i5BB2axugh
         2Ls4RuFuDkmtAdyhesjwJwMqSj/SQxt4cnmoaRtnGCveDqz1qqnGOAFl24XHccoANu9H
         P37u0kxFbpCEY5N6GdlVJhhfZeb+Tw34g1NEOGIwUbO7Qs6IFDHqhrkUgC/XDJNH630m
         f+2mDBLXjnYr4n5dqyu8At4429QKuoQ8nq1jCSC71HfA0+SDLZys74Rf3YgcC+GVo+9I
         aq9A==
MIME-Version: 1.0
X-Received: by 10.52.176.163 with SMTP id cj3mr260869vdc.35.1367905655550;
 Mon, 06 May 2013 22:47:35 -0700 (PDT)
Received: by 10.220.77.196 with HTTP; Mon, 6 May 2013 22:47:35 -0700 (PDT)
In-Reply-To: <CAOLZvyFo8OWD4qXDCQwJOWn0Hgs35XEF2pDppSbPt3Fnb3j9GQ@mail.gmail.com>
References: <CA+55aFwDGyHOzu=Qh7SJOBK6QvAwAh7pMDL6LfMUE=AW_kapAw@mail.gmail.com>
        <1367527692-25809-1-git-send-email-ddaney.cavm@gmail.com>
        <CAOLZvyFo8OWD4qXDCQwJOWn0Hgs35XEF2pDppSbPt3Fnb3j9GQ@mail.gmail.com>
Date:   Tue, 7 May 2013 14:47:35 +0900
Message-ID: <CAARg0FQ1XdFw0oy_rVkOVZke8XOx36WJH1=cR6X_WxKgkrjZXQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Enable interrupts before WAIT instruction.
From:   Eunbong Song <songeunbong@gmail.com>
To:     Manuel Lauss <manuel.lauss@gmail.com>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonas Gorski <jogo@openwrt.org>
Content-Type: multipart/alternative; boundary=bcaec5015d0faf78f104dc1a5ab8
Return-Path: <songeunbong@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37192
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: songeunbong@gmail.com
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

--bcaec5015d0faf78f104dc1a5ab8
Content-Type: text/plain; charset=ISO-8859-1

Hello. I  also tested with this patch.

[  124.661211] Checking for the daddi bug... no.
[  124.665737] ------------[ cut here ]------------
[  124.670187] WARNING: at kernel/cpu/idle.c:96
cpu_startup_entry+0x150/0x178()
[  124.677209] Modules linked in:
[  124.680251] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.9.0+ #40
[  124.686237] Stack : 0000000000000004 0000000000000034 ffffffff80fa0000
ffffffff80292558
          0000000000000000 ffffffff80fa0000 0000000000000001
ffffffff80293810
          0000000000000000 0000000000000000 ffffffff81080000
ffffffff81080000
          ffffffff80e2acf0 ffffffff80f8f977 ffffffff80f8fa80
ffffffff80e31730
          0000000000000001 0000000000000004 ffffffff00000000
0000000000000004
          ffffffffc05633f0 ffffffff806ef728 ffffffff80f57d08
ffffffff80290a74
          ffffffffc05633f0 ffffffff80293c40 000000000000003e
ffffffff80e2acf0
          0000000000000000 ffffffff80f57c30 00ffffff80f8fdc0
ffffffff802908c0
          0000000000000000 0000000000000000 0000000000000000
0000000000000000
          0000000000000000 ffffffff80272498 0000000000000000
0000000000000000
          ...
[  124.751163] Call Trace:
[  124.753599] [<ffffffff80272498>] show_stack+0x68/0x80
[  124.758634] [<ffffffff802908c0>] warn_slowpath_common+0x78/0xa8
[  124.764533] [<ffffffff802d4448>] cpu_startup_entry+0x150/0x178
[  124.770351] [<ffffffff80fd6b04>] start_kernel+0x440/0x45c
[  124.775728]
[  124.777219] ---[ end trace 9179e654e5693e72 ]---

But boot process is done. After boot process is done the follow error
message is printed periodically.


[  284.751007] INFO: rcu_preempt detected stalls on CPUs/tasks: { 6}
(detected by 1, t=14712 jiffies, g=18446744073709551344,
c=18446744073709551343, q=2437)
[  284.764878] Task dump for CPU 6:
[  284.768105] swapper/6       R  running task        0     0      1
0x00100000
[  284.775174] Stack : 0000005311112000 ffffffff80f60000 ffffffff80f60000
a800000001d2d950
          0000000000000018 ffffffff81080000 ffffffff81080000
0000000000000000
          ffffffff81010000 ffffffff8030893c 4256e5715da6083d
800000040f800000
          0000000000000018 ffffffff81080000 ffffffff81080000
ffffffff80264f3c
          ffffffff80e31730 0000000000000000 ffffffff80e31730
ffffffff80f90000
          ffffffff80fd0000 ffffffff8026c760 0000000000000000
0000000010008ce1
          0000000000100000 a8000000414e4010 ffffffff80f8bb18
0000000000000000
          0000005311112000 0000000000000001 0000000000000001
0000000000000000
          ffffffff80f8bc58 a800000001d32c60 a8000000414e7fe0
0000000000008c00
          a80000003f7d8000 0000000000000000 ffffffff80fd0000
ffffffff80e31730
          ...
[  284.840704] Call Trace:
[  284.843153] [<ffffffff806f1a48>] __schedule+0x3b0/0x938
[  284.848377]



After removing this patch, i only apply thomas gleixner's patch. I copied
that patch below.
It works well without any error message.


Index: linux-2.6/arch/mips/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/process.c
+++ linux-2.6/arch/mips/kernel/process.c
@@ -50,13 +50,18 @@ void arch_cpu_idle_dead(void)
 }
 #endif

-void arch_cpu_idle(void)
+static void smtc_idle_hook(void)
 {
 #ifdef CONFIG_MIPS_MT_SMTC
        extern void smtc_idle_loop_hook(void);
-
        smtc_idle_loop_hook();
 #endif
+}
+
+void arch_cpu_idle(void)
+{
+       local_irq_enable();
+       smtc_idle_hook();
        if (cpu_wait)
                (*cpu_wait)();
        else
--

Thanks


2013/5/6 Manuel Lauss <manuel.lauss@gmail.com>

> Hi David,
>
> On Thu, May 2, 2013 at 10:48 PM, David Daney <ddaney.cavm@gmail.com>
> wrote:
> > From: David Daney <david.daney@cavium.com>
> >
> > As noted by Thomas Gleixner:
> >
> >    commit cdbedc61c8 (mips: Use generic idle loop) broke MIPS as I did
> >    not realize that MIPS wants to invoke the wait instructions with
> >    interrupts enabled.
> >
> > Instead of enabling interrupts in arch_cpu_idle() as Thomas' initial
> > patch does, we follow Linus' suggestion of doing it in the assembly
> > code to prevent the compiler from rearranging things.
> >
> > Signed-off-by: David Daney <david.daney@cavium.com>
> > Reported-by: EunBong Song <eunb.song@samsung.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Jonas Gorski <jogo@openwrt.org>
> > ---
> >
> > This is only very lightly tested, we need more testing before
> > declaring it the definitive fix.
> >
> >  arch/mips/kernel/genex.S | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
>
> Unfortunately this patch doesn't work for me, system just hangs at
> certain points
> during kernel startup.  Reverting the patch above fixes it, but with
> this warning:
>
> ehci-platform ehci-platform.0: irq 98, io mem 0x14020000
> ------------[ cut here ]------------
> WARNING: at /home/mano/db1200/kernel/linux/kernel/cpu/idle.c:96
> cpu_startup_entry+0x138/0x184()
> CPU: 0 PID: 0 Comm: swapper Not tainted 3.9.0-db1235-10522-g6295a89 #2
> Stack : 00000000 00000000 809b4462 00000046 80929c20 00000000 808c6504
> 00000000
>           808c3428 80929b27 80929dc8 00000000 809b3c04 00000000
> 00000000 00000000
>           80093348 807d1000 2cb41780 8011f458 00000000 00000000
> 808c4a28 8091fe24
>           00000000 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000
>           00000000 00000000 00000000 00000000 00000000 00000000
> 00000000 8091fdb0
>           ...
> Call Trace:
> [<8010a1fc>] show_stack+0x64/0x7c
> [<8011f614>] warn_slowpath_common+0x70/0xa0
> [<8011f700>] warn_slowpath_null+0x18/0x28
> [<80150464>] cpu_startup_entry+0x138/0x184
> [<809658f0>] start_kernel+0x360/0x378
>
> ---[ end trace 19427144468f733d ]---
> ehci-platform ehci-platform.0: USB 2.0 started, EHCI 1.00
> hub 1-0:1.0: USB hub found
>
>
> Thanks,
>       Manuel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--bcaec5015d0faf78f104dc1a5ab8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello. I =A0also tested with this patch.=A0<div><div><br><=
div><div>[ =A0124.661211] Checking for the daddi bug... no.</div><div>[ =A0=
124.665737] ------------[ cut here ]------------</div>
<div>[ =A0124.670187] WARNING: at kernel/cpu/idle.c:96 cpu_startup_entry+0x=
150/0x178()</div><div>[ =A0124.677209] Modules linked in:</div><div>[ =A012=
4.680251] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.9.0+ #40</div><div>[ =
=A0124.686237] Stack : 0000000000000004 0000000000000034 ffffffff80fa0000 f=
fffffff80292558</div>

<div>=A0 =A0 =A0 =A0 =A0 0000000000000000 ffffffff80fa0000 0000000000000001=
 ffffffff80293810</div><div>=A0 =A0 =A0 =A0 =A0 0000000000000000 0000000000=
000000 ffffffff81080000 ffffffff81080000</div><div>=A0 =A0 =A0 =A0 =A0 ffff=
ffff80e2acf0 ffffffff80f8f977 ffffffff80f8fa80 ffffffff80e31730</div>

<div>=A0 =A0 =A0 =A0 =A0 0000000000000001 0000000000000004 ffffffff00000000=
 0000000000000004</div><div>=A0 =A0 =A0 =A0 =A0 ffffffffc05633f0 ffffffff80=
6ef728 ffffffff80f57d08 ffffffff80290a74</div><div>=A0 =A0 =A0 =A0 =A0 ffff=
ffffc05633f0 ffffffff80293c40 000000000000003e ffffffff80e2acf0</div>

<div>=A0 =A0 =A0 =A0 =A0 0000000000000000 ffffffff80f57c30 00ffffff80f8fdc0=
 ffffffff802908c0</div><div>=A0 =A0 =A0 =A0 =A0 0000000000000000 0000000000=
000000 0000000000000000 0000000000000000</div><div>=A0 =A0 =A0 =A0 =A0 0000=
000000000000 ffffffff80272498 0000000000000000 0000000000000000</div>

<div>=A0 =A0 =A0 =A0 =A0 ...</div><div>[ =A0124.751163] Call Trace:</div><d=
iv>[ =A0124.753599] [&lt;ffffffff80272498&gt;] show_stack+0x68/0x80</div><d=
iv>[ =A0124.758634] [&lt;ffffffff802908c0&gt;] warn_slowpath_common+0x78/0x=
a8</div><div>

[ =A0124.764533] [&lt;ffffffff802d4448&gt;] cpu_startup_entry+0x150/0x178</=
div><div>[ =A0124.770351] [&lt;ffffffff80fd6b04&gt;] start_kernel+0x440/0x4=
5c</div><div>[ =A0124.775728]</div><div>[ =A0124.777219] ---[ end trace 917=
9e654e5693e72 ]---</div>

</div></div><div><br></div><div>But boot process is done. After boot proces=
s is done the follow error message is printed periodically.</div><div><br><=
/div><div><br></div><div><div>[ =A0284.751007] INFO: rcu_preempt detected s=
talls on CPUs/tasks: { 6} (detected by 1, t=3D14712 jiffies, g=3D1844674407=
3709551344, c=3D18446744073709551343, q=3D2437)</div>

<div>[ =A0284.764878] Task dump for CPU 6:</div><div>[ =A0284.768105] swapp=
er/6 =A0 =A0 =A0 R =A0running task =A0 =A0 =A0 =A00 =A0 =A0 0 =A0 =A0 =A01 =
0x00100000</div><div>[ =A0284.775174] Stack : 0000005311112000 ffffffff80f6=
0000 ffffffff80f60000 a800000001d2d950</div>

<div>=A0 =A0 =A0 =A0 =A0 0000000000000018 ffffffff81080000 ffffffff81080000=
 0000000000000000</div><div>=A0 =A0 =A0 =A0 =A0 ffffffff81010000 ffffffff80=
30893c 4256e5715da6083d 800000040f800000</div><div>=A0 =A0 =A0 =A0 =A0 0000=
000000000018 ffffffff81080000 ffffffff81080000 ffffffff80264f3c</div>

<div>=A0 =A0 =A0 =A0 =A0 ffffffff80e31730 0000000000000000 ffffffff80e31730=
 ffffffff80f90000</div><div>=A0 =A0 =A0 =A0 =A0 ffffffff80fd0000 ffffffff80=
26c760 0000000000000000 0000000010008ce1</div><div>=A0 =A0 =A0 =A0 =A0 0000=
000000100000 a8000000414e4010 ffffffff80f8bb18 0000000000000000</div>

<div>=A0 =A0 =A0 =A0 =A0 0000005311112000 0000000000000001 0000000000000001=
 0000000000000000</div><div>=A0 =A0 =A0 =A0 =A0 ffffffff80f8bc58 a800000001=
d32c60 a8000000414e7fe0 0000000000008c00</div><div>=A0 =A0 =A0 =A0 =A0 a800=
00003f7d8000 0000000000000000 ffffffff80fd0000 ffffffff80e31730</div>

<div>=A0 =A0 =A0 =A0 =A0 ...</div><div>[ =A0284.840704] Call Trace:</div><d=
iv>[ =A0284.843153] [&lt;ffffffff806f1a48&gt;] __schedule+0x3b0/0x938</div>=
<div>[ =A0284.848377]</div><div><br></div><div style><br></div><div><br></d=
iv><div style>
<font face=3D"arial, sans-serif"><span style=3D"font-size:14px">After remov=
ing this patch, i only apply thomas gleixner&#39;s patch. I copied that pat=
ch below.=A0</span></font></div><div style><font face=3D"arial, sans-serif"=
><span style=3D"font-size:14px">It works well without any error message.=A0=
</span></font></div>
</div><div><br style=3D"font-family:arial,sans-serif;font-size:14px"><br st=
yle=3D"font-family:arial,sans-serif;font-size:14px"><span style=3D"font-fam=
ily:arial,sans-serif;font-size:14px">Index: linux-2.6/arch/mips/kernel/</sp=
an><span style=3D"font-family:arial,sans-serif;font-size:14px">process.c</s=
pan><br style=3D"font-family:arial,sans-serif;font-size:14px">
<span style=3D"font-family:arial,sans-serif;font-size:14px">=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</span><span style=3D"font-family:arial,sans-serif;font-size:14px">=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D</span><span style=3D"font-family:arial,sans-serif;font-size:14px"=
>=3D=3D=3D=3D=3D=3D=3D</span><br style=3D"font-family:arial,sans-serif;font=
-size:14px">
<span style=3D"font-family:arial,sans-serif;font-size:14px">--- linux-2.6.o=
rig/arch/mips/</span><span style=3D"font-family:arial,sans-serif;font-size:=
14px">kernel/process.c</span><br style=3D"font-family:arial,sans-serif;font=
-size:14px">
<span style=3D"font-family:arial,sans-serif;font-size:14px">+++ linux-2.6/a=
rch/mips/kernel/</span><span style=3D"font-family:arial,sans-serif;font-siz=
e:14px">process.c</span><br style=3D"font-family:arial,sans-serif;font-size=
:14px">
<span style=3D"font-family:arial,sans-serif;font-size:14px">@@ -50,13 +50,1=
8 @@ void arch_cpu_idle_dead(void)</span><br style=3D"font-family:arial,san=
s-serif;font-size:14px"><span style=3D"font-family:arial,sans-serif;font-si=
ze:14px">=A0}</span><br style=3D"font-family:arial,sans-serif;font-size:14p=
x">
<span style=3D"font-family:arial,sans-serif;font-size:14px">=A0#endif</span=
><br style=3D"font-family:arial,sans-serif;font-size:14px"><br style=3D"fon=
t-family:arial,sans-serif;font-size:14px"><span style=3D"font-family:arial,=
sans-serif;font-size:14px">-void arch_cpu_idle(void)</span><br style=3D"fon=
t-family:arial,sans-serif;font-size:14px">
<span style=3D"font-family:arial,sans-serif;font-size:14px">+static void sm=
tc_idle_hook(void)</span><br style=3D"font-family:arial,sans-serif;font-siz=
e:14px"><span style=3D"font-family:arial,sans-serif;font-size:14px">=A0{</s=
pan><br style=3D"font-family:arial,sans-serif;font-size:14px">
<span style=3D"font-family:arial,sans-serif;font-size:14px">=A0#ifdef CONFI=
G_MIPS_MT_SMTC</span><br style=3D"font-family:arial,sans-serif;font-size:14=
px"><span style=3D"font-family:arial,sans-serif;font-size:14px">=A0 =A0 =A0=
 =A0 extern void smtc_idle_loop_hook(void);</span><br style=3D"font-family:=
arial,sans-serif;font-size:14px">
<span style=3D"font-family:arial,sans-serif;font-size:14px">-</span><br sty=
le=3D"font-family:arial,sans-serif;font-size:14px"><span style=3D"font-fami=
ly:arial,sans-serif;font-size:14px">=A0 =A0 =A0 =A0 smtc_idle_loop_hook();<=
/span><br style=3D"font-family:arial,sans-serif;font-size:14px">
<span style=3D"font-family:arial,sans-serif;font-size:14px">=A0#endif</span=
><br style=3D"font-family:arial,sans-serif;font-size:14px"><span style=3D"f=
ont-family:arial,sans-serif;font-size:14px">+}</span><br style=3D"font-fami=
ly:arial,sans-serif;font-size:14px">
<span style=3D"font-family:arial,sans-serif;font-size:14px">+</span><br sty=
le=3D"font-family:arial,sans-serif;font-size:14px"><span style=3D"font-fami=
ly:arial,sans-serif;font-size:14px">+void arch_cpu_idle(void)</span><br sty=
le=3D"font-family:arial,sans-serif;font-size:14px">
<span style=3D"font-family:arial,sans-serif;font-size:14px">+{</span><br st=
yle=3D"font-family:arial,sans-serif;font-size:14px"><span style=3D"font-fam=
ily:arial,sans-serif;font-size:14px">+ =A0 =A0 =A0 local_irq_enable();</spa=
n><br style=3D"font-family:arial,sans-serif;font-size:14px">
<span style=3D"font-family:arial,sans-serif;font-size:14px">+ =A0 =A0 =A0 s=
mtc_idle_hook();</span><br style=3D"font-family:arial,sans-serif;font-size:=
14px"><span style=3D"font-family:arial,sans-serif;font-size:14px">=A0 =A0 =
=A0 =A0 if (cpu_wait)</span><br style=3D"font-family:arial,sans-serif;font-=
size:14px">
<span style=3D"font-family:arial,sans-serif;font-size:14px">=A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 (*cpu_wait)();</span><br style=3D"font-family:arial,sans-s=
erif;font-size:14px"><span style=3D"font-family:arial,sans-serif;font-size:=
14px">=A0 =A0 =A0 =A0 else</span><br style=3D"font-family:arial,sans-serif;=
font-size:14px">
<span style=3D"font-family:arial,sans-serif;font-size:14px">--</span><br></=
div></div><div><span style=3D"font-family:arial,sans-serif;font-size:14px">=
<br></span></div><div style><span style=3D"font-family:arial,sans-serif;fon=
t-size:14px">Thanks</span></div>
</div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">2013/5/=
6 Manuel Lauss <span dir=3D"ltr">&lt;<a href=3D"mailto:manuel.lauss@gmail.c=
om" target=3D"_blank">manuel.lauss@gmail.com</a>&gt;</span><br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">
Hi David,<br>
<div class=3D"im"><br>
On Thu, May 2, 2013 at 10:48 PM, David Daney &lt;<a href=3D"mailto:ddaney.c=
avm@gmail.com">ddaney.cavm@gmail.com</a>&gt; wrote:<br>
&gt; From: David Daney &lt;<a href=3D"mailto:david.daney@cavium.com">david.=
daney@cavium.com</a>&gt;<br>
&gt;<br>
&gt; As noted by Thomas Gleixner:<br>
&gt;<br>
&gt; =A0 =A0commit cdbedc61c8 (mips: Use generic idle loop) broke MIPS as I=
 did<br>
&gt; =A0 =A0not realize that MIPS wants to invoke the wait instructions wit=
h<br>
&gt; =A0 =A0interrupts enabled.<br>
&gt;<br>
&gt; Instead of enabling interrupts in arch_cpu_idle() as Thomas&#39; initi=
al<br>
&gt; patch does, we follow Linus&#39; suggestion of doing it in the assembl=
y<br>
&gt; code to prevent the compiler from rearranging things.<br>
&gt;<br>
&gt; Signed-off-by: David Daney &lt;<a href=3D"mailto:david.daney@cavium.co=
m">david.daney@cavium.com</a>&gt;<br>
&gt; Reported-by: EunBong Song &lt;<a href=3D"mailto:eunb.song@samsung.com"=
>eunb.song@samsung.com</a>&gt;<br>
&gt; Cc: Thomas Gleixner &lt;<a href=3D"mailto:tglx@linutronix.de">tglx@lin=
utronix.de</a>&gt;<br>
&gt; Cc: Jonas Gorski &lt;<a href=3D"mailto:jogo@openwrt.org">jogo@openwrt.=
org</a>&gt;<br>
&gt; ---<br>
&gt;<br>
&gt; This is only very lightly tested, we need more testing before<br>
&gt; declaring it the definitive fix.<br>
&gt;<br>
&gt; =A0arch/mips/kernel/genex.S | 7 ++++---<br>
&gt; =A01 file changed, 4 insertions(+), 3 deletions(-)<br>
<br>
</div>Unfortunately this patch doesn&#39;t work for me, system just hangs a=
t<br>
certain points<br>
during kernel startup. =A0Reverting the patch above fixes it, but with<br>
this warning:<br>
<br>
ehci-platform ehci-platform.0: irq 98, io mem 0x14020000<br>
------------[ cut here ]------------<br>
WARNING: at /home/mano/db1200/kernel/linux/kernel/cpu/idle.c:96<br>
cpu_startup_entry+0x138/0x184()<br>
CPU: 0 PID: 0 Comm: swapper Not tainted 3.9.0-db1235-10522-g6295a89 #2<br>
Stack : 00000000 00000000 809b4462 00000046 80929c20 00000000 808c6504 0000=
0000<br>
=A0 =A0 =A0 =A0 =A0 808c3428 80929b27 80929dc8 00000000 809b3c04 00000000<b=
r>
00000000 00000000<br>
=A0 =A0 =A0 =A0 =A0 80093348 807d1000 2cb41780 8011f458 00000000 00000000<b=
r>
808c4a28 8091fe24<br>
=A0 =A0 =A0 =A0 =A0 00000000 00000000 00000000 00000000 00000000 00000000<b=
r>
00000000 00000000<br>
=A0 =A0 =A0 =A0 =A0 00000000 00000000 00000000 00000000 00000000 00000000<b=
r>
00000000 8091fdb0<br>
=A0 =A0 =A0 =A0 =A0 ...<br>
Call Trace:<br>
[&lt;8010a1fc&gt;] show_stack+0x64/0x7c<br>
[&lt;8011f614&gt;] warn_slowpath_common+0x70/0xa0<br>
[&lt;8011f700&gt;] warn_slowpath_null+0x18/0x28<br>
[&lt;80150464&gt;] cpu_startup_entry+0x138/0x184<br>
[&lt;809658f0&gt;] start_kernel+0x360/0x378<br>
<br>
---[ end trace 19427144468f733d ]---<br>
ehci-platform ehci-platform.0: USB 2.0 started, EHCI 1.00<br>
hub 1-0:1.0: USB hub found<br>
<br>
<br>
Thanks,<br>
=A0 =A0 =A0 Manuel<br>
<div class=3D"HOEnZb"><div class=3D"h5">--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-kernel=
&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
Please read the FAQ at =A0<a href=3D"http://www.tux.org/lkml/" target=3D"_b=
lank">http://www.tux.org/lkml/</a><br>
</div></div></blockquote></div><br></div>

--bcaec5015d0faf78f104dc1a5ab8--
