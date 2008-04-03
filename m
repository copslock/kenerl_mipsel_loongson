Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2008 19:43:47 +0200 (CEST)
Received: from oss.sgi.com ([192.48.170.157]:43244 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S526437AbYDCRnb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 3 Apr 2008 19:43:31 +0200
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m33HfgEG031833
	for <linux-mips@linux-mips.org>; Thu, 3 Apr 2008 10:41:46 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m33HgKrD031393;
	Thu, 3 Apr 2008 18:42:20 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m33HgK4E031392;
	Thu, 3 Apr 2008 18:42:20 +0100
Date:	Thu, 3 Apr 2008 18:42:20 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] PbAu1200: fix header breakage
Message-ID: <20080403174220.GA31379@linux-mips.org>
References: <200804022353.19379.sshtylyov@ru.mvista.com> <47F4D006.4090200@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47F4D006.4090200@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 03, 2008 at 04:39:34PM +0400, Sergei Shtylyov wrote:

>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>
>> ---
>> Looks like nobody ever cared since the code was merged -- there's no defconfig.
>
>    Er, no... the breakage has been introduced by the commit 
> 95c4eb3ef4484ca85da5c98780d358cffd546b90 ([MIPS] Alchemy: Renumber 
> interrupts so irq_cpu can work.), so thanks go to its hasty author. ;-)

Peple throw all sorts of MIPS kit at me but no big iron that could be
used for regular test builds.  So that sort of mistakes which to a degree
is unavoidable oftens stays hidden for too long.

  Ralf
