Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2004 15:42:56 +0000 (GMT)
Received: from p508B7F35.dip.t-dialin.net ([IPv6:::ffff:80.139.127.53]:42115
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225345AbULAPmw>; Wed, 1 Dec 2004 15:42:52 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iB1Fgkld009087;
	Wed, 1 Dec 2004 16:42:47 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iB1FgauZ009086;
	Wed, 1 Dec 2004 16:42:37 +0100
Date: Wed, 1 Dec 2004 16:42:36 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2.6] tlbwr hazard for NEC VR4100
Message-ID: <20041201154236.GA6480@linux-mips.org>
References: <20041201234943.584d88e8.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041201234943.584d88e8.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 01, 2004 at 11:49:43PM +0900, Yoichi Yuasa wrote:

> This patch had added tlbwr hazard for NEC VR4100.
> Please apply this patch to 2.6.

Thanks, applied.

  Ralf
