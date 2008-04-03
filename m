Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2008 19:10:25 +0200 (CEST)
Received: from [192.48.170.157] ([192.48.170.157]:49876 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S1101209AbYDCRBW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 3 Apr 2008 19:01:22 +0200
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m33GwvZ6018930
	for <linux-mips@linux-mips.org>; Thu, 3 Apr 2008 09:59:01 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m33CpOAj026139;
	Thu, 3 Apr 2008 13:51:24 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m33CpOEt026138;
	Thu, 3 Apr 2008 13:51:24 +0100
Date:	Thu, 3 Apr 2008 13:51:24 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Alchemy: kill useless #include's and extern's
Message-ID: <20080403125124.GB20775@linux-mips.org>
References: <200804022332.08317.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200804022332.08317.sshtylyov@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 02, 2008 at 11:32:08PM +0400, Sergei Shtylyov wrote:

> Go thru the Alchemy code and hunt down every unneeded #include and extern
> (some of which refer to already long dead functions).
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Thanks, queued for 2.6.26.

  Ralf
