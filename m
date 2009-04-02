Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Apr 2009 14:20:00 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:61314 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20030654AbZDBNT3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Apr 2009 14:19:29 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n32DJP4W015174;
	Thu, 2 Apr 2009 15:19:26 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n32DJMkR015162;
	Thu, 2 Apr 2009 15:19:22 +0200
Date:	Thu, 2 Apr 2009 15:19:22 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@codesourcery.com>
Cc:	linux-mips@linux-mips.org, libc-ports@sourceware.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
Message-ID: <20090402131921.GA15021@linux-mips.org>
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Mar 01, 2009 at 12:12:25AM +0000, Maciej W. Rozycki wrote:

>  Here is code to implement the getcontext API for MIPS.  This glibc patch
> is sent to the linux-mips mailing list, because it makes use of an
> internal syscall which has not been designated as a part of the public
> ABI.  I am writing to request this syscall to become fixed as a part of
> the ABI or to seek for an alternative.  See below for the rationale.

Debuggers need to know about the stack frame and so it already has became
a part of the ABI, if we want or not.  You may recall the great pain I
went through to maintain compatibility in the past when changes were
necessary for example to support the DSP ASE.  But to some degree the
stackframe is a function of hardware development which I don't control
so I can only give a best effort type of guarantee ...

  Ralf
