Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2006 16:37:35 +0000 (GMT)
Received: from mms2.broadcom.com ([216.31.210.18]:9477 "EHLO mms2.broadcom.com")
	by ftp.linux-mips.org with ESMTP id S8133603AbWCNQh1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Mar 2006 16:37:27 +0000
Received: from 10.10.64.154 by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Tue, 14 Mar 2006 08:46:59 -0800
X-Server-Uuid: D9EB6F12-1469-4C1C-87A2-5E4C0D6F9D06
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 1A3DB2AF; Tue, 14 Mar 2006 08:46:22 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id EE41B2AE; Tue, 14 Mar
 2006 08:46:21 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.3a-GA) with ESMTP
 id DCE22566; Tue, 14 Mar 2006 08:46:21 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 7CC9220501; Tue, 14 Mar 2006 08:46:21 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: BCM91x80A/B PCI DMA problems
Date:	Tue, 14 Mar 2006 08:46:05 -0800
Message-ID: <7E000E7F06B05C49BDBB769ADAF44D0786817F@NT-SJCA-0750.brcm.ad.broadcom.com>
Thread-Topic: BCM91x80A/B PCI DMA problems
Thread-Index: AcZHhcQE4UFfAMQeRH2SJj413qubvgAABssQ
From:	"Mark E Mason" <mark.e.mason@broadcom.com>
To:	"Martin Michlmayr" <tbm@cyrius.com>
cc:	linux-mips@linux-mips.org
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006031405; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230322E34343136463330392E303038452D412D;
 ENG=IBF; TS=20060314164702; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006031405_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 68082C094KO3821896-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.e.mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello, 

> * Mark E Mason <mark.e.mason@broadcom.com> [2006-03-14 08:21]:
> > There's a lot of PCI HW out there that's 32-bit only, but 
> there's also 
> > a fair bit that isn't.  A 32-bit device in a 64-bit system 
> is going to 
> > require bounce buffering by the driver/OS.
> 
> If I understand you correctly, you're saying that you 
> currently don't supporting 32 bit PCI cards on the SB1 
> platform.

Um - not exactly.  A 32-bit device in a 64-bit system will require some
form of bounce buffering.   This is true regardless of what the platform
is, or what the OS/RTOS is.

Sun did some interesting stuff with this in the early UltraSPARC systems
with a 'reverse I/O MMU' which bypassed the need for bounce buffering
but imposed other requirements on the drivers and OS.  Of course, that
required specialized HW which doesn't seem to be in vogue.

>  Is this something you care about, or should I get 
> a 64-bit PCI card instead?  How hard would it be to implement 
> bounce buffering anyway?

This is something I care about.

How difficult it is under Linux - I (personally) don't know.  Based on
other posts, it sounds like Linux has a system for it... But like I said
earlier, I'm far more familiar with certain other RTOS/firmware
environments than I am Linux.

If someone more familiar with this area could point me in the right
direction though, I'll get someone to look at it (if I don't myself).

Thanks,
Mark

> --
> Martin Michlmayr
> http://www.cyrius.com/
> 
> 
