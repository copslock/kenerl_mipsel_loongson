Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Feb 2003 22:41:12 +0000 (GMT)
Received: from imo-d03.mx.aol.com ([IPv6:::ffff:205.188.157.35]:40182 "EHLO
	imo-d03.mx.aol.com") by linux-mips.org with ESMTP
	id <S8225222AbTBGTli>; Fri, 7 Feb 2003 19:41:38 +0000
Received: from Kumba12345@aol.com
	by imo-d03.mx.aol.com (mail_out_v34.21.) id l.10d.1f7a8d1f (3972)
	 for <linux-mips@linux-mips.org>; Fri, 7 Feb 2003 14:41:13 -0500 (EST)
From: Kumba12345@aol.com
Message-ID: <10d.1f7a8d1f.2b7565d9@aol.com>
Date: Fri, 7 Feb 2003 14:41:13 EST
Subject: Kernel from CVS won't boot
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: AOL 7.0 for Windows US sub 10634
Return-Path: <Kumba12345@aol.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1370
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Kumba12345@aol.com
Precedence: bulk
X-list: linux-mips


       I've built a kernel from linux-mips CVS (2.4 branch), yet this kernel 
refuses to boot on my Indigo2 machine.  I get to the PROM monitor, type in 
"boot -f 2420_2" (what I named the kernel in the volume header), and it just 
stops doing anything and sits there.  The light on the front of my case 
starts flashing, indicating I believe a panic of some kind.

       Any ideas on what may be possible causes of this?  I'm booting my 
kernels from the volume header directly.  If configs are needed, I can 
provide them.

--Kumba
