Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2006 22:07:56 +0000 (GMT)
Received: from mms1.broadcom.com ([216.31.210.17]:4359 "EHLO mms1.broadcom.com")
	by ftp.linux-mips.org with ESMTP id S8133642AbWB1WHo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Feb 2006 22:07:44 +0000
Received: from 10.10.64.154 by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Tue, 28 Feb 2006 14:16:37 -0800
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 4302B2AF; Tue, 28 Feb 2006 14:15:18 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 1D0B62AE; Tue, 28 Feb
 2006 14:15:18 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.3a-GA) with ESMTP
 id DAA84960; Tue, 28 Feb 2006 14:15:17 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 06CED20501; Tue, 28 Feb 2006 14:15:17 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: BCM91x80A/B PCI DMA problems
Date:	Tue, 28 Feb 2006 14:15:10 -0800
Message-ID: <7E000E7F06B05C49BDBB769ADAF44D077D643F@NT-SJCA-0750.brcm.ad.broadcom.com>
Thread-Topic: BCM91x80A/B PCI DMA problems
Thread-Index: AcY8tCpDwC8qmjA/TLG8pIFRTGHe7AAAB1Zw
From:	"Mark E Mason" <mark.e.mason@broadcom.com>
To:	"Martin Michlmayr" <tbm@cyrius.com>
cc:	linux-mips@linux-mips.org
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006022808; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230322E34343034434232392E303035352D412D;
 ENG=IBF; TS=20060228221639; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006022808_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 681A144F36K3375156-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10685
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.e.mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello,

Is this driver known to work with 64-bit kernels (specifically: 64-bit
DMA addresses)?  It sounds like that might be the problem.

HTH,
Mark

> -----Original Message-----
> From: Martin Michlmayr [mailto:tbm@cyrius.com] 
> Sent: Tuesday, February 28, 2006 2:13 PM
> To: Mark E Mason
> Cc: linux-mips@linux-mips.org
> Subject: Re: BCM91x80A/B PCI DMA problems
> 
> * Mark E Mason <mark.e.mason@broadcom.com> [2006-02-28 13:53]:
> > Is this a 32-bit, or 64-bit kernel?  If 64-bit, do you have 
> more than 
> > 1G of DRAM installed in the system (DRAM above 1G is accessed at 
> > >32-bit physical addresses).
> 
> Erm, I have 2 GB of RAM and used a 64-bit kernel.  Using a 
> 32-bit kernel works.
> 
> > Are you using CFE 1.2.5?  The PCI interrupt assignments in earlier
> 
> Yes.
> 
> > versions of CFE were not correct.
> --
> Martin Michlmayr
> http://www.cyrius.com/
> 
> 
