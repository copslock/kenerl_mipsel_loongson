Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2008 14:34:45 +0100 (CET)
Received: from oss.sgi.com ([192.48.170.157]:38335 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S524408AbYC0Nel (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Mar 2008 14:34:41 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m2RDY1S9001874
	for <linux-mips@linux-mips.org>; Thu, 27 Mar 2008 06:34:02 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m2RDYYVI019481;
	Thu, 27 Mar 2008 13:34:35 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m2RDYX1S019480;
	Thu, 27 Mar 2008 13:34:33 GMT
Date:	Thu, 27 Mar 2008 13:34:33 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Alchemy: work around clock misdetection on early
	Au1000 (take 2)
Message-ID: <20080327133433.GA19381@linux-mips.org>
References: <200803271609.31772.sshtylyov@ru.mvista.com> <47EB9E55.4040800@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47EB9E55.4040800@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 27, 2008 at 04:17:09PM +0300, Sergei Shtylyov wrote:

>    Oops! Ralf, could you change 'cur_cpu_spec[0]' to just 'sp' here before 
> committing?

wilco

  Ralf
