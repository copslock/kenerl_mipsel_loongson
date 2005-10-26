Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Oct 2005 14:54:38 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:13323 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133446AbVJZNyV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Oct 2005 14:54:21 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9QDsF0l014622;
	Wed, 26 Oct 2005 14:54:15 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9QDsEX8014621;
	Wed, 26 Oct 2005 14:54:14 +0100
Date:	Wed, 26 Oct 2005 14:54:14 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	kernel coder <lhrkernelcoder@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Porting oprofile to 2.4.32 kernel
Message-ID: <20051026135414.GD3161@linux-mips.org>
References: <f69849430510260234p7370d51ahdbf6b80603fc7066@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f69849430510260234p7370d51ahdbf6b80603fc7066@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 26, 2005 at 02:34:07AM -0700, kernel coder wrote:

>    i'm trying to port oprofile on 2.4.32 kernel running on MIPS
> board.From where can i  get the patch for other boards so that i can
> make a head start by using that patch as a guide.

Oprofile for 2.4 is considered a lost cause on any architecture and I
guess I'd rather do something sensible like ironing snowflakes than porting
it at this stage where funeral eulogies for 2.4 are already being
written ;-)

  Ralf
