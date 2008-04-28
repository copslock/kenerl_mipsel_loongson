Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Apr 2008 10:36:16 +0100 (BST)
Received: from oss.sgi.com ([192.48.170.157]:12255 "EHLO oss.sgi.com")
	by ftp.linux-mips.org with ESMTP id S20151588AbYD1JgN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 28 Apr 2008 10:36:13 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m3S9ZExL029660
	for <linux-mips@linux-mips.org>; Mon, 28 Apr 2008 02:35:20 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m3S9Zp66006332;
	Mon, 28 Apr 2008 10:35:51 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m3S9ZpEB006325;
	Mon, 28 Apr 2008 10:35:51 +0100
Date:	Mon, 28 Apr 2008 10:35:51 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Adrian Bunk <bunk@kernel.org>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] asm-mips/mach-ip27/topology.h must #include
	<asm-generic/topology.h>
Message-ID: <20080428093550.GB18190@linux-mips.org>
References: <20080423155559.GR28933@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080423155559.GR28933@cs181133002.pp.htv.fi>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19029
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 23, 2008 at 06:55:59PM +0300, Adrian Bunk wrote:

> Subject: [2.6 patch] asm-mips/mach-ip27/topology.h must #include
> 	<asm-generic/topology.h>

Thanks, applied.

  Ralf
