Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 May 2008 12:54:14 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:12215 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20033861AbYEXLyI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 May 2008 12:54:08 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m4OBs6ml029994;
	Sat, 24 May 2008 12:54:06 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m4OBs5a6029987;
	Sat, 24 May 2008 12:54:05 +0100
Date:	Sat, 24 May 2008 12:54:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] IP27: Fix clockevent setup
Message-ID: <20080524115405.GB20822@linux-mips.org>
References: <20080408214357.17E39C2C04@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080408214357.17E39C2C04@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 08, 2008 at 11:43:57PM +0200, Thomas Bogendoerfer wrote:
> From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Date: Tue,  8 Apr 2008 23:43:57 +0200 (CEST)
> To: linux-mips@linux-mips.org
> cc: ralf@linux-mips.org
> Subject: [PATCH] IP27: Fix clockevent setup
> 
> Fix breakage introduced by converting hub_rt to clockevent.

Applied,

  Ralf
