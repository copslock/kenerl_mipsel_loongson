Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2007 17:49:41 +0000 (GMT)
Received: from return.false.org ([66.207.162.98]:14004 "EHLO return.false.org")
	by ftp.linux-mips.org with ESMTP id S20022459AbXCNRtf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Mar 2007 17:49:35 +0000
Received: from return.false.org (localhost [127.0.0.1])
	by return.false.org (Postfix) with ESMTP id 23D654B267;
	Wed, 14 Mar 2007 12:48:59 -0500 (CDT)
Received: from caradoc.them.org (dsl093-172-095.pit1.dsl.speakeasy.net [66.93.172.95])
	by return.false.org (Postfix) with ESMTP id F34CF4B262;
	Wed, 14 Mar 2007 12:48:54 -0500 (CDT)
Received: from drow by caradoc.them.org with local (Exim 4.63)
	(envelope-from <drow@caradoc.them.org>)
	id 1HRXao-0006EE-IA; Wed, 14 Mar 2007 13:48:54 -0400
Date:	Wed, 14 Mar 2007 13:48:54 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Peter Watkins <pwatkins@sicortex.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Have sigpoll and sigio band field match glibc for n64
Message-ID: <20070314174854.GA23917@caradoc.them.org>
References: <1173469586997-git-send-email-pwatkins@sicortex.com> <20070310132423.GA1295@linux-mips.org> <20070313141951.GA3206@caradoc.them.org> <20070313164107.GA5004@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070313164107.GA5004@linux-mips.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 13, 2007 at 04:41:07PM +0000, Ralf Baechle wrote:
> On Tue, Mar 13, 2007 at 10:19:51AM -0400, Daniel Jacobowitz wrote:
> 
> > This will break the ABI only for uses of si_band and si_fd, and only
> > on n64.  Anyone see a reason why I shouldn't change glibc?
> > 
> > Ralf, as I mentioned on IRC, I've got bigger worries about siginfo.
> > Shouldn't n32 be using the same siginfo as o32?  It's got pointers in it.
> 
> Yes, you're right.  Will you cook up a patch?

I won't have time any time soon - my MIPS board isn't hooked up.
If no one has by the time I get around to it next, though, I'll try.

-- 
Daniel Jacobowitz
CodeSourcery
