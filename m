Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2005 19:00:43 +0100 (BST)
Received: from mms3.broadcom.com ([IPv6:::ffff:216.31.210.19]:25104 "EHLO
	MMS3.broadcom.com") by linux-mips.org with ESMTP
	id <S8226022AbVHRSAV>; Thu, 18 Aug 2005 19:00:21 +0100
Received: from 10.10.64.121 by MMS3.broadcom.com with SMTP (Broadcom
 SMTP Relay (Email Firewall v6.1.0)); Thu, 18 Aug 2005 11:04:48 -0700
X-Server-Uuid: 35E76369-CF33-4172-911A-D1698BD5E887
Received: from mail-irva-8.broadcom.com ([10.10.64.221]) by
 mail-irva-1.broadcom.com (Post.Office MTA v3.5.3 release 223 ID#
 0-72233U7200L2200S0V35) with ESMTP id com; Thu, 18 Aug 2005 11:04:56
 -0700
Received: from mon-irva-10.broadcom.com (mon-irva-10.broadcom.com
 [10.10.64.171]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id BPP36181; Thu, 18 Aug 2005 11:04:51 -0700 (PDT)
Received: from pcirvcttruong2 (dhcp-10-3-136-70.broadcom.com
 [10.3.136.70]) by mon-irva-10.broadcom.com (8.9.1/8.9.1) with ESMTP id
 LAA04568; Thu, 18 Aug 2005 11:04:51 -0700 (PDT)
Message-ID: <200508181804.LAA04568@mon-irva-10.broadcom.com>
From:	"Ton Truong" <ttruong@broadcom.com>
To:	"'mohanlal jangir'" <mohanlaljangir@hotmail.com>,
	linux-mips@linux-mips.org
Subject: RE: NPTL info needed
Date:	Thu, 18 Aug 2005 11:04:48 -0700
MIME-Version: 1.0
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <BAY18-DAV1144F0C7D384449D254D6BD2B20@phx.gbl>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Thread-Index: AcWj5mfYfk2EzcMbQ2epzk0+UdjolQAOGQuw
X-WSS-ID: 6F1A124A0B04803701-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <ttruong@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ttruong@broadcom.com
Precedence: bulk
X-list: linux-mips

 Daniel Jacobowitz announced support for MIPS NPTL a while back (Apr 05),
complete with patch set for toolchain and kernel.  Check kernel.org archive
for that.

A uClibc port is being done by Steve Hill and infos can be found here:

http://www.realitydiluted.com/nptl-uclibc/

HTH,

/?TT

-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of mohanlal jangir
Sent: Thursday, August 18, 2005 4:11 AM
To: linux-mips@linux-mips.org
Subject: NPTL info needed

Does Linux 2.6 have NPTL support for MIPS architecture? A line at 
http://www.linux-mips.org/wiki/NPTL says "Currently NPTL for Linux/MIPS is 
work in progress". Where can I get NPTL source? Do I need new/patched 
compiler and glibc to compile NPTL source? If yes, what are the patches and 
where can I find them?

Regards,
Mohanlal
