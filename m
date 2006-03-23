Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Mar 2006 20:02:38 +0000 (GMT)
Received: from mms1.broadcom.com ([216.31.210.17]:18449 "EHLO
	mms1.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S8133560AbWCWUC3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 23 Mar 2006 20:02:29 +0000
Received: from 10.10.64.154 by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Thu, 23 Mar 2006 12:12:13 -0800
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 4BB102B0; Thu, 23 Mar 2006 12:12:13 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 273042AF; Thu, 23 Mar
 2006 12:12:13 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.3a-GA) with ESMTP
 id DDQ43598; Thu, 23 Mar 2006 12:12:12 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 E8C0620501; Thu, 23 Mar 2006 12:12:11 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: sb1250_hpt_setup fails for BigSur build and sb1250 MAC (re:
 1480) queue lockups
Date:	Thu, 23 Mar 2006 12:12:10 -0800
Message-ID: <7E000E7F06B05C49BDBB769ADAF44D078FBCC3@NT-SJCA-0750.brcm.ad.broadcom.com>
Thread-Topic: sb1250_hpt_setup fails for BigSur build and sb1250 MAC (
 re: 1480) queue lockups
Thread-Index: AcZOIRVVPkaTJOkTRcOhHbuDdx0JwwAlEn6Q
From:	"Mark E Mason" <mark.e.mason@broadcom.com>
To:	"Martin Michlmayr" <tbm@cyrius.com>,
	"Michael J. Hammel" <mips@graphics-muse.org>
cc:	linux-mips@linux-mips.org
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006032307; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230332E34343233303038342E303033382D412D;
 ENG=IBF; TS=20060323201215; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006032307_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 683DDE970HW1297410-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.e.mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello all, 

> > I was trying the latest 2.6.16 to see if the recent mods related to 
> > the sb1250 MAC fixed a problem where the incoming queue (and 
> > eventually outbound queue) get blocked.
> 
> The fix that was posted for this didn't make 2.6.16.  You 
> need to manually apply the patch from 
> http://www.linux-mips.org/archives/linux-mips/2006-03/msg00087.html

Thanks for answering this one Martin.

Also - we're working on a follow-on patch to the above which both
improves behaviour when the input packet rate greatly exceeds what the
system can handle, and nearly doubles the performance in forwarding of
small packets (measured in packets-per-second).

I'm currently working against 2.6.15 -- which is pretty stable for the
1480, and because it includes the oprofile changes we submitted earlier
for the sb1.

HTH,
Mark Mason
mason@broadcom.com
 
