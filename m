Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id PAA35408; Tue, 15 Jul 1997 15:17:46 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA07478 for linux-list; Tue, 15 Jul 1997 15:17:18 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA07386 for <linux@cthulhu.engr.sgi.com>; Tue, 15 Jul 1997 15:17:02 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA05718
	for <linux@cthulhu.engr.sgi.com>; Tue, 15 Jul 1997 15:16:57 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id AAA20071; Wed, 16 Jul 1997 00:15:04 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199707152215.AAA20071@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id AAA03529; Wed, 16 Jul 1997 00:15:16 +0200
Subject: Re: Fun with binutils ...
To: davem@jenolan.rutgers.edu (David S. Miller)
Date: Wed, 16 Jul 1997 00:15:15 +0200 (MET DST)
Cc: ralf@mailhost.uni-koblenz.de, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr
In-Reply-To: <199707151948.PAA08407@jenolan.rutgers.edu> from "David S. Miller" at Jul 15, 97 03:48:12 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>     - GAS still doesn't deal with _huge_ loops.  The only program I know
>       of which is affected is lmbench, but that alone is reason enough
>       to fix it :-)
> 
> It is not a bug, just that we have the local label semantics specified
> for linux-mips differently in gcc and gas.  I fixed this ages ago and
> it made lat_ctx.c compile just fine.

It has nothing to do with local label semantics of GCC; I can easily trigger
the problem in plain assembler using local or nonlocal labels.  Maybe you
were still using a non-PIC lat_ctx at that time?  The problem only affects 
PIC.  Another explanation would be that the size of the cacheflushing
loop in lmbench was somewhen increased or the GCC variant you used generates
different branches.  The problematic GAS code from:
binutils/gas/config/tc-mips.c:

[...]
  3439      case M_BGTL_I:
  3440        likely = 1;
  3441      case M_BGT_I:
[...]
  3470        if (imm_expr.X_op != O_constant)
  3471          as_bad ("Unsupported large constant");
[...]
  3536      case M_BGTUL_I:
  3537        likely = 1;
  3538      case M_BGTU_I:
[...]
  3544        if (imm_expr.X_op != O_constant)
  3545          as_bad ("Unsupported large constant");
[...]
  3632      case M_BLEL_I:
  3633        likely = 1;
  3634      case M_BLE_I:
[...]
  3647        if (imm_expr.X_op != O_constant)
  3648          as_bad ("Unsupported large constant");
[...]
  3694      case M_BLEUL_I:
  3695        likely = 1;
  3696      case M_BLEU_I:
[...]
  3702        if (imm_expr.X_op != O_constant)
  3703          as_bad ("Unsupported large constant");

  Ralf
