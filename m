Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2003 17:33:38 +0000 (GMT)
Received: from p508B57E5.dip.t-dialin.net ([IPv6:::ffff:80.139.87.229]:49883
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225412AbTKMRd1>; Thu, 13 Nov 2003 17:33:27 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hADH3HA0032719
	for <linux-mips@linux-mips.org>; Thu, 13 Nov 2003 18:03:18 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hADH3G22032718
	for linux-mips@linux-mips.org; Thu, 13 Nov 2003 18:03:16 +0100
Date: Thu, 13 Nov 2003 18:03:15 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: Cobalt kernel for 2.6
Message-ID: <20031113170315.GA32644@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

the Cobalt kernel, in particular the 2.6 port needs somebody to look after.
In 2.4 problems with the ethernet driver were reported and in 2.6 the
kernel builds but would need somebody with actual hardware to debug it.
An additional problem with 2.6 on Cobalt hardware are the size limits
for the booted kernel which would need to be worked around; various
solutions such as a two stage bootloader are thinkable.

Volunteers?

  Ralf
