Received:  by oss.sgi.com id <S553719AbQLMRGd>;
	Wed, 13 Dec 2000 09:06:33 -0800
Received: from jester.ti.com ([192.94.94.1]:28824 "EHLO jester.ti.com")
	by oss.sgi.com with ESMTP id <S553671AbQLMRGH>;
	Wed, 13 Dec 2000 09:06:07 -0800
Received: from dlep7.itg.ti.com ([157.170.134.103])
	by jester.ti.com (8.11.1/8.11.1) with ESMTP id eBDH61923339;
	Wed, 13 Dec 2000 11:06:01 -0600 (CST)
Received: from dlep7.itg.ti.com (localhost [127.0.0.1])
	by dlep7.itg.ti.com (8.9.3/8.9.3) with ESMTP id LAA00569;
	Wed, 13 Dec 2000 11:06:01 -0600 (CST)
Received: from dlep3.itg.ti.com (dlep3-maint.itg.ti.com [157.170.133.16])
	by dlep7.itg.ti.com (8.9.3/8.9.3) with ESMTP id LAA00555;
	Wed, 13 Dec 2000 11:06:01 -0600 (CST)
Received: from ti.com (IDENT:bbrown@bbrowndt.sc.ti.com [158.218.100.194])
	by dlep3.itg.ti.com (8.9.3/8.9.3) with ESMTP id LAA01896;
	Wed, 13 Dec 2000 11:06:00 -0600 (CST)
Message-ID: <3A37ACC9.82476B96@ti.com>
Date:   Wed, 13 Dec 2000 10:07:21 -0700
From:   Brady Brown <bbrown@ti.com>
Organization: Texas Instruments
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Nicu Popovici <octavp@isratech.ro>
CC:     linux-mips@oss.sgi.com
Subject: Re: YAMON.
References: <3A37B34B.69C1BF2@isratech.ro>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Nicu Popovici wrote:

> Hello ,
>
> Does anyone know how can I do to start a Linux on a mips board ( ATLAS )
> without using YAMON. I just want to turn on the mips and to boot in
> Linux . Is that possible ?
>
> Regards,
> Nicu

It is possible. Look in Atlas Users Manual Sec 5.2 . Dip switch S1-1
controls booting from either Monitor Flash or System Flash. If you boot
from System Flash then the monitor is effectively removed. You would of
course have to have your own boot-up code, PCI enumerator, hardware init,
kernel loader, kernel image, etc.  in the System Flash all hooked to the
reset vector for this to work.

--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Brady Brown (bbrown@ti.com)       Work:(801)619-6103
Texas Instruments: Broadband Access Group
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
