Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2004 00:49:54 +0000 (GMT)
Received: from p508B7F35.dip.t-dialin.net ([IPv6:::ffff:80.139.127.53]:32900
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226180AbULBAtu>; Thu, 2 Dec 2004 00:49:50 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iB20nnqK007171;
	Thu, 2 Dec 2004 01:49:49 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iB20niEv007170;
	Thu, 2 Dec 2004 01:49:44 +0100
Date: Thu, 2 Dec 2004 01:49:44 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Manish Lachwani <mlachwani@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] 2.4: Preemption fixes for Broadcom DMA Page operations
Message-ID: <20041202004944.GB5187@linux-mips.org>
References: <20041202003308.GA13085@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041202003308.GA13085@prometheus.mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 01, 2004 at 04:33:08PM -0800, Manish Lachwani wrote:

> The attached patch implements preempt_disable/preempt_enable around the SB1 DMA
> page operations. Please review ...

We don't support preemption in 2.4 -> bitbucket.

  Ralf
