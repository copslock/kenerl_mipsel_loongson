Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2008 18:27:48 +0100 (BST)
Received: from oss.sgi.com ([192.48.170.157]:21129 "EHLO oss.sgi.com")
	by ftp.linux-mips.org with ESMTP id S20029584AbYDPR1q (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2008 18:27:46 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m3GHQw4I008668
	for <linux-mips@linux-mips.org>; Wed, 16 Apr 2008 10:26:59 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m3GHRdmI006378;
	Wed, 16 Apr 2008 18:27:39 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m3GHRcnw006377;
	Wed, 16 Apr 2008 18:27:38 +0100
Date:	Wed, 16 Apr 2008 18:27:37 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Alchemy: kill useless #include's, #define's and
	extern's (take 3)
Message-ID: <20080416172737.GA32263@linux-mips.org>
References: <200804162115.59620.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200804162115.59620.sshtylyov@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 16, 2008 at 09:15:59PM +0400, Sergei Shtylyov wrote:

> Go thru the Alchemy code and hunt down every unneeded #include, #define, and
> extern (some of which refer to already long dead functions).
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> Killed #include <au1xxx_dbdma.h> and couple #define's in
> arch/mips/au1000/pb1200/board_setup.c...
> 
> Please update the queued patch, hopefully the last time. :-)

Done,

  Ralf
