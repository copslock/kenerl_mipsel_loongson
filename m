Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Feb 2005 12:51:25 +0000 (GMT)
Received: from p3EE07C4A.dip.t-dialin.net ([IPv6:::ffff:62.224.124.74]:53276
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224942AbVBIMvK>; Wed, 9 Feb 2005 12:51:10 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j19Cp9F2027931;
	Wed, 9 Feb 2005 13:51:09 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j19Cp5vQ027930;
	Wed, 9 Feb 2005 13:51:05 +0100
Date:	Wed, 9 Feb 2005 13:51:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: copy_from_user_page/copy_to_user_page fix
Message-ID: <20050209125105.GA27875@linux-mips.org>
References: <20050209.184947.30439119.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050209.184947.30439119.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 09, 2005 at 06:49:47PM +0900, Atsushi Nemoto wrote:

> Yet another dcache aliasing problem.
> 
> Since access_process_vm() in kernel 2.6 does not call
> flush_cache_page(), it seems copy_to_user_page()/copy_from_user_page()
> should flush data cache to resolve aliasing.
> 
> Without this fix, gdb will not work correctly.  Could you apply?

I'm going to apply this because it's a correct fix; the temporary mapping
strategy as we've discussed for the dup_mmap problem would be preferable.

  Ralf
