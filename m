Received:  by oss.sgi.com id <S42205AbQF1Hh6>;
	Wed, 28 Jun 2000 00:37:58 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:29794 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42201AbQF1Hhs>;
	Wed, 28 Jun 2000 00:37:48 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id AAA29078
	for <linux-mips@oss.sgi.com>; Wed, 28 Jun 2000 00:32:54 -0700 (PDT)
	mail_from (raiko@niisi.msk.ru)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA16949
	for <linux@engr.sgi.com>;
	Wed, 28 Jun 2000 00:37:21 -0700 (PDT)
	mail_from (raiko@niisi.msk.ru)
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA02650
	for <linux@engr.sgi.com>; Wed, 28 Jun 2000 00:37:11 -0700 (PDT)
	mail_from (raiko@niisi.msk.ru)
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id LAA26697;
	Wed, 28 Jun 2000 11:36:18 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id LAA32428; Wed, 28 Jun 2000 11:21:19 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id LAA10188; Wed, 28 Jun 2000 11:32:27 +0400 (MSD)
Message-ID: <3959ACC8.5C4CB127@niisi.msk.ru>
Date:   Wed, 28 Jun 2000 11:44:08 +0400
From:   "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.72 [en] (WinNT; I)
X-Accept-Language: en,ru
MIME-Version: 1.0
To:     Jun Sun <jsun@mvista.com>
CC:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: Re: argument mismatch in prom_init() for DDB5074?
References: <39596570.68939D9@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing



Jun Sun wrote:
> 
> I compiled an image for DDB5074.  I got a TLB fault immediately after
> the control enters prom_init() function.  A further probe shows that the
> caller are passing differents arguments to prom_init than what the
> callee expected.  See code excerpt below.

Most of the ports have the same mismatch. Usually, bios/prom/bootloader
calls the box independend routine, kernel_netry (head.S) with some
arguments. kernel_enry prepares C environment and calls init_arch w/ the
same arguments. The number of the arguments and their types are box
dependent. kernel_entry and init_arch never try to access the arguments
to be passed by prom, but just pass the arguments to prom_init.
Moreover, the arguments declared in init_arch don't match any mips box,
they are mix of calling conventions of ARC console and DECstation prom
(the last one).

Fortunately, sizeof(int) == sizeof(long) == sizeof(pointer) in mips32,
so we may happy live with that.

> 
> Does this mean the code of DDB5074 is outdated?  In any case, can
> someone give me a hint on how to fix this?  It does not look obvious at
> the first sight...
> 

I think, you shouldn't fix the argument list, continue bug searching in
other places.

Regards,
Gleb.
