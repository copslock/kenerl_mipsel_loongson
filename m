Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Aug 2007 05:38:29 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:63514 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20024032AbXHXEiU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Aug 2007 05:38:20 +0100
Received: by mo.po.2iij.net (mo30) id l7O4awcY094119; Fri, 24 Aug 2007 13:36:58 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox300) id l7O4auSf028666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 24 Aug 2007 13:36:57 +0900
Date:	Fri, 24 Aug 2007 13:36:56 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: Tulip driver broken on Cobalt RaQ1 in 2.6
Message-Id: <20070824133656.4163c577.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20070823203757.GA25971@deprecation.cyrius.com>
References: <20070823203757.GA25971@deprecation.cyrius.com>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Thu, 23 Aug 2007 22:37:57 +0200
Martin Michlmayr <tbm@cyrius.com> wrote:

> We have Debian users who happily used 2.4.27 on their Cobalt Raq1 and
> Qube 2700.  However, since we moved to 2.6 these machines stopped
> working.  I found out that the network driver (tulip) is no longer
> working on these machines.  Today I tried to track down when this
> started to happen but I couldn't find a 2.6 release where it actually
> worked.
> 
> The 2.4.27 release we have is based on Peter Horton's patches from
> http://www.colonel-panic.org/cobalt-mips/  Today I tested current git,
> and 2.6.18 (which work out of the box), as well as 2.6.12-rc2 and
> 2.6.16-rc1 with Peter's patches.  In all of these releases, network
> would work fine on a RaQ2, but not on a RaQ1.  I'm not sure what
> information to report because I found nothing obvious.  In 2.4.27, we
> get:

What error occurs on Raq1?

> Galileo: PCI retry count exceeded (06.0)

I cannot find this line in current git.
Do you apply any patch for Debian kernel?

Yoichi
