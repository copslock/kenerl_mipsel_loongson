Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Oct 2005 17:31:11 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:60432 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133594AbVJ0Qay (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Oct 2005 17:30:54 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9RGUsgQ004916;
	Thu, 27 Oct 2005 17:30:54 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9RGUr7A004904;
	Thu, 27 Oct 2005 17:30:53 +0100
Date:	Thu, 27 Oct 2005 17:30:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] vr41xx: add plat_setup to -mm queue
Message-ID: <20051027163052.GD17645@linux-mips.org>
References: <20051028005937.02cb1007.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051028005937.02cb1007.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 28, 2005 at 12:59:37AM +0900, Yoichi Yuasa wrote:

> Please add this patch to -mm queue.
> This has already been included in linux-mips.git. 

Ok; I've folded this one into the nuke-early_init.patch.  The updated
upstream.git repository is online now.

  Ralf
