Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2005 17:10:46 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:29194 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225621AbVDRQKb>; Mon, 18 Apr 2005 17:10:31 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j3IGAMgE031465;
	Mon, 18 Apr 2005 17:10:22 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j3IGALMJ031464;
	Mon, 18 Apr 2005 17:10:21 +0100
Date:	Mon, 18 Apr 2005 17:10:21 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2.6] vr41xx: update init.c
Message-ID: <20050418161021.GM4572@linux-mips.org>
References: <20050418232805.68e9828b.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050418232805.68e9828b.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 18, 2005 at 11:28:05PM +0900, Yoichi Yuasa wrote:

> This patch had updated init.c for vr41xx.
>  - add iomem resource init
>  - add CP0 timer init
>  - add clock frequency calculation

Thanks, Yoichi.  Applied,

  Ralf
