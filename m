Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Dec 2004 15:44:17 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:6492
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225241AbULIPoM>; Thu, 9 Dec 2004 15:44:12 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CcQSc-0001kH-00; Thu, 09 Dec 2004 16:44:06 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CcQSb-000326-00; Thu, 09 Dec 2004 16:44:05 +0100
Date: Thu, 9 Dec 2004 16:44:05 +0100
To: Pete Popov <ppopov@embeddedalley.com>
Cc: linux-mips@linux-mips.org
Subject: Re: fyi, syscall() somehow broken...
Message-ID: <20041209154405.GB8419@rembrandt.csv.ica.uni-stuttgart.de>
References: <1102602117.28707.49.camel@shswe.inso.tuwien.ac.at> <41B86E7D.3000609@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B86E7D.3000609@embeddedalley.com>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6619
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Pete Popov wrote:
> 
> >jfyi, something broke w/ the following commit... most notably 'ls -l'
> >doesn't work anymore... reverting to yesterdays cvs state fixes the
> >issues... ;-)

Confirmed on a SGI Indy with 32bit kernel. sys_quotactl seems to be
broken, while the rest of the system appears to work well.
I'll have a look.

> >Working file: arch/mips/kernel/scall32-o32.S
> >head: 1.18
> >revision 1.18
> >date: 2004/12/08 14:32:30;  author: ths;  state: Exp;  lines: +85 -102
> >Fix indirect syscalls for o32, improve syscall performance a bit,
> >and general code cleanup.
> 
> Someone reported this problem on the Au1x boards. Anyone else seeing 
> the problem on other MIPS32 boards?

The changed code is fairly hardware independent.


Thiemo
