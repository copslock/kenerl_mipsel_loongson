Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2003 15:49:50 +0100 (BST)
Received: from mms3.broadcom.com ([IPv6:::ffff:63.70.210.38]:59652 "EHLO
	mms3.broadcom.com") by linux-mips.org with ESMTP
	id <S8225479AbTI3Otp>; Tue, 30 Sep 2003 15:49:45 +0100
Received: from 63.70.210.1 by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (MMS v5.5.3)); Tue, 30 Sep 2003 07:49:43 -0700
Received: from mail-sj1-1.sj.broadcom.com (mail-sj1-1.sj.broadcom.com
 [10.16.128.231]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id HAA07119; Tue, 30 Sep 2003 07:49:03 -0700 (PDT)
Received: from broadcom.com (ldt-sj3-158 [10.21.64.158]) by
 mail-sj1-1.sj.broadcom.com (8.12.9/8.12.4/SSM) with ESMTP id
 h8UEnVKX021119; Tue, 30 Sep 2003 07:49:31 -0700 (PDT)
Message-ID: <3F7997FB.7159F7A@broadcom.com>
Date: Tue, 30 Sep 2003 07:49:31 -0700
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-18.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Finney, Steve" <Steve.Finney@spirentcom.com>
cc: "Michael Uhler" <uhler@mips.com>, linux-mips@linux-mips.org
Subject: Re: 64 bit operations w/32 bit kernel
References: <DC1BF43A8FAE654DA6B3FB7836DD3A56DEB75C@iris.adtech-inc.com>
 <1064862114.11818.21.camel@uhler-linux.mips.com>
X-WSS-ID: 1367478D1895670-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

Michael Uhler wrote:
> 
> On Mon, 2003-09-29 at 10:31, Finney, Steve wrote:
> > What would be the downside to enabling 64 bit operations in user space on a 32 bit kernel (setting the PX bit in the status register?). The particular issue is that I want to access 64 bit-memory mapped registers, and I really need to do it as an atomic operation. I tried borrowing sibyte/64bit.h from the kernel, but I get an illegal instruction on the double ops.
> >
> The most glaring problem is you violate the rule that the 64-bit GPRs
> are sign-extended when running a 32-bit binary.  There are all kinds
> of assumptions in the hardware and software that depend on the
> GPRs being sign-extended, and to violate this will risk some
> serious instability of the software.

Not to mention that the kernel won't preserve the upper 32 bits across
interrupts and system calls, if you even manage to get 64-bit values in
the registers in the first place.

Kip
