Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2003 23:28:29 +0000 (GMT)
Received: from p508B60ED.dip.t-dialin.net ([IPv6:::ffff:80.139.96.237]:9691
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226052AbTKYX2E>; Tue, 25 Nov 2003 23:28:04 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hAPNS3A0013172
	for <linux-mips@linux-mips.org>; Wed, 26 Nov 2003 00:28:03 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hAPNS3eu013162
	for linux-mips@linux-mips.org; Wed, 26 Nov 2003 00:28:03 +0100
Resent-Message-Id: <200311252328.hAPNS3eu013162@dea.linux-mips.net>
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hAPNOdA0013060;
	Wed, 26 Nov 2003 00:24:39 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hAPNOd54013059;
	Wed, 26 Nov 2003 00:24:39 +0100
Date: Wed, 26 Nov 2003 00:24:39 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] 2.4, head: PAGE_SHIFT changes break glibc
Message-ID: <20031125232439.GE11047@linux-mips.org>
References: <Pine.LNX.4.55.0311211550270.32551@jurand.ds.pg.gda.pl> <20031121185035.GC8318@linux-mips.org> <Pine.LNX.4.55.0311212021420.32551@jurand.ds.pg.gda.pl> <Pine.LNX.4.55.0311251623180.6716@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0311251623180.6716@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Resent-From: ralf@linux-mips.org
Resent-Date: Wed, 26 Nov 2003 00:28:03 +0100
Resent-To: linux-mips@linux-mips.org
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 25, 2003 at 04:27:49PM +0100, Maciej W. Rozycki wrote:

>  After rebuilding glibc (2.2.5) with the patch applied, the following
> program:
> 
> #include <stdio.h>
> #include <unistd.h>
> 
> int main(void)
> {
> 	printf("%u\n", getpagesize());
> 	return 0;
> }
> 
> prints "4096" if dynamically linked and "65536" if statically linked on my
> system, as expected.

Guess we'll need a solution along the lines of
unix/sysv/linux/sparc/sparc32/getpagesize.c then ...

  Ralf
