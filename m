Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2008 07:00:32 +0100 (BST)
Received: from mms2.broadcom.com ([216.31.210.18]:45830 "EHLO
	mms2.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S20022951AbYF0GA0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 27 Jun 2008 07:00:26 +0100
Received: from [10.11.16.99] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Thu, 26 Jun 2008 23:00:06 -0700
X-Server-Uuid: D3C04415-6FA8-4F2C-93C1-920E106A2031
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 62FEA2B1; Thu, 26 Jun 2008 23:00:06 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.11.18.52]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 4BC0C2B0; Thu, 26 Jun
 2008 23:00:06 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id GYW89469; Thu, 26 Jun 2008 23:00:02 -0700 (PDT)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 8849820503; Thu, 26 Jun 2008 23:00:02 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: Bug in atomic_sub_if_positive
Date:	Thu, 26 Jun 2008 23:00:01 -0700
Message-ID: <ADD7831BD377A74E9A1621D1EAAED18F0442B04E@NT-SJCA-0750.brcm.ad.broadcom.com>
In-Reply-To: <20080626121120.GA5222@linux-mips.org>
Thread-Topic: Bug in atomic_sub_if_positive
Thread-Index: AcjXhfSPlphHxEPJS56jk+LneGLzBQAlDgzw
From:	"Morten Larsen" <mlarsen@broadcom.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
X-WSS-ID: 647A5E6C3D070080861-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mlarsen@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlarsen@broadcom.com
Precedence: bulk
X-list: linux-mips

 
> I did play with a test program and can't reproduce the effect with my
> assembler.  I have darm memories of gas immitating some 
> obscure behaviour
> of the IRIX assembler and I think it doesn't do so for all 
> MIPS targets.
> 
> So I'm wandering what toolchain have you been using?
> 
>   Ralf
> 
The toolchain is from Wind River Systems 2.0 Linux Edition.
The kernel (based on 2.6.21.7) is also supplied by Wind River, and it
has preemption turned on.
The CPU is a Broadcom/SiByte BCM1125H (single core version of BCM1250
Swarm.)

Morten
