Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Dec 2004 06:25:39 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:42343
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224907AbULJGZa>; Fri, 10 Dec 2004 06:25:30 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CceDU-0000wr-00; Fri, 10 Dec 2004 07:25:24 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CceDT-0005PK-00; Fri, 10 Dec 2004 07:25:23 +0100
Date: Fri, 10 Dec 2004 07:25:23 +0100
To: Pete Popov <ppopov@embeddedalley.com>
Cc: linux-mips@linux-mips.org
Subject: Re: fyi, syscall() somehow broken...
Message-ID: <20041210062523.GE8419@rembrandt.csv.ica.uni-stuttgart.de>
References: <1102602117.28707.49.camel@shswe.inso.tuwien.ac.at> <41B86E7D.3000609@embeddedalley.com> <20041209154405.GB8419@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041209154405.GB8419@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Pete Popov wrote:
> > 
> > >jfyi, something broke w/ the following commit... most notably 'ls -l'
> > >doesn't work anymore... reverting to yesterdays cvs state fixes the
> > >issues... ;-)
> 
> Confirmed on a SGI Indy with 32bit kernel. sys_quotactl seems to be
> broken, while the rest of the system appears to work well.
> I'll have a look.

I just committed a fix.


Thiemo
