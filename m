Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Aug 2011 03:46:08 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:59208 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492185Ab1HTBqE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Aug 2011 03:46:04 +0200
Received: by vws8 with SMTP id 8so3443401vws.36
        for <linux-mips@linux-mips.org>; Fri, 19 Aug 2011 18:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Y5MY7uFlUsF7cU+gi+fadL1m4+36R+GXBsOgUnW7tDw=;
        b=qwzyhLp7mIkHjELhX7xfbKVmtYjEuG0BHkdp1DOkaOPPpFxeSMvTgoXd+EjSqvgFOd
         pmdfn9PCCGseJUdXTRlu+SGecPWtRE20CMZhcoWnR0nPY3XGNd/tnkb5SQte0gQ2kmEU
         9N9ophps5571Z3I+UnVI3jd+rax64CW/doqkQ=
MIME-Version: 1.0
Received: by 10.52.98.2 with SMTP id ee2mr17920vdb.461.1313804758251; Fri, 19
 Aug 2011 18:45:58 -0700 (PDT)
Received: by 10.52.108.162 with HTTP; Fri, 19 Aug 2011 18:45:58 -0700 (PDT)
Date:   Sat, 20 Aug 2011 09:45:58 +0800
Message-ID: <CABjEo4Ugy1Cw895HrXYz4viwfVFb46aX45xfsDB2zfNHZzu65A@mail.gmail.com>
Subject: tlb load exception leads to system hanging during linux booting
From:   "wilbur.chan" <wilbur512@gmail.com>
To:     "Jayachandran C." <jayachandranc@netlogicmicro.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 30935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14866

Hi jayachandranc, sorry to bother you.

we are porting linux 2.6.32.41 smp onto xlp416 A2,but got some
problems when booting.
We found that , if configured the number of cpus with less that 12 ,
the linux went well, while when we
configured cpus with 16,  system would be verly likely to hang on
somewhere randomly.
In order to  find what happened, we added some code in timer interrupt
handler, to check that if each
cpu is still alive by kstat_irqs_cpu(7, cpu), and found that, when
system is abnormal, there would be one cpu with
interrupt disabled (kstat_irqs_cpu(7, cpu)  is not increaing).
So we send nmi ipi to the dead cpu, to dump the register and stack on
it. And we found out that, the reason for
hanging is cpu trap instruction:

1)
cpu2  nmi trigger! dump...
current running task:khelper on cpu2
epc   : ffffffffc10201b4 kernel_execve+0x4/0x30
ra    : ffffffffc1064398 ____call_usermodehelper+0x110/0x120
Status: 5448ffe7    KX SX UX KERNEL ERL EXL IE
Cause : 40009008
BadVA : 0000000000000000
ErroEPC : ffffffff80000180
Call Trace:
[<ffffffffc10201b4>] kernel_execve+0x4/0x30
[<ffffffffc1064398>] ____call_usermodehelper+0x110/0x120
[<ffffffffc101c598>] kernel_thread_helper+0x10/0x18


epc   ffffffffc10201b4 :       0000000c        syscall
error epc is ffffffff80000180,which is the address of except_vec3_generic.
extcode in cause is 2 , which indicate a TLB load exception


2)
cpu15  nmi trigger! dump...
current running task:init on cpu15
epc   : ffffffffc1077418 cmpxchg_futex_value_locked+0x88/0xc8
ra    : ffffffffc10773b0 cmpxchg_futex_value_locked+0x20/0xc8
Status: 5448ffe7    KX SX UX KERNEL ERL EXL IE
Cause : 40009008
BadVA : 000001b800000000
!!!!!!!!!!!!!!!ErroEPC : ffffffff80000184
Call Trace:
[<ffffffffc1077418>] cmpxchg_futex_value_locked+0x88/0xc8
[<ffffffffc1718790>] futex_init+0x18/0x90
[<ffffffffc100c908>] do_one_initcall+0x38/0x190
[<ffffffffc1710b64>] kernel_init+0x1ec/0x26c
[<ffffffffc101c510>] kernel_thread_helper+0x10/0x18


epc     ffffffffc1077418:       c2020000        ll      v0,0(s0)
error epc is ffffffff80000184,which is the second instruction in
except_vec3_generic.
extcode in cause is 2 , which also indicate a TLB load exception

cpu ebase is set with 0xffffffff80000000.

I guess this exception is caused by invalid setting of tlb or cache
initialization, but can't find exactly where the problem is.
Can you give some suggestion on how to figure it out? thanks in advance.
