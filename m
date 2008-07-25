Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2008 18:29:32 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:23692 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S28580582AbYGYR33 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 25 Jul 2008 18:29:29 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m6PHTKM4024112;
	Fri, 25 Jul 2008 10:29:20 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 25 Jul 2008 10:29:19 -0700
Received: from [128.224.143.5] ([128.224.143.5]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 25 Jul 2008 10:29:19 -0700
Message-ID: <488A0D6E.8090105@windriver.com>
Date:	Fri, 25 Jul 2008 12:29:18 -0500
From:	Jason Wessel <jason.wessel@windriver.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] kgdb: kgdboc serial_txx9 I/O module
References: <20080725.234914.41630045.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080725.234914.41630045.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Jul 2008 17:29:19.0796 (UTC) FILETIME=[F885B740:01C8EE7B]
Return-Path: <jason.wessel@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason.wessel@windriver.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> Implement the serial polling hooks for the serial_txx9 uart for use
> with kgdboc.
>
>   

Looks fine to me.

I pulled this into the kgdb-next branch, which I am working with Ralf to
merge.

Thanks,
Jason.
