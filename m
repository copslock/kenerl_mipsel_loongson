Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Apr 2008 14:07:34 +0100 (BST)
Received: from oss.sgi.com ([192.48.170.157]:44161 "EHLO oss.sgi.com")
	by ftp.linux-mips.org with ESMTP id S20167580AbYD1NHb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 28 Apr 2008 14:07:31 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m3SD6STY018680
	for <linux-mips@linux-mips.org>; Mon, 28 Apr 2008 06:06:34 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m3SD7CK7016122;
	Mon, 28 Apr 2008 14:07:12 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m3SD7CgR016121;
	Mon, 28 Apr 2008 14:07:12 +0100
Date:	Mon, 28 Apr 2008 14:07:12 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Pb1200/DBAu1200: move platform code to its proper
	place (take 2)
Message-ID: <20080428130712.GC27741@linux-mips.org>
References: <200804262321.46298.sshtylyov@ru.mvista.com> <4815CB32.4040605@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4815CB32.4040605@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 28, 2008 at 05:03:46PM +0400, Sergei Shtylyov wrote:

>> This patch is atop of my two recent SMC 91C1111 platform device fixes.
>
>    It's 91C111, dammit...

The Blackfin people made the same typo ;-)

  Ralf
