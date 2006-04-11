Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Apr 2006 00:17:43 +0100 (BST)
Received: from mms2.broadcom.com ([216.31.210.18]:28939 "EHLO
	mms2.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S8133594AbWDKXRe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 12 Apr 2006 00:17:34 +0100
Received: from 10.10.64.154 by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Tue, 11 Apr 2006 16:29:08 -0700
X-Server-Uuid: D9EB6F12-1469-4C1C-87A2-5E4C0D6F9D06
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 AC7F42B0; Tue, 11 Apr 2006 16:29:07 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 169172B3; Tue, 11 Apr
 2006 16:29:06 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5-GA) with ESMTP
 id DHC57767; Tue, 11 Apr 2006 16:29:05 -0700 (PDT)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 4D85C20501; Tue, 11 Apr 2006 16:29:05 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: Oprofile on sibyte 2.4.18 kernel
Date:	Tue, 11 Apr 2006 16:29:03 -0700
Message-ID: <7E000E7F06B05C49BDBB769ADAF44D07989B22@NT-SJCA-0750.brcm.ad.broadcom.com>
Thread-Topic: Oprofile on sibyte 2.4.18 kernel
Thread-Index: AcZamdRoKUMjWTsKT5ersblLdXL9owCa8JOQACmOKlAAA+V1oAAA4vMQ
From:	"Mark E Mason" <mark.e.mason@broadcom.com>
To:	"Shanthi Kiran Pendyala (skiranp)" <skiranp@cisco.com>
cc:	"linux-mips" <linux-mips@linux-mips.org>
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006041109; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230362E34343343334139372E303031452D412D;
 ENG=IBF; TS=20060411232909; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006041109_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6822E44E1744900368-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.e.mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello,

> -----Original Message-----
> From: Shanthi Kiran Pendyala (skiranp) [mailto:skiranp@cisco.com] 
> Sent: Tuesday, April 11, 2006 4:09 PM
> To: Mark E Mason
> Cc: linux-mips
> Subject: RE: Oprofile on sibyte 2.4.18 kernel
> 
> Hi Mark,
> 
> Thx for the info.
> 
> The doc I have has the title 1250_1125-UM100-RDS.pdf. I went 
> back to docsafe And looked for the sb1-um100-rds.pdf doc that 
> you mention. 

Ah - got it.  What you're looking at here is the table for the SOC
performance counters, which aren't currently supported by oprofile.  If
you compare the two, the SOC performance counters deal with activity on
the system Z-bus, the core performance counters deal with processor
cycles, instruction execution, L1 cache activity and the like.

> I thought sb1 is the core and if two of these cores are 
> present it is labelled 1250 and If only one is present it is 
> marketed as 1125 ? Is my understanding wrong ?

This is correct.  From the documentation port of view, all of the "core
stuff" is in the SB1-UM100-RDS.pdf manual, the "SOC stuff" is in the
1250_1125_UM100-RDS.pdf manual.  At this point, oprofile only supports
the core performance counters.

> 
> Let me look at this document and see if it answers my questions.
> 
> Also, yes I was looking at 2.6 git tree, not the CVS tree as 
> I said below.. Sorry about That.

Not a problem.  Please let us know if you have any more questions.

Thanks,
Mark
