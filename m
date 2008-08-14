Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Aug 2008 22:31:45 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:654
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S28596932AbYHNVbi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 14 Aug 2008 22:31:38 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m7ELVb8N008807;
	Thu, 14 Aug 2008 22:31:37 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m7ELVYuW008804;
	Thu, 14 Aug 2008 22:31:34 +0100
Date:	Thu, 14 Aug 2008 22:31:34 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Laird <daniel.j.laird@nxp.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [QUERY]: Website issues
Message-ID: <20080814213134.GA4914@linux-mips.org>
References: <1218698940.5012.1.camel@lnx32dtp04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1218698940.5012.1.camel@lnx32dtp04>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Aug 14, 2008 at 08:29:00AM +0100, Daniel Laird wrote:

> I am having issues viewing the linux-mips GIT repository from a web
> browser.  I am sure that this used to work but at the moment all my
> bookmarks are failing:
> http://git.linux-mips.org/ -> An Apache Test Page
> http://git.linux-mips.org/pub/scm/upstream-akpm.git -> Not found
> 
> Etc, is there a problem or have all my bookmarks got messed up?

Though it would be logic to do so git.linux-mips.org doesn't provide any
web services.  The reason why I originally introduced this hostname was
that I needed another IP address to run git-cvsserver.  I should probably
run git-related web services on that hostname and turn
www.linux-mips.org/git into a forward to it, something like that.

  Ralf
