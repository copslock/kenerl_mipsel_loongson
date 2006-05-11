Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 May 2006 18:33:33 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:6039 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133503AbWEKQdZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 11 May 2006 18:33:25 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k4BGXPDM030081;
	Thu, 11 May 2006 17:33:25 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k4BGXPAo030080;
	Thu, 11 May 2006 17:33:25 +0100
Date:	Thu, 11 May 2006 17:33:25 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Damian Dimmich <djd20@kent.ac.uk>
Cc:	linux-mips@linux-mips.org
Subject: Re: seeq driver possibly broken in 2.6.17-rc3-g8f3468ed?
Message-ID: <20060511163325.GB26812@linux-mips.org>
References: <200605111400.42087.djd20@kent.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605111400.42087.djd20@kent.ac.uk>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 11, 2006 at 02:00:42PM +0100, Damian Dimmich wrote:

> Hello,
> 
> I've just compiled a fresh 2.6.17-rc3-g8f3468ed kernel from linux-mips git for 
> my indigo2.  The network card seems to have gone wonky, while the seeq driver 
> loads fine:

Can you try to git bisect to find the bug?  The reason for this bug
isn't obvious; the Indy network driver was last changed last October.

   Ralf
