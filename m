Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2008 21:29:26 +0100 (BST)
Received: from NaN.false.org ([208.75.86.248]:52710 "EHLO nan.false.org")
	by ftp.linux-mips.org with ESMTP id S23872641AbYGBU3U (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 2 Jul 2008 21:29:20 +0100
Received: from nan.false.org (localhost [127.0.0.1])
	by nan.false.org (Postfix) with ESMTP id 634D0982C3;
	Wed,  2 Jul 2008 20:29:15 +0000 (GMT)
Received: from caradoc.them.org (22.svnf5.xdsl.nauticom.net [209.195.183.55])
	by nan.false.org (Postfix) with ESMTP id 41F6098243;
	Wed,  2 Jul 2008 20:29:15 +0000 (GMT)
Received: from drow by caradoc.them.org with local (Exim 4.69)
	(envelope-from <drow@caradoc.them.org>)
	id 1KE8x0-0006gN-5n; Wed, 02 Jul 2008 16:29:14 -0400
Date:	Wed, 2 Jul 2008 16:29:14 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	binutils@sourceware.org, gcc@gcc.gnu.org,
	linux-mips@linux-mips.org, rdsandiford@googlemail.com
Subject: Re: RFC: Adding non-PIC executable support to MIPS
Message-ID: <20080702202914.GA17986@caradoc.them.org>
Mail-Followup-To: binutils@sourceware.org, gcc@gcc.gnu.org,
	linux-mips@linux-mips.org, rdsandiford@googlemail.com
References: <87y74pxwyl.fsf@firetop.home> <20080701202236.GA1534@caradoc.them.org> <87zlp149ot.fsf@firetop.home> <20080702120829.GA12595@caradoc.them.org> <87abh0m56d.fsf@firetop.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87abh0m56d.fsf@firetop.home>
User-Agent: Mutt/1.5.17 (2008-05-11)
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 02, 2008 at 08:55:54PM +0100, Richard Sandiford wrote:
> The size of the header and first 0x10000 stubs would be the same.
> I think it would also preserve the resolver interface while removing
> the need for the extra-large .plts.  The only incompatibility I can
> see would be that objdump on older executables would not get the
> foo@plt symbols right for large indices.
> 
> OTOH, perhaps you could argue that the extra complication of the
> two PLT entries doesn't count for much given that the code is
> already written.  It's just an idea.

Your version looks fine to me, it's ABI-preserving, the PLT entries
still work for MIPS I and still have the same runtime cost when not
resolving.  I like it - thanks!

I'm not worried about making people upgrade objdump, either.

-- 
Daniel Jacobowitz
CodeSourcery
