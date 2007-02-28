Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2007 18:57:38 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:47281 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039406AbXB1S5g (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Feb 2007 18:57:36 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1SIvT1f021118;
	Wed, 28 Feb 2007 18:57:30 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1SIvSfb021117;
	Wed, 28 Feb 2007 18:57:28 GMT
Date:	Wed, 28 Feb 2007 18:57:28 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, sshtylyov@ru.mvista.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH] Fix broken RBTX4927 support in ne.c
Message-ID: <20070228185728.GA16562@linux-mips.org>
References: <20070301.012223.129448787.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070301.012223.129448787.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 01, 2007 at 01:22:23AM +0900, Atsushi Nemoto wrote:

> There are some ifdefs for RBTX4927, but need some more bits.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Longer term I think NE2000 will need to support platform_devices.  It's
been used too widely in too creative ways and we don't want all the
clutter to deal with that in ne.c.

  Ralf
