Received:  by oss.sgi.com id <S305165AbPLIINx>;
	Thu, 9 Dec 1999 00:13:53 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:3937 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305163AbPLIINl>;
	Thu, 9 Dec 1999 00:13:41 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id AAA14330; Thu, 9 Dec 1999 00:16:56 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA51521
	for linux-list;
	Thu, 9 Dec 1999 00:05:57 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA55808
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 9 Dec 1999 00:05:54 -0800 (PST)
	mail_from (carstenl@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA06349
	for <linux@cthulhu.engr.sgi.com>; Thu, 9 Dec 1999 00:05:53 -0800 (PST)
	mail_from (carstenl@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id AAA23669
	for <linux@cthulhu.engr.sgi.com>; Thu, 9 Dec 1999 00:05:52 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA26724
	for <linux@cthulhu.engr.sgi.com>; Thu, 9 Dec 1999 00:05:50 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id JAA00486
	for <linux@cthulhu.engr.sgi.com>; Thu, 9 Dec 1999 09:05:49 +0100 (MET)
Message-ID: <384F62DB.8DE09E3B@mips.com>
Date:   Thu, 09 Dec 1999 09:05:47 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; SunOS 5.6 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     sgi-mips <linux@cthulhu.engr.sgi.com>
Subject: Re: Exceptions
References: <384EDFC5.FFAE939A@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Jeff Harrell wrote:

> I have been working through the initialization code for the MIPS/Linux
> kernel and have traced through to the point
> where the MIPS exceptions are installed.  I have not been able to locate
> the following routines
>
>         handle_adel
>         handle_ades
>         handle_sys
>         handle_bp
>         handle_n
>         handle_cpu
>         handle_ov
>         handle_tr
>         handle_fpe
>
> I see where these are defined by "extern asmlinkage" references but
> can't locate the actual implementation of these
> exceptions.  Any idea what files these routines might be located in?
> Any help would be greatly appreciated

They are located in arch/mips/kernel/entry.S
They are a little hard to find as they use the BUILD_HANDLER macro to
extract the routines.

>
>
> Thank you,
> Jeff Harrell
>
> ---------8< excerpt from kernel/traps.c -----
>
>  set_except_vector(1, handle_mod);
>  set_except_vector(2, handle_tlbl);
>  set_except_vector(3, handle_tlbs);
>  set_except_vector(4, handle_adel);
>  set_except_vector(5, handle_ades);
>  /*
>   * The Data Bus Error/ Instruction Bus Errors are signaled
>   * by external hardware.  Therefore these two expection have
>   * board specific handlers.
>   */
>  set_except_vector(6, handle_ibe);
>  set_except_vector(7, handle_dbe);
>  ibe_board_handler = default_be_board_handler;
>  dbe_board_handler = default_be_board_handler;
>
>  set_except_vector(8, handle_sys);
>  set_except_vector(9, handle_bp);
>  set_except_vector(10, handle_ri);
>  set_except_vector(11, handle_cpu);
>  set_except_vector(12, handle_ov);
>  set_except_vector(13, handle_tr);
>  set_except_vector(15, handle_fpe);
>
> --
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Jeff Harrell                    Work:  (801) 619-6104
> Broadband Access group/TI
> jharrell@ti.com
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

--
_    _ ____  ___   Carsten Langgaard   mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 2B      Switch: +45 4486 5555
TECHNOLOGIES INC   2750 Ballerup       Fax...: +45 4486 5556
                   Denmark               http://www.mips.com
