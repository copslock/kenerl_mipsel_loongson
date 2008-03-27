Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2008 14:41:13 +0100 (CET)
Received: from oss.sgi.com ([192.48.170.157]:45770 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S524408AbYC0NlH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Mar 2008 14:41:07 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m2RDbLtj002431
	for <linux-mips@linux-mips.org>; Thu, 27 Mar 2008 06:40:27 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m2RDbu0Z019605;
	Thu, 27 Mar 2008 13:37:56 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m2RDbsTA019604;
	Thu, 27 Mar 2008 13:37:54 GMT
Date:	Thu, 27 Mar 2008 13:37:54 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Alchemy: work around clock misdetection on early
	Au1000 (take 2)
Message-ID: <20080327133754.GB19381@linux-mips.org>
References: <200803271609.31772.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200803271609.31772.sshtylyov@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 27, 2008 at 04:09:31PM +0300, Sergei Shtylyov wrote:

> Work around the CPU clock miscalculation on Au1000DA/HA/HB due the sys_cpupll
> register being write-only, i.e. actually do what the comment before cal_r4off()
> function advertised for years but the code failed at.  This is achieved by just
> giving user a chance to define the clock explicitly  in the board config. via
> CONFIG_SOC_AU1000_FREQUENCY option, defaulting to 396 MHz if the option is not
> given...
> 
> The patch is based on the AMD's big unpublished patch, the issue seems to be an
> undocumented errata (or feature :-)...

Applied, thanks,

  Ralf
