Received:  by oss.sgi.com id <S42278AbQGSVpP>;
	Wed, 19 Jul 2000 14:45:15 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:1096 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42275AbQGSVop>;
	Wed, 19 Jul 2000 14:44:45 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA24531
	for <linux-mips@oss.sgi.com>; Wed, 19 Jul 2000 14:36:52 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id OAA34455 for <linux-mips@oss.sgi.com>; Wed, 19 Jul 2000 14:43:51 -0700 (PDT)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA77256
	for <linux@engr.sgi.com>;
	Wed, 19 Jul 2000 14:42:14 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from hermes.mvista.com (gateway-490.mvista.com [63.192.220.206]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA24087
	for <linux@engr.sgi.com>; Wed, 19 Jul 2000 14:34:42 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.9.3/8.9.3) with ESMTP id OAA10688;
	Wed, 19 Jul 2000 14:41:41 -0700
Message-ID: <39762094.9F59676D@mvista.com>
Date:   Wed, 19 Jul 2000 14:41:40 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
CC:     Geert.Uytterhoeven@sonycom.com
Subject: How does PCI device get its interrupt vector?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


I am trying to get DDB5476 working and got puzzled by the interrupt
vector thing.

The on-board ether chip, a PCI device, apparently indicates it generates
interrupts and has an interrupt vector of 123.  Later on, when
tulip_open tries to call request_irq(123, ...), it returns with an error
because the vector is greater than 32.

Here are my questions :

1. Who wrote 123 to the ether chip?  That does not sound right to me at
first place.

2. Assuming the ether chip returns 0xFF (an invalid interrupt vector,
which I believe is the correct behavior), which part of Linux is
responsible to figure out the correct interrupt vector?  Here we do have
the interrupt pin information and interrupt routing information.  So we
should be able to tell what is the right interrupt vector number.

Any hints?  Thanks.

Jun
