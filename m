Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2005 12:15:34 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:27913 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225547AbVEWLPS>; Mon, 23 May 2005 12:15:18 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j4NBEpFC006542;
	Mon, 23 May 2005 12:14:51 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j4NBEpED006541;
	Mon, 23 May 2005 12:14:51 +0100
Date:	Mon, 23 May 2005 12:14:51 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2.6] vr41xx: update setup functions
Message-ID: <20050523111451.GA4383@linux-mips.org>
References: <20050522112030.59e103ec.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050522112030.59e103ec.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, May 22, 2005 at 11:20:30AM +0900, Yoichi Yuasa wrote:

> This patch had updated vr41xx setup functions.
> o add __init
> o change from early_initcall to arch_initcall

Applied,

  Ralf
