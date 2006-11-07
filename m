Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Nov 2006 15:31:27 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:24007 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038548AbWKGPbZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Nov 2006 15:31:25 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kA7FVp4u030765;
	Tue, 7 Nov 2006 15:31:51 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kA7FVo20030764;
	Tue, 7 Nov 2006 15:31:50 GMT
Date:	Tue, 7 Nov 2006 15:31:50 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Nicolas Kaiser <nikai@nikai.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH][TRIVIAL] arch/mips: double inclusions
Message-ID: <20061107153150.GA22438@linux-mips.org>
References: <20061107095624.48577377@lucky.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061107095624.48577377@lucky.kitzblitz>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 07, 2006 at 09:56:24AM +0100, Nicolas Kaiser wrote:

> double inclusions in arch/mips

This patch already seems a while old so there were a few rejects.  Patches
are like fish, ship while fresh to make penguins happy ;-)  Anyway, I
fixed it up.

Did you use a script to generate these patches?  If so I'd be interested.

Thanks,

  Ralf
