Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2005 13:18:52 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:25631 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225346AbVFFMSh>; Mon, 6 Jun 2005 13:18:37 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j56CGfd1013326
	for <linux-mips@linux-mips.org>; Mon, 6 Jun 2005 13:16:41 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j56CGegM013325
	for linux-mips@linux-mips.org; Mon, 6 Jun 2005 13:16:40 +0100
Date:	Mon, 6 Jun 2005 13:16:40 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050606121640.GB6651@linux-mips.org>
References: <20050605035727Z8225003-1340+8177@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050605035727Z8225003-1340+8177@linux-mips.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jun 05, 2005 at 04:57:20AM +0100, sjhill@linux-mips.org wrote:

> Modified files:
> 	arch/mips      : Kconfig 
> 
> Log message:
> 	The DbAu1500 board also support big endian. Gee, imagine that.

Maybe.  In the past our Kconfig rsp. Config.in was not endianess-aware,
so I did make a few mistakes when I added that.

  Ralf
