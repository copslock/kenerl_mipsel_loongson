Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2006 16:47:07 +0000 (GMT)
Received: from mms3.broadcom.com ([216.31.210.19]:36619 "EHLO
	MMS3.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S8133603AbWCNQq7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2006 16:46:59 +0000
Received: from 10.10.64.154 by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Tue, 14 Mar 2006 08:57:46 -0800
X-Server-Uuid: B238DE4C-2139-4D32-96A8-DD564EF2313E
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 BF00B2AF; Tue, 14 Mar 2006 08:55:48 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 9A7F42AE; Tue, 14 Mar
 2006 08:55:48 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.3a-GA) with ESMTP
 id DCE25737; Tue, 14 Mar 2006 08:55:48 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 F3CF920501; Tue, 14 Mar 2006 08:55:47 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: BCM91x80A/B PCI DMA problems
Date:	Tue, 14 Mar 2006 08:55:31 -0800
Message-ID: <7E000E7F06B05C49BDBB769ADAF44D07868182@NT-SJCA-0750.brcm.ad.broadcom.com>
Thread-Topic: BCM91x80A/B PCI DMA problems
Thread-Index: AcZHX/ZufVEYAD+0S7OKc9dHk+WzCgAJ9W4w
From:	"Mark E Mason" <mark.e.mason@broadcom.com>
To:	"Alan Cox" <alan@lxorguk.ukuu.org.uk>,
	"Martin Michlmayr" <tbm@cyrius.com>
cc:	linux-mips@linux-mips.org
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006031405; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230342E34343136463534332E303033312D412D;
 ENG=IBF; TS=20060314165750; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006031405_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6808298036W6783102-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.e.mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello Alan,
 
> All drivers set a PCI DMA mask. If the kernel is not bouncing 
> buffers and ensuring the buffers are below the 32bit bus 
> address limit by default then the architecture kernel code 
> needs fixing. The drivers don't deal with this matter beyond 
> setting their PCI DMA range mask.

Thanks!

I'm not that familiar with all parts of the Linux kernel.  What should I
be looking for in order to find the relevant bits in the arch-port code?

Thanks,
Mark
