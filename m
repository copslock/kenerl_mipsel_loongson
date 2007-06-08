Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jun 2007 06:16:52 +0100 (BST)
Received: from out002.atlarge.net ([129.41.63.60]:37014 "EHLO
	out002.atlarge.net") by ftp.linux-mips.org with ESMTP
	id S20021638AbXFHFQu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 8 Jun 2007 06:16:50 +0100
Received: from hpmailfe-01.atlarge.net ([10.100.60.156]) by out002.atlarge.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 8 Jun 2007 00:13:05 -0500
Received: from localhost ([213.250.36.225]) by hpmailfe-01.atlarge.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 8 Jun 2007 00:13:05 -0500
Date:	Fri, 8 Jun 2007 07:16:41 +0200
From:	Domen Puncer <domen.puncer@telargo.com>
To:	kernel coder <lhrkernelcoder@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: tcp/ip stack question
Message-ID: <20070608051641.GE23294@moe.telargo.com>
References: <f69849430706070550o76850458w777ee8531be8cfa3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f69849430706070550o76850458w777ee8531be8cfa3@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-OriginalArrivalTime: 08 Jun 2007 05:13:05.0990 (UTC) FILETIME=[B2471660:01C7A98B]
Return-Path: <domen.puncer@telargo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@telargo.com
Precedence: bulk
X-list: linux-mips

On 07/06/07 05:50 -0700, kernel coder wrote:
> hi,
>       I am recieveing the packet on eth1 and want to send it through eth2.

Then you picked the wrong list, try netdev or netfilter one.

Have you looked at bridging and/or netfilter, because provide similar
functionality that you require.


	Domen
