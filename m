Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2007 16:02:42 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:22206 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28573849AbXARQCk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Jan 2007 16:02:40 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0IG3eVH006549;
	Thu, 18 Jan 2007 16:03:40 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0IG3dQZ006548;
	Thu, 18 Jan 2007 16:03:39 GMT
Date:	Thu, 18 Jan 2007 16:03:38 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	akpm@osdl.org
Subject: Re: [PATCH] Make CARDBUS_MEM_SIZE and CARDBUS_IO_SIZE customizable
Message-ID: <20070118160338.GA6343@linux-mips.org>
References: <20070119.002346.74752797.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070119.002346.74752797.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 19, 2007 at 12:23:46AM +0900, Atsushi Nemoto wrote:

> CARDBUS_MEM_SIZE was increased to 64MB on 2.6.20-rc2, but larger size
> might result in allocation failure for the reserving itself on some
> platforms (for example typical 32bit MIPS).  Make it (and
> CARDBUS_IO_SIZE too) customizable for such platforms.

Patch looks technically ok to me, so feel free to add my Acked-by: line.

The grief I have with this sort of patch is that this kind of detailed
technical knowledge should not be required by a mortal configuring the
Linux kernel.

  Ralf
