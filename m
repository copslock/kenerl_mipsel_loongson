Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Oct 2008 17:57:41 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:8602 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S21493901AbYJNQ5j (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 14 Oct 2008 17:57:39 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9EGvarZ011439;
	Tue, 14 Oct 2008 17:57:36 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9EGvahW011438;
	Tue, 14 Oct 2008 17:57:36 +0100
Date:	Tue, 14 Oct 2008 17:57:36 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH v4] IP27: Switch over to RTC class driver
Message-ID: <20081014165736.GC11407@linux-mips.org>
References: <20081014151728.CA36DC3AEA@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081014151728.CA36DC3AEA@solo.franken.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 14, 2008 at 05:17:28PM +0200, Thomas Bogendoerfer wrote:

> This patchset removes some dead code and creates a platform device
> for the RTC class driver.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
> 
> Please apply for 2.6.28

Thanks, applied.

  Ralf
