Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2JE7nH31733
	for linux-mips-outgoing; Mon, 19 Mar 2001 06:07:49 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2JE7mM31730
	for <linux-mips@oss.sgi.com>; Mon, 19 Mar 2001 06:07:48 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id GAA05551
	for <linux-mips@oss.sgi.com>; Mon, 19 Mar 2001 06:07:48 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA00622
	for <linux-mips@oss.sgi.com>; Mon, 19 Mar 2001 06:07:46 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id PAA02100
	for <linux-mips@oss.sgi.com>; Mon, 19 Mar 2001 15:07:15 +0100 (MET)
Message-ID: <3AB61293.5652407C@mips.com>
Date: Mon, 19 Mar 2001 15:07:15 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Bug in the _save_fp_context.
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I think there is a bug in the _save_fp_context function in
arch/mips/kernel/r4k_fpu.S

The problem is the following piece of code:

 jr ra
 .set nomacro
 EX(sw t0,SC_FPC_EIR(a0))
 nop
 .set macro

First of all what should the ".set nomacro" do?
If it means that the EX macro shouldn't be used then this entry wouldn't
get into __ex_table, which would be wrong.
But it look like it uses the macro anyway, regardless of the ".set
nomacro", at least with the compiler I use.
Never the less we do not handle entries in the __ex_table which is
located in a branch delay.
So we need to handle the situation where we take a page fault on an
instruction which is located in a brach delay slot, or we don't put the
"potential" faulting instruction in a delay slot.

Any ideas, how we should handle this in a nice and clean way?

/Carsten

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
