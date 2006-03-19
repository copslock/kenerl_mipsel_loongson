Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Mar 2006 13:14:51 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:17416 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133536AbWCSNOm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 19 Mar 2006 13:14:42 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 82BEA64D3D; Sun, 19 Mar 2006 13:24:13 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id E92F666ED5; Sun, 19 Mar 2006 13:23:56 +0000 (GMT)
Date:	Sun, 19 Mar 2006 13:23:56 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Tom Rix <trix@specifix.com>
Cc:	linux-mips@linux-mips.org, Mark E Mason <mark.e.mason@broadcom.com>
Subject: Re: [PATCH] Broadcom Sibyte SB1xxx NAPI ethernet support
Message-ID: <20060319132356.GA24111@deprecation.cyrius.com>
References: <20060309060606.GA16963@deprecation.cyrius.com> <op.s544y1x4thfl8t@localhost.localdomain> <op.s56kmdy3thfl8t@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.s56kmdy3thfl8t@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Tom Rix <trix@specifix.com> [2006-03-09 22:42]:
> This patch adds NAPI support for the Broadcom Sibyte SB1xxx family.
> The  changes are limited to adding a new config key SBMAC_NAPI to
> the  drivers/net/Kconfig and by adding the poll op and interrupt
> support to  drivers/net/sb1250-mac.c.

Thanks, I've not seen a single problem since I applied your patch.
I've applied it to the Debian tree.
-- 
Martin Michlmayr
http://www.cyrius.com/
