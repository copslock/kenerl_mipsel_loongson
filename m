Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2003 21:33:04 +0100 (BST)
Received: from mms3.broadcom.com ([IPv6:::ffff:63.70.210.38]:7949 "EHLO
	mms3.broadcom.com") by linux-mips.org with ESMTP
	id <S8225215AbTF0UdC>; Fri, 27 Jun 2003 21:33:02 +0100
Received: from 63.70.210.1 by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (MMS v5.5.2)); Fri, 27 Jun 2003 13:32:50 -0700
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id NAA04108; Fri, 27 Jun 2003 13:32:19 -0700 (PDT)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 h5RKWeov001611; Fri, 27 Jun 2003 13:32:41 -0700 (PDT)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id NAA26397; Fri,
 27 Jun 2003 13:32:40 -0700
Message-ID: <3EFCA9E8.D08AAA3A@broadcom.com>
Date: Fri, 27 Jun 2003 13:32:40 -0700
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
References: <Pine.GSO.3.96.1030627214156.27044M-100000@delta.ds2.pg.gda.pl>
X-WSS-ID: 12E2767896805-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

"Maciej W. Rozycki" wrote:
> 
> On Fri, 27 Jun 2003 kwalker@linux-mips.org wrote:
> 
> > Modified files:
> >       arch/mips/lib  : memcpy.S
> >       arch/mips64/lib: memcpy.S
> >
> > Log message:
> >       fix bug in getting the thread's BUADDR in l_exc case
> 
>  There's still missing a load delay slot filler there.  I'm checking in an
> obvious fix immediately.

What about the other back-to-back loads in that file (9 lines above)? 
My CPU doesn't care about the load delay slot, so I didn't think to add
the nop.  At least my patch didn't introduce the problem ;-)

Kip
