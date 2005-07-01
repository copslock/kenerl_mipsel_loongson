Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 15:47:07 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:53191 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8226150AbVGAOqt>;
	Fri, 1 Jul 2005 15:46:49 +0100
Received: from drow by nevyn.them.org with local (Exim 4.51)
	id 1DoMmu-00080D-7B; Fri, 01 Jul 2005 10:46:40 -0400
Date:	Fri, 1 Jul 2005 10:46:40 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	"Stephen P. Becker" <geoman@gentoo.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Bryan Althouse <bryan.althouse@3phoenix.com>,
	'Linux/MIPS Development' <linux-mips@linux-mips.org>
Subject: Re: Seg fault when compiled with -mabi=64 and -lpthread
Message-ID: <20050701144640.GA30720@nevyn.them.org>
References: <20050630173409Z8226102-3678+735@linux-mips.org> <20050630202111.GC3245@linux-mips.org> <20050630210357.GA23456@nevyn.them.org> <42C46D85.9050104@gentoo.org> <20050701035105.GA9601@nevyn.them.org> <Pine.LNX.4.61L.0507010940280.30138@blysk.ds.pg.gda.pl> <20050701133910.GA24716@nevyn.them.org> <Pine.LNX.4.61L.0507011450180.30138@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0507011450180.30138@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 01, 2005 at 03:10:08PM +0100, Maciej W. Rozycki wrote:
>  Certainly -- I'm assuming you are ready for a pile of patches then?  
> Well, perhaps not that many, but I think I've got around four that should 
> go upstream.  I'll have a look if they apply cleanly.  None of them 
> addresses a problem with building though.

Sure - send them to me, or better yet, put them in bugzilla and make
sure you copy me.  I can't promise you timely response just now because
I'm about twelve feet under on this current project at work, but I'll
do everything I can.

We're going to have automated MIPS regression testing sometime this
year, too.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
