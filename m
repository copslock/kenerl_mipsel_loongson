Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Apr 2006 22:29:12 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:16263 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133683AbWDZV3B (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Apr 2006 22:29:01 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k3QLSw3c021339;
	Wed, 26 Apr 2006 22:28:58 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k3QLSvZF021338;
	Wed, 26 Apr 2006 22:28:57 +0100
Date:	Wed, 26 Apr 2006 22:28:57 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Win Treese <treese@acm.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix branch emulation for floating-point exceptions
Message-ID: <20060426212857.GA21114@linux-mips.org>
References: <9B3838B8-4950-40BA-B386-0D45819C168D@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9B3838B8-4950-40BA-B386-0D45819C168D@acm.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@denk.linux-mips.net.mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 26, 2006 at 03:22:22PM -0400, Win Treese wrote:

> In the branch emulation for floating-point exceptions,  
> __compute_return_epc
> must determine for bc1f et al which condition code bit to test. This  
> is based on bits <4:2>
> of the rt field. The switch statement to distinguish bc1f et al needs  
> to use only the
> two low bits of rt, but the old code tests on the whole rt field.  
> This patch masks off
> the proper bits.

One of those bugs that have managed to hide since day one ...  I applied
your fix but: your mailer is converting tabs to spaces, so patch is going
to barf on the patch ...

> Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
                                                         ^^^^^^^^^^^^^

... and it would also break long lines ...

  Ralf
