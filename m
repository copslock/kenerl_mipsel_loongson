Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Nov 2005 16:09:08 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:58122 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133572AbVKOQIr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Nov 2005 16:08:47 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jAFGAgF8026228;
	Tue, 15 Nov 2005 16:10:42 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jAFGAgN3026227;
	Tue, 15 Nov 2005 16:10:42 GMT
Date:	Tue, 15 Nov 2005 16:10:42 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Cc:	Linux MIPS Development <linux-mips@linux-mips.org>
Subject: Re: JMR3927
Message-ID: <20051115161042.GE15733@linux-mips.org>
References: <20051114114615.GA6186@linux-mips.org> <437A043B.6040604@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437A043B.6040604@ru.mvista.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 15, 2005 at 06:52:27PM +0300, Sergei Shtylylov wrote:

> >Does anybody still care about the JMR3927 board?
> 
>    At least there's no 2.6 release planned for this board by Montavista.
> 
> > The board code is pretty
> >badly broken.   It's also currently the only user of the TX3927 in the 
> >tree.
> 
>   I saw you were busy with TX3927 maintenance recently... Looks like this 
>   is another chance to remind you of my old patch:

It's as much as I can do without a JMR3927 or other TX3927 board.  For
example the arch/mips/pci/fixup-jmr3927.c looks like it requires the
attention that actually knows the platform.  Until then it'll have to
stay broken ...

  Ralf
