Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jul 2005 15:11:33 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:39702 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226451AbVGKOLR>; Mon, 11 Jul 2005 15:11:17 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j6BEC6Ag003431;
	Mon, 11 Jul 2005 15:12:06 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j6BEC51s003430;
	Mon, 11 Jul 2005 15:12:05 +0100
Date:	Mon, 11 Jul 2005 15:12:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Nishanth Aravamudan <nacc@us.ibm.com>
Cc:	linux-mips@linux-mips.org,
	Kernel-Janitors <kernel-janitors@lists.osdl.org>
Subject: Re: [PATCH 7/14] mips: replace timespectojiffies() with timespec_to_jiffies()
Message-ID: <20050711141205.GV2765@linux-mips.org>
References: <20050709000324.GD2596@us.ibm.com> <20050709001127.GM2596@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050709001127.GM2596@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 08, 2005 at 05:11:27PM -0700, Nishanth Aravamudan wrote:

> Description: Replace custom timespectojiffies() function with generic
> standard one.

Applied.  Thanks,

  Ralf
