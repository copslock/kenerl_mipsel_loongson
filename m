Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2006 20:15:25 +0100 (BST)
Received: from mms2.broadcom.com ([216.31.210.18]:30992 "EHLO
	mms2.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S20038886AbWJCTPY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 3 Oct 2006 20:15:24 +0100
Received: from 10.10.64.154 by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.2)); Tue, 03 Oct 2006 12:15:11 -0700
X-Server-Uuid: 79DB55DB-3CB4-423E-BEDB-D0F268247E63
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 933AD2B0; Tue, 3 Oct 2006 12:15:11 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 6A55E2AE for
 <linux-mips@linux-mips.org>; Tue, 3 Oct 2006 12:15:11 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id EGL94526; Tue, 3 Oct 2006 12:15:11 -0700 (PDT)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 174CF20501 for <linux-mips@linux-mips.org>; Tue, 3 Oct 2006 12:15:11
 -0700 (PDT)
Received: from NT-SJCA-0752.brcm.ad.broadcom.com ([10.16.192.222]) by
 NT-SJCA-0750.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Tue, 3 Oct 2006 12:15:10 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: Build error
Date:	Tue, 3 Oct 2006 12:15:09 -0700
Message-ID: <710F16C36810444CA2F5821E5EAB7F230A0FB6@NT-SJCA-0752.brcm.ad.broadcom.com>
Thread-Topic: Build error
Thread-Index: AcbnID4nsYv0X9gERxaKGlGLzCI2Ew==
From:	"Manoj Ekbote" <manoje@broadcom.com>
To:	linux-mips@linux-mips.org
X-OriginalArrivalTime: 03 Oct 2006 19:15:10.0934 (UTC)
 FILETIME=[3F0BB760:01C6E720]
X-TMWD-Spam-Summary: TS=20061003191512; SEV=2.0.2; DFV=A2006100307;
 IFV=2.0.4,4.0-8; RPD=4.00.0004; ENG=IBF;
 RPDID=303030312E30413031303230352E34353232423638422E303037332D412D;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: A2006100307_4.00.0004_4.0-8
X-WSS-ID: 693C69352I0973040-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <manoje@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12789
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manoje@broadcom.com
Precedence: bulk
X-list: linux-mips

Hi,

I see this error while compiling the latest sources:

  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/mips/kernel/built-in.o: In function `do_gettimeofday':
: undefined reference to `tickadj'
arch/mips/kernel/built-in.o: In function `do_gettimeofday':
: undefined reference to `tickadj'
make: *** [.tmp_vmlinux1] Error 1

There is no definition of tickadj anywhere in the tree. Is it supposed
to be in kernel/time/ntp.c?


/manoj
