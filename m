Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2008 13:47:31 +0100 (BST)
Received: from NaN.false.org ([208.75.86.248]:32132 "EHLO nan.false.org")
	by ftp.linux-mips.org with ESMTP id S62074288AbYGBMrZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 2 Jul 2008 13:47:25 +0100
Received: from nan.false.org (localhost [127.0.0.1])
	by nan.false.org (Postfix) with ESMTP id 91CAB982C3;
	Wed,  2 Jul 2008 12:47:23 +0000 (GMT)
Received: from caradoc.them.org (22.svnf5.xdsl.nauticom.net [209.195.183.55])
	by nan.false.org (Postfix) with ESMTP id 3FD8398243;
	Wed,  2 Jul 2008 12:47:22 +0000 (GMT)
Received: from drow by caradoc.them.org with local (Exim 4.69)
	(envelope-from <drow@caradoc.them.org>)
	id 1KE1k2-00043n-6W; Wed, 02 Jul 2008 08:47:22 -0400
Date:	Wed, 2 Jul 2008 08:47:22 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Yoriko Komatsuzaki <yoriko@sm.sony.co.jp>,
	Chris Friesen <cfriesen@nortel.com>
Cc:	libc-ports <libc-ports@sourceware.org>, linux-mips@linux-mips.org
Subject: Re: do-lookup.h regarding to mips/dlsym and libstdc++
Message-ID: <20080702124722.GA15301@caradoc.them.org>
References: <483AF8BC.7020603@nortel.com> <20080129132739.5D6B.YORIKO@sm.sony.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <483AF8BC.7020603@nortel.com> <20080129132739.5D6B.YORIKO@sm.sony.co.jp>
User-Agent: Mutt/1.5.17 (2008-05-11)
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 29, 2008 at 01:32:20PM +0900, Yoriko Komatsuzaki wrote:
> Because even though UNDEF symbol is found, 
> it can process as global symbol for the rare occasion.
> 
> This phenomena is showed only in mips. When libstdc++ is linked in
> proior libc, the malloc's entry in libstdc++ MIPS.stubs table seemed to
> be recognized as the malloc global symbol ...
> 
> How do you feel about it?

On Mon, May 26, 2008 at 11:51:56AM -0600, Chris Friesen wrote:
> On MIPS, the DEFAULT returns the address of this libraries undefined  
> symbol for the extern and NEXT returns our external procedure.  Putting  
> in a second RTLD_NEXT call returned the real sigaction address.
>
> This worked for most procedures we are looking for. However, during  
> booting, we have an app that uses a specific library which has an extern  
> for sigaction as well and now in the preloaded code we need a fourth call 
> to dlsym to skip that one.

Hi folks,

This bug is fixed as a by-product of support for non-PIC MIPS
executables.  Either Richard's patch or CodeSourcery's, applied to
glibc, should suffice.  It'll be another week or two at least before
they're applied to CVS, but in the mean time you can find them here:

http://sourceware.org/ml/binutils/2008-06/msg00280.html
http://sourceware.org/ml/binutils/2008-07/msg00008.html

-- 
Daniel Jacobowitz
CodeSourcery
