Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 May 2008 19:13:04 +0100 (BST)
Received: from host194-211-dynamic.20-79-r.retail.telecomitalia.it ([79.20.211.194]:28576
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S62064043AbYEASNB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 May 2008 19:13:01 +0100
Received: from casa ([192.168.2.34])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1JrdGz-0001mx-80; Thu, 01 May 2008 20:12:52 +0200
Subject: Re: undefined reference to `copy_siginfo_from_user32'
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	Christoph Hellwig <hch@lst.de>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20080429090039.GA16616@lst.de>
References: <20080428212327.47c703b6.giuseppe@eppesuigoccas.homedns.org>
	 <20080429090039.GA16616@lst.de>
Content-Type: text/plain
Date:	Thu, 01 May 2008 20:11:52 +0200
Message-Id: <1209665512.5605.0.camel@casa>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Il giorno mar, 29/04/2008 alle 11.00 +0200, Christoph Hellwig ha
scritto:
> On Mon, Apr 28, 2008 at 09:23:27PM +0200, Giuseppe Sacco wrote:
> > Hi list,
> > since a few days, whenever I try to recompile the latest kernel (from git) it always print this error message:
> 
> This should be fixed in mainline.  But the right fix would be to switch
> mips to the generic compat_ptrace.  And untested (and in fact even
> uncompiled) patch ontop of the copy_siginfo_to_user32 posted to the list
> a while ago is below to sketch how this should look like:

I cannot apply this patch to the latest kernel from git. Could you
provide a new one?

Thanks a lot,
Giuseppe Sacco
