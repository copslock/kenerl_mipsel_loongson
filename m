Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2008 20:33:16 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:34747 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28582943AbYCXUdM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 24 Mar 2008 20:33:12 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m2OKXBYp016310;
	Mon, 24 Mar 2008 20:33:11 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m2OKXBHo016308;
	Mon, 24 Mar 2008 20:33:11 GMT
Date:	Mon, 24 Mar 2008 20:33:11 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Larry Stefani <lstefani@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: SB1250 locking up in init on current 2.6.16 kernel
Message-ID: <20080324203311.GB15294@linux-mips.org>
References: <15031.81072.qm@web38802.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15031.81072.qm@web38802.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 24, 2008 at 07:00:15AM -0700, Larry Stefani wrote:

> I've been trying to upgrade from 2.6.16.18 to
> 2.6.16.60, but am seeing a hard lockup right before
> "INIT: version 2.78 booting" on my SB1250-based board.
> 
> I found a related discussion on the Debian mailing
> list:
> 
> http://groups.google.com/group/linux.debian.bugs.dist/browse_thread/thread/b7159ee25106c7f9
> 
> However, after applying Thiemo's patch to mark pages
> tainted by PIO IDE as dirty, the lockup still occurs.

It's a bug which should be fixed but nevertheless I can highly recommend
something like a SiliconImage SATA controller - the onboard PIO PATA
controller is so slow.

> I narrowed the file changes to
> 
>      arch/mips/mm/c-sb1.c
>      arch/mips/mm/cache.c
>      arch/mips/mm/init.c
>      include/asm-mips/cache-flush.h
>      include/asm-mips/page.h
> 
> between 2.6.16.27 and 2.6.16.29.  There was no
> 2.6.16.28 tarball posted on linux-mips.org, so I
> basically brought .27 to .29 until I found the
> offending files.

I've pushed the tag again so now there is a tarball.

If you need to track something like this you're probably best with
git bisect which should bring you right to the offending commit.

> Is anyone running a 2.6.16 kernel (after 2.6.16.27) on
> a SB1250-based board?

Later kernels do run on bcm1480 which is close enough.

  Ralf
