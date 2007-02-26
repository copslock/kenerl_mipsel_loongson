Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Feb 2007 20:08:37 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:21738 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28639723AbXBZUId (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Feb 2007 20:08:33 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id B32A83EC9; Mon, 26 Feb 2007 12:07:52 -0800 (PST)
Message-ID: <45E33E13.7010007@ru.mvista.com>
Date:	Mon, 26 Feb 2007 23:07:47 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ralf@linux-mips.org, jeff@garzik.org,
	michal.k.k.piotrowski@gmail.com, pg@cs.stanford.edu,
	ahennessy@mvista.com, netdev@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: possible bug in net/tc35815.c in linux-2.6.19
References: <45E031A3.806@googlemail.com>	<45E0B651.2050601@garzik.org>	<20070226102659.GA28439@linux-mips.org> <20070226.200554.125898248.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20070226.200554.125898248.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

> I know both MontaVista and CELF have new driver for the chip.  If
> anybody in MontaVista did not complain I can send CELF's one available
> at http://tree.celinuxforum.org/pubwiki/moin.cgi/PatchArchive.  (it

    Yeah, tc35815_1.c in our looks like the one in the CELF archive (what I 
didn't get is why they decided to keep both drivers around?)

> needs some changes for recent kernel, for example pt_regs removal, but
> it would be easy).

> Sergei?

    I think everybody would be just thankful. :-)
    There's quite a lot of other TX4938 patches that need pushing into 
Linux/MIPS -- unfortunetely, this hasn't been done by MV... :-<

> ---
> Atsushi Nemoto

    BTW, does RBTX4938 boot the recent kernels for you? If so, what .config 
are you using -- I'm afraid something's up with rbhma4500_defconfig?

WBR, Sergei
