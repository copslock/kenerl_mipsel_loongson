Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Oct 2003 11:21:19 +0100 (BST)
Received: from mail5.infineon.com ([IPv6:::ffff:203.126.245.197]:18828 "EHLO
	mail5-i.infineon.com") by linux-mips.org with ESMTP
	id <S8225473AbTJNKVR>; Tue, 14 Oct 2003 11:21:17 +0100
Received: from sinse004.ap.infineon.com (sgpk993a.sin.infineon.com [172.17.65.75])
	by mail5-i.infineon.com (8.11.7p1+Sun/8.11.7) with ESMTP id h9EALFT07388;
	Tue, 14 Oct 2003 18:21:15 +0800 (SGT)
Received: from blrw502w.blr.infineon.com ([172.29.142.21]) by sinse004.ap.infineon.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id 46XYACK8; Tue, 14 Oct 2003 18:21:12 +0800
Received: by blrw502w.blr.infineon.com with Internet Mail Service (5.5.2653.19)
	id <TVHGB3GX>; Tue, 14 Oct 2003 15:48:53 +0530
Message-ID: <0C674B14EAEBD61196D900B0D03DB49F010C8361@blrw502w.blr.infineon.com>
From: "Babbellapati Syam Krishna (IFIN DC COM)" 
	<Syam-Krishna.Babbellapati@infineon.com>
To: "'Ralf Baechle'" <ralf@linux-mips.org>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: RE: "sel" field in MTC0 instruction?
Date: Tue, 14 Oct 2003 15:48:52 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Return-Path: <Syam-Krishna.Babbellapati@infineon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Syam-Krishna.Babbellapati@infineon.com
Precedence: bulk
X-list: linux-mips

>> #define write_32bit_cp0_performance_register(register,value) 
>\ __asm__ 
>> __volatile__( \ "mtc0\t%0,"STR(register)",sel\n\t" \
>> "nop" \
>> : : "r" (value));
>
>Which seems to be dervied from an old function which was 
>eleminated months ago.  Checkout a current mipsregs.h - which 
>also accesses register with a non-zero selector value.
>

Thanks Ralf. I could get out of it.

Syam
