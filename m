Received:  by oss.sgi.com id <S42285AbQGTBN6>;
	Wed, 19 Jul 2000 18:13:58 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:39491 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42280AbQGTBNY>; Wed, 19 Jul 2000 18:13:24 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id SAA07993
	for <linux-mips@oss.sgi.com>; Wed, 19 Jul 2000 18:18:33 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA79995
	for <linux@engr.sgi.com>;
	Wed, 19 Jul 2000 18:12:32 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from hermes.mvista.com (gateway-490.mvista.com [63.192.220.206]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id SAA04346
	for <linux@engr.sgi.com>; Wed, 19 Jul 2000 18:05:00 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.9.3/8.9.3) with ESMTP id SAA15079;
	Wed, 19 Jul 2000 18:12:14 -0700
Message-ID: <397651ED.80F1A4D4@mvista.com>
Date:   Wed, 19 Jul 2000 18:12:13 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        Geert.Uytterhoeven@sonycom.com
Subject: Re: How does PCI device get its interrupt vector?
References: <39762094.9F59676D@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Jun Sun wrote:
> 
> 2. Assuming the ether chip returns 0xFF (an invalid interrupt vector,
> which I believe is the correct behavior), which part of Linux is
> responsible to figure out the correct interrupt vector?  

Never mind.  I found the place.  It is in pcibios_fixup_irqs().

Jun
