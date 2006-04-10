Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Apr 2006 18:25:58 +0100 (BST)
Received: from mms3.broadcom.com ([216.31.210.19]:27402 "EHLO
	MMS3.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S8133481AbWDJRZt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 10 Apr 2006 18:25:49 +0100
Received: from 10.10.64.154 by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Mon, 10 Apr 2006 10:37:15 -0700
X-Server-Uuid: B238DE4C-2139-4D32-96A8-DD564EF2313E
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 3D3822B0; Mon, 10 Apr 2006 10:37:15 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 0FF452AE; Mon, 10 Apr
 2006 10:37:15 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5-GA) with ESMTP
 id DGV78001; Mon, 10 Apr 2006 10:37:12 -0700 (PDT)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 EB9D520501; Mon, 10 Apr 2006 10:37:11 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: Oprofile on sibyte 2.4.18 kernel
Date:	Mon, 10 Apr 2006 10:37:10 -0700
Message-ID: <7E000E7F06B05C49BDBB769ADAF44D07989970@NT-SJCA-0750.brcm.ad.broadcom.com>
Thread-Topic: Oprofile on sibyte 2.4.18 kernel
Thread-Index: AcZag0lud8MhRbSARI6GHA+OQL7jGwCQb5sQ
From:	"Mark E Mason" <mark.e.mason@broadcom.com>
To:	"Shanthi Kiran Pendyala (skiranp)" <skiranp@cisco.com>,
	"linux-mips" <linux-mips@linux-mips.org>
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006041005; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230372E34343341393641392E303036362D412D;
 ENG=IBF; TS=20060410173718; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006041005_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 682448413NG6720318-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.e.mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello Shanthi,

The Sibyte group at broadcom has a set profiling tools for Linux 2.4
which provide basically the same functionality as oprofile.  Simply
contact your FAE or email sibyte-software@broadcom.com to get a copy.

Thanks,
Mark Mason
mason@broadcom.com 

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of 
> Shanthi Kiran Pendyala (skiranp)
> Sent: Friday, April 07, 2006 1:39 PM
> To: linux-mips
> Subject: Oprofile on sibyte 2.4.18 kernel
> 
> Hi,
> 
> Did anyone port oprofile to 2.4.x kernel on sibyte ?.
> 
> Looking over the mailing list threads it looks like it has 
> been given up as a lost cause.
> 
> But business reasons require us to work with 2.4.18 kernel 
> for the next
> 9-12 months and
> We really would like explore a port.
> 
> Or are there other tools that I can use ?
> 
> Thank you
> Shanthi kiran 
> 
> 
> 
