Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 May 2003 22:51:53 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:2737
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225226AbTEPVvu>; Fri, 16 May 2003 22:51:50 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 19Gn7F-001Ikb-00
	for linux-mips@linux-mips.org; Fri, 16 May 2003 23:51:49 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19Gn7D-0000PA-00
	for <linux-mips@linux-mips.org>; Fri, 16 May 2003 23:51:47 +0200
Date: Fri, 16 May 2003 23:51:47 +0200
To: linux-mips@linux-mips.org
Subject: Re: cvs glibc bug?
Message-ID: <20030516215147.GT8833@rembrandt.csv.ica.uni-stuttgart.de>
References: <200305162333.34877.benmen@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200305162333.34877.benmen@gmx.de>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Benjamin Menküc wrote:
> Hi,
> 
> is this a bug?

You could argue so.

[snip]
> ../sysdeps/unix/sysv/linux/sigtimedwait.c: In function `do_sigtimedwait':
> ../sysdeps/unix/sysv/linux/sigtimedwait.c:44: `SI_TKILL' undeclared (first use 
> in this function)

SI_TKILL is new in glibc and not yet ported to mips.


Thiemo
