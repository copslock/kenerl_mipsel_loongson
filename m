Received:  by oss.sgi.com id <S553705AbQJZHMg>;
	Thu, 26 Oct 2000 00:12:36 -0700
Received: from mx.mips.com ([206.31.31.226]:24751 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553652AbQJZHMO>;
	Thu, 26 Oct 2000 00:12:14 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id AAA27194
	for <linux-mips@oss.sgi.com>; Thu, 26 Oct 2000 00:11:52 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA22618
	for <linux-mips@oss.sgi.com>; Thu, 26 Oct 2000 00:12:06 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id JAA03377
	for <linux-mips@oss.sgi.com>; Thu, 26 Oct 2000 09:10:52 +0200 (MET DST)
Message-ID: <39F7D8FB.84F9C4B3@mips.com>
Date:   Thu, 26 Oct 2000 09:10:51 +0200
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.6 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: [Fwd: Re: Atlas Board!]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing



-------- Original Message --------
Subject: Re: Atlas Board!
Date: Thu, 26 Oct 2000 09:09:16 +0200
From: Carsten Langgaard <carstenl@mips.com>
To: Nicu Popovici <octavp@isratech.ro>
References: <39F828B2.A662A568@isratech.ro>

Nicu Popovici wrote:

> Hello ,
>
> I want to ask few questions about an Atlas board. Who has such a board
> maybe will give me some tips to have an working Linux on that machine.
>
> 1. What type of RAM do I need ?

A PC100 SDRAM DIMM module up to a maximum of 128 Mbyte will be fine.
Make sure the module is capable of 2-cycle CAS latency, today most are.

>
> 2. I want to cross - compile the CVS linux kernel for Mips but I failed
> on a i686. Could anyone tell me if I try to compile the kernel on Atlas
> board I will  succeed.

You should be able to compile the kernel on the Atlas board, at least I
have been able to do it.

>
> Regards,
> Nicu

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
