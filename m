Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Mar 2008 18:56:57 +0100 (CET)
Received: from oss.sgi.com ([192.48.170.157]:31376 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S1102444AbYCZP0K (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Mar 2008 16:26:10 +0100
Received: from p549F5321.dip.t-dialin.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m2QBVUTG016060
	for <linux-mips@linux-mips.org>; Wed, 26 Mar 2008 06:18:55 -0700
Received: from relay01.mx.bawue.net ([193.7.176.67]:45013 "EHLO
	relay01.mx.bawue.net") by lappi.linux-mips.net with ESMTP
	id S1101373AbYCYPhv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Mar 2008 16:37:51 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 025F548917;
	Tue, 25 Mar 2008 16:37:49 +0100 (CET)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1JeBDf-0007Jj-GW; Tue, 25 Mar 2008 15:37:47 +0000
Date:	Tue, 25 Mar 2008 15:37:47 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	Larry Stefani <lstefani@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: SB1250 locking up in init on current 2.6.16 kernel
Message-ID: <20080325153747.GB15685@networkno.de>
References: <15031.81072.qm@web38802.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15031.81072.qm@web38802.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Larry Stefani wrote:
> Hi,
> 
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
> 
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

Please learn about git bisect (git-bisect start; git-bisect good;
git-bisect bad) and use it to isolate the offending commit.


Thiemo
