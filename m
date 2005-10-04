Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Oct 2005 15:07:22 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:7446 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133473AbVJDOHD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Oct 2005 15:07:03 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j94E6tdP014120;
	Tue, 4 Oct 2005 15:06:55 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j94E6s3v014112;
	Tue, 4 Oct 2005 15:06:54 +0100
Date:	Tue, 4 Oct 2005 15:06:54 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Add support for 4KS cpu.
Message-ID: <20051004140654.GC2725@linux-mips.org>
References: <cda58cb80510040149p690397afo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80510040149p690397afo@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 04, 2005 at 10:49:44AM +0200, Franck wrote:

> This patch adds support for both 4ksc and 4ksd cpus. These cpu are
> mainly used in embedded system such as smartcard or point of sell
> devices as they provide some extra security features.

So I've applied the cpu-probe.c part.

Thanks,

  Ralf
