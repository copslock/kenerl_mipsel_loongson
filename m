Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 20:49:59 +0000 (GMT)
Received: from mms1.broadcom.com ([216.31.210.17]:39440 "EHLO
	mms1.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S3458332AbWAWUt1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Jan 2006 20:49:27 +0000
Received: from 10.10.64.154 by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Mon, 23 Jan 2006 12:53:26 -0800
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 C63AA67423; Mon, 23 Jan 2006 12:53:25 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 2E0F767420; Mon, 23
 Jan 2006 12:53:25 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id CTM98377; Mon, 23 Jan 2006 12:53:01 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 6F22E20501; Mon, 23 Jan 2006 12:53:01 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: Building the kernel for a Broadcom SB1
Date:	Mon, 23 Jan 2006 12:53:00 -0800
Message-ID: <7E000E7F06B05C49BDBB769ADAF44D07694005@NT-SJCA-0750.brcm.ad.broadcom.com>
Thread-Topic: Building the kernel for a Broadcom SB1
Thread-Index: AcYgHMNKcIfD5ibBSCu20YKn9L33LQAQhgxA
From:	"Mark E Mason" <mark.e.mason@broadcom.com>
To:	"Martin Michlmayr" <tbm@cyrius.com>
cc:	linux-mips@linux-mips.org
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006012307; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413031303230332E34334435343045452E303031442D412D;
 ENG=IBF; TS=20060123205329; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006012307_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6FCB9DCC10G3828690-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.e.mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello,

Yes....

The original email from me with the patch was posted on 9/15, the patch
was applied to git (by way of Andy) around early October.

HTH,
Mark

-----Original Message-----
From: Martin Michlmayr [mailto:tbm@cyrius.com] 
Sent: Monday, January 23, 2006 4:58 AM
To: Mark E Mason
Cc: linux-mips@linux-mips.org
Subject: Re: Building the kernel for a Broadcom SB1

* Martin Michlmayr <tbm@cyrius.com> [2006-01-16 16:05]:
> > >Anyway, there are a few symbols undefined, which is >causing
> > problems. First off the bat is TO_PHYS_MASK.  >There is no set of 
> > definitions in >include/asm-mips/addrspace.h for the SB1 processor.
> Can this patch be applied?

Actually, no, SB1 is defined in addrspace.h already and this leads to a
redefinition.  The values that would've been used with your patch and
the current values are slightly different though; maybe you can check
that.  Current git works though.
--
Martin Michlmayr
http://www.cyrius.com/
