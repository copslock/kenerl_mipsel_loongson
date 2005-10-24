Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Oct 2005 15:37:14 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:52762 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465796AbVJXOg5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 24 Oct 2005 15:36:57 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9OEaqIO014354;
	Mon, 24 Oct 2005 15:36:52 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9OEaoR6014353;
	Mon, 24 Oct 2005 15:36:50 +0100
Date:	Mon, 24 Oct 2005 15:36:50 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] add __user tag to csum_partial_copy_from_user
Message-ID: <20051024143650.GG2605@linux-mips.org>
References: <20051024.231953.25910234.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051024.231953.25910234.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 24, 2005 at 11:19:53PM +0900, Atsushi Nemoto wrote:

> Add __user tag to csum_partial_copy_from_user to fix some sparse
> warnings.

Applied.

I did some sparse fixing over the weekend as well, going to push that
now.

  Ralf
