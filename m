Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Feb 2008 20:25:39 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:49325 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037229AbYBYUZh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 25 Feb 2008 20:25:37 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m1PKPakk015209;
	Mon, 25 Feb 2008 20:25:36 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m1PKPZRG015208;
	Mon, 25 Feb 2008 20:25:35 GMT
Date:	Mon, 25 Feb 2008 20:25:35 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS, 2.6.16, PATCH] Fix SWARM onboard IDE probing
Message-ID: <20080225202533.GA14789@linux-mips.org>
References: <20080225191749.GG25530@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080225191749.GG25530@networkno.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 25, 2008 at 07:17:49PM +0000, Thiemo Seufer wrote:

> linux-2.6.16-stable misses the IDE probing fix which is already applied
> to later stable branches (from linux-2.6.17-stable onwards). It is
> needed to access the SWARM onboard IDE device.

Thanks, applied.

  Ralf
