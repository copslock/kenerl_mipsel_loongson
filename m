Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Dec 2004 13:22:04 +0000 (GMT)
Received: from p3EE2BA30.dip.t-dialin.net ([IPv6:::ffff:62.226.186.48]:57895
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225228AbULPNWA>; Thu, 16 Dec 2004 13:22:00 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iBGDLnPr013820;
	Thu, 16 Dec 2004 14:21:49 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iBGDLneU013819;
	Thu, 16 Dec 2004 14:21:49 +0100
Date: Thu, 16 Dec 2004 14:21:49 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: minor asm-mips/sigcontext.h fix
Message-ID: <20041216132149.GA13753@linux-mips.org>
References: <20041216.193758.130241219.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216.193758.130241219.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 16, 2004 at 07:37:58PM +0900, Atsushi Nemoto wrote:

> The asm-mips/sigcontext.h uses '#ifdef __KERNEL__' to not export
> sigcontext32 to userland.  It includes linux/types.h but it is needed
> just for sigcontext32, so it would be better to hide from userland
> too.
> 
> Here is a patch.  Could you apply?

Applied but changed to include <linux/posix_types.h> only.

  Ralf
