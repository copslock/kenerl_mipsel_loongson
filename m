Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 May 2004 19:19:09 +0100 (BST)
Received: from p508B6E02.dip.t-dialin.net ([IPv6:::ffff:80.139.110.2]:48932
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226066AbUEZSOn>; Wed, 26 May 2004 19:14:43 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i4QIEgxV015729
	for <linux-mips@linux-mips.org>; Wed, 26 May 2004 20:14:42 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i4QIEgS3015728
	for linux-mips@linux-mips.org; Wed, 26 May 2004 20:14:42 +0200
Resent-Message-Id: <200405261814.i4QIEgS3015728@fluff.linux-mips.net>
Date: Wed, 26 May 2004 19:55:06 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][4/14] vr41xx: add fixup-tb0219.c
Message-ID: <20040526175506.GD30047@linux-mips.org>
References: <20040527005104.40832d5f.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040527005104.40832d5f.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4.1i
Resent-From: ralf@linux-mips.org
Resent-Date: Wed, 26 May 2004 20:14:42 +0200
Resent-To: linux-mips@linux-mips.org
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5188
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 27, 2004 at 12:51:04AM +0900, Yoichi Yuasa wrote:

> fixup-tb0219.c was added.
> 
> Please apply to v2.6 CVS tree.

Applying this one.

The plan is that this function eventually will be replaced by a table-driven
approach, so better don't use it for doing anything else than just
returning the interrupt number.

  Ralf
