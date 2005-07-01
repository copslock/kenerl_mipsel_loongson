Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 14:39:39 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:56800 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8226147AbVGANjY>;
	Fri, 1 Jul 2005 14:39:24 +0100
Received: from drow by nevyn.them.org with local (Exim 4.51)
	id 1DoLja-0006Rz-O8; Fri, 01 Jul 2005 09:39:10 -0400
Date:	Fri, 1 Jul 2005 09:39:10 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	"Stephen P. Becker" <geoman@gentoo.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Bryan Althouse <bryan.althouse@3phoenix.com>,
	'Linux/MIPS Development' <linux-mips@linux-mips.org>
Subject: Re: Seg fault when compiled with -mabi=64 and -lpthread
Message-ID: <20050701133910.GA24716@nevyn.them.org>
References: <20050630173409Z8226102-3678+735@linux-mips.org> <20050630202111.GC3245@linux-mips.org> <20050630210357.GA23456@nevyn.them.org> <42C46D85.9050104@gentoo.org> <20050701035105.GA9601@nevyn.them.org> <Pine.LNX.4.61L.0507010940280.30138@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0507010940280.30138@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 01, 2005 at 09:49:39AM +0100, Maciej W. Rozycki wrote:
>  And you may need external patches as glibc is (effectively) not 
> maintained.

Shall I just stop trying, then?  I'm getting tired of arguing with you
about this.

For the twentieth time: I am doing everything I can to keep glibc HEAD
building for MIPS.  I do not have the time or energy to deal with
Roland's restrictive stable branch rules, so I can not help with 2.3.5.
But if you encounter a problem on HEAD, let me know, and I will either
fix it myself or (if you've got a patch) pester people relentlessly
until it is applied.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
