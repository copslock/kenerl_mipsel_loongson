Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jan 2003 06:28:15 +0000 (GMT)
Received: from rakshak.ishoni.co.in ([IPv6:::ffff:164.164.83.140]:40766 "EHLO
	arianne.in.ishoni.com") by linux-mips.org with ESMTP
	id <S8225210AbTAPG2P>; Thu, 16 Jan 2003 06:28:15 +0000
Received: from leonoid.in.ishoni.com (leonoid.in.ishoni.com [192.168.1.12])
	by arianne.in.ishoni.com (8.11.6/Ishonir2) with ESMTP id h0G6WpG32018
	for <linux-mips@linux-mips.org>; Thu, 16 Jan 2003 12:02:51 +0530
Received: by leonoid.in.ishoni.com with Internet Mail Service (5.5.2653.19)
	id <ZX2KGYVM>; Thu, 16 Jan 2003 12:01:53 +0530
Message-ID: <7CFD7CA8510CD6118F950002A519EA3003FB04E6@leonoid.in.ishoni.com>
From: Chetan B L <chetanb@ishoni.com>
To: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Performance measuring in MIPS R3000
Date: Thu, 16 Jan 2003 12:01:52 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <chetanb@ishoni.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chetanb@ishoni.com
Precedence: bulk
X-list: linux-mips

Hi,
      I want to measure the time taken by any kernel function. 
Is  there anything like rdtsc indtruction in MIPS ?
I saw timepeg patch for measuring the same for Pentium , is there anything
similar to it for MIPS ?


Thanks
Chetan
