Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Sep 2003 11:10:45 +0100 (BST)
Received: from p508B5748.dip.t-dialin.net ([IPv6:::ffff:80.139.87.72]:6832
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225379AbTIJKKn>; Wed, 10 Sep 2003 11:10:43 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h8AAAaLT012151;
	Wed, 10 Sep 2003 12:10:36 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h8AAAZ0I012150;
	Wed, 10 Sep 2003 12:10:35 +0200
Date: Wed, 10 Sep 2003 12:10:35 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] simulate_llsc in v2.4
Message-ID: <20030910101035.GA11844@linux-mips.org>
References: <20030910183852.2e8248d5.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910183852.2e8248d5.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 10, 2003 at 06:38:52PM +0900, Yoichi Yuasa wrote:

> I found a differece between v2.4 and v2.6 in simulate_llsc().
> 
> Please apply this patch to v2.4 tree.

Okay - you missed the same thing also needs to be applied to the 64-bit
kernel.

  Ralf
