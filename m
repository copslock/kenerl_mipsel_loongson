Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2008 23:46:29 +0200 (CEST)
Received: from oss.sgi.com ([192.48.170.157]:22188 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S526997AbYDCVoz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 3 Apr 2008 23:44:55 +0200
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m33Lh98E019631
	for <linux-mips@linux-mips.org>; Thu, 3 Apr 2008 14:43:14 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m33LhHQo002124;
	Thu, 3 Apr 2008 22:43:17 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m33LhGDS002123;
	Thu, 3 Apr 2008 22:43:16 +0100
Date:	Thu, 3 Apr 2008 22:43:16 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] PbAu1200: fix header breakage
Message-ID: <20080403214316.GC721@linux-mips.org>
References: <200804022353.19379.sshtylyov@ru.mvista.com> <47F4FB9A.6070005@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47F4FB9A.6070005@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 03, 2008 at 07:45:30PM +0400, Sergei Shtylyov wrote:

>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>
>    Er, the boards are called Pb1x00, not PbAu1x00, so Ralf please change 
> the summary before comitting (if you feel inclined :-).
>    (Luckily, DBAu1200 uses its own header, so it wasn't hurt by this error.)

Sorry, I already had committed the patch.  I'll fix it up in what I'm
going to send to Linus though.

  Ralf
