Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jan 2008 10:25:11 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:40633 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28578554AbYAKKYp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 Jan 2008 10:24:45 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0BAOPPI008486;
	Fri, 11 Jan 2008 10:24:26 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0ALwO6J021021;
	Thu, 10 Jan 2008 21:58:24 GMT
Date:	Thu, 10 Jan 2008 21:58:24 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Cc:	linux-mips@linux-mips.org,
	Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG][PATCH] fix broken software reset for Malta board
Message-ID: <20080110215824.GA20935@linux-mips.org>
References: <4782F180.7000104@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4782F180.7000104@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 08, 2008 at 06:44:00AM +0300, Dmitri Vorobiev wrote:

> I noticed that the commit f197465384bf7ef1af184c2ed1a4e268911a91e3
> (MIPS Tech: Get rid of volatile in core code) broke the software
> reset functionality for MIPS Malta boards in big-endian mode.

Thanks, applied.

  Ralf
