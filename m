Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2006 20:16:34 +0100 (BST)
Received: from mms2.broadcom.com ([216.31.210.18]:37899 "EHLO
	mms2.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S20039915AbWJJTQc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Oct 2006 20:16:32 +0100
Received: from 10.10.64.154 by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.2)); Tue, 10 Oct 2006 12:16:20 -0700
X-Server-Uuid: 79DB55DB-3CB4-423E-BEDB-D0F268247E63
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 7001A2B0; Tue, 10 Oct 2006 12:16:20 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 3E5B22AE; Tue, 10 Oct
 2006 12:16:20 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id EHE56381; Tue, 10 Oct 2006 12:16:19 -0700 (PDT)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 68F7320501; Tue, 10 Oct 2006 12:16:19 -0700 (PDT)
Received: from NT-SJCA-0752.brcm.ad.broadcom.com ([10.16.192.222]) by
 NT-SJCA-0750.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Tue, 10 Oct 2006 12:16:19 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: Memory freeing at boot time on SB1
Date:	Tue, 10 Oct 2006 12:16:18 -0700
Message-ID: <710F16C36810444CA2F5821E5EAB7F231031F1@NT-SJCA-0752.brcm.ad.broadcom.com>
In-Reply-To: <20061010181148.59510.qmail@web31501.mail.mud.yahoo.com>
Thread-Topic: Memory freeing at boot time on SB1
Thread-Index: Acbsl69RKtIJKRN2Q6G+xLYPj/rhqAAAy2Cw
From:	"Manoj Ekbote" <manoje@broadcom.com>
To:	"Jonathan Day" <imipak@yahoo.com>, linux-mips@linux-mips.org
X-OriginalArrivalTime: 10 Oct 2006 19:16:19.0292 (UTC)
 FILETIME=[90AE91C0:01C6ECA0]
X-TMWD-Spam-Summary: TS=20061010191620; SEV=2.0.2; DFV=A2006101008;
 IFV=2.0.4,4.0-8; RPD=4.00.0004; ENG=IBF;
 RPDID=303030312E30413031303230322E34353242463131392E303032432D452D42494266314252712B51595268337955544B6A5A6E413D3D;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: A2006101008_4.00.0004_4.0-8
X-WSS-ID: 69352E0E2I03180852-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <manoje@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manoje@broadcom.com
Precedence: bulk
X-list: linux-mips

Hi,

True, the problem stlill exists. As Ralf suggested, I am trying to get
c-r4k.c to handle all SB1 operations and then attack the problem from
there on. 
Meanwhile, 2.6.18-rc2 is a candidate that still works.

/manoj

>-----Original Message-----
>From: linux-mips-bounce@linux-mips.org 
>[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Jonathan Day
>Sent: Tuesday, October 10, 2006 11:12 AM
>To: linux-mips@linux-mips.org
>Subject: Memory freeing at boot time on SB1
>
>Hi,
>
>Since updating to a more recent version of the git repository, 
>the patches published here that fixed the memory freeing bug 
>on the SB1 (Broadcom 1250) no longer apply. A quick round of 
>compiling, however, shows that the problem that the patch 
>fixed still remains.
>
>(As best as I recall, the problem was the switch from some 
>SB1-specific operations to generic ones.)
>
>Does anyone have an updated memory free fix?
>
>Jonathan
>
>__________________________________________________
>Do You Yahoo!?
>Tired of spam?  Yahoo! Mail has the best spam protection 
>around http://mail.yahoo.com 
>
>
>
