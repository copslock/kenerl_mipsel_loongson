Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jul 2007 16:04:52 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:53953 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20021830AbXGFPEr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Jul 2007 16:04:47 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 43DF73EC9; Fri,  6 Jul 2007 08:04:14 -0700 (PDT)
Message-ID: <468E5A63.3050706@ru.mvista.com>
Date:	Fri, 06 Jul 2007 19:06:11 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Au1550 OSS sound driver
References: <20070706144043.GA23569@linux-mips.org>
In-Reply-To: <20070706144043.GA23569@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ralf Baechle wrote:

> Does anybody have convincing arguments why I should *NOT* delete this
> driver?  It's sitting since ages in the lmo repositories, as an OSS
> driver isn't in the shape to be merged upstream, so doesn't receive
> testing by the autobuilders, I don't think I've seen any testers.

    Erm, I'm afraid you have created some confusion by this mail: actually you 
meant sound/oss/au1550_i2s.c (maintained only in l-m tree), and not 
sound/oss/au1550_ac97.c (which is in mainline).

> Volunters to rewrite this for ALSA?

    Both drivers still should be rewritten.

>   Ralf

WBR, Sergei
