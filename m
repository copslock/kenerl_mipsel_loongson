Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2003 16:28:28 +0100 (BST)
Received: from mms3.broadcom.com ([IPv6:::ffff:63.70.210.38]:6405 "EHLO
	mms3.broadcom.com") by linux-mips.org with ESMTP
	id <S8225220AbTDYP21>; Fri, 25 Apr 2003 16:28:27 +0100
Received: from 63.70.210.1 by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (MMS v5.5.2)); Fri, 25 Apr 2003 08:28:30 -0700
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id IAA26698 for <linux-mips@linux-mips.org>; Fri, 25 Apr 2003 08:28:05
 -0700 (PDT)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.4/SSF) with ESMTP id
 h3PFSMml016261 for <linux-mips@linux-mips.org>; Fri, 25 Apr 2003 08:28:
 22 -0700 (PDT)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id IAA05104 for
 <linux-mips@linux-mips.org>; Fri, 25 Apr 2003 08:28:22 -0700
Message-ID: <3EA95416.BD37F40@broadcom.com>
Date: Fri, 25 Apr 2003 08:28:22 -0700
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: [pathch] kernel/sched.c bogon?
References: <3E67EF64.152CFC6C@broadcom.com>
X-WSS-ID: 12B78B942221439-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips


Ralf?  I'm tying up loose ends between my tree and yours, and hoping to
push some things back.

Kip Walker wrote:
> 
> The comparisons of oldest_idle below trigger compiler warnings and
> should probably be safely type-cast:
> 
> Kip
> 
> Index: kernel/sched.c
> ===================================================================
> RCS file: /home/cvs/linux/kernel/sched.c,v
> retrieving revision 1.64.2.6
> diff -u -r1.64.2.6 sched.c
> --- kernel/sched.c      25 Feb 2003 22:03:13 -0000      1.64.2.6
> +++ kernel/sched.c      7 Mar 2003 00:57:35 -0000
> @@ -282,7 +282,7 @@
>                                 target_tsk = tsk;
>                         }
>                 } else {
> -                       if (oldest_idle == -1ULL) {
> +                       if (oldest_idle == (cycles_t) -1) {
>                                 int prio = preemption_goodness(tsk, p,
> cpu);
> 
>                                 if (prio > max_prio) {
> @@ -294,7 +294,7 @@
>         }
>         tsk = target_tsk;
>         if (tsk) {
> -               if (oldest_idle != -1ULL) {
> +               if (oldest_idle != (cycles_t) -1) {
>                         best_cpu = tsk->processor;
>                         goto send_now_idle;
>                 }
