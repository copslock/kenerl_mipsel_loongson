Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2008 14:57:38 +0100 (BST)
Received: from oss.sgi.com ([192.48.170.157]:39897 "EHLO oss.sgi.com")
	by ftp.linux-mips.org with ESMTP id S28573732AbYDNN5f (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 14 Apr 2008 14:57:35 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m3EDulXl023817
	for <linux-mips@linux-mips.org>; Mon, 14 Apr 2008 06:56:48 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m3EDvRGi024383;
	Mon, 14 Apr 2008 14:57:27 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m3EDvQqU024382;
	Mon, 14 Apr 2008 14:57:26 +0100
Date:	Mon, 14 Apr 2008 14:57:26 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Alchemy: kill useless #include's and extern'sv (take 2)
Message-ID: <20080414135726.GA16005@linux-mips.org>
References: <200804112054.44078.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200804112054.44078.sshtylyov@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 11, 2008 at 08:54:43PM +0400, Sergei Shtylyov wrote:

> Go thru the Alchemy code and hunt down every unneeded #include and extern
> (some of which refer to already long dead functions).
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> Last time I overlooked arch/mips/au1000/mtx-1/platform.c, so please update the
> queued patch...

Thanks, updated.

  Ralf
