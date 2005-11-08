Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2005 18:44:30 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:2584 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8135889AbVKHSoN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Nov 2005 18:44:13 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jA8IjMbk012127;
	Tue, 8 Nov 2005 18:45:22 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jA8IjL7p012119;
	Tue, 8 Nov 2005 18:45:22 GMT
Date:	Tue, 8 Nov 2005 18:45:21 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: git and tags...
Message-ID: <20051108184521.GB2689@linux-mips.org>
References: <cda58cb80511080249w7d902821n@mail.gmail.com> <20051108110134.GA2689@linux-mips.org> <cda58cb80511080925l2d441604i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80511080925l2d441604i@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 08, 2005 at 06:25:06PM +0100, Franck wrote:

> OK, so tags have been renamed into "linux-2.6.x". Why not using the
> same mainline name convention (v2.6.x) ?

The same reason that some people like blue and others prefer green ;-)

> I have another question (which is the first one in my previous email),
> how can I make my working tree a kernel version 2.6.9 for example ?

git-read-tree $(cat .git/refs/tags/linux-2.6.9)
git-checkout-index -f -a -u -q

> And the last question related to mips git repository, why does kernel
> v2.2, v2.4, v2.6 are in the same repository ? Why not seperate
> different major version of the kernel in a seperate repository ?

The extra space consumption for all these historic versions in a
compressed git repository is extremly little.

  Ralf
