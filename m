Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Oct 2005 15:37:04 +0100 (BST)
Received: from smtp102.biz.mail.mud.yahoo.com ([68.142.200.237]:18301 "HELO
	smtp102.biz.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133651AbVJ1Ogp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Oct 2005 15:36:45 +0100
Received: (qmail 40879 invoked from network); 28 Oct 2005 14:36:18 -0000
Received: from unknown (HELO ?192.168.1.102?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp102.biz.mail.mud.yahoo.com with SMTP; 28 Oct 2005 14:36:18 -0000
Subject: Re: AU1200 fb patch
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Matej Kupljen <matej.kupljen@ultra.si>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <1130500084.4785.10.camel@localhost.localdomain>
References: <1130500084.4785.10.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Fri, 28 Oct 2005 07:36:21 -0700
Message-Id: <1130510181.7228.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Fri, 2005-10-28 at 13:48 +0200, Matej Kupljen wrote:
> Hi
> 
> This patch fixes compilation error for au1200fb.c to replace
> io_remap_page_range with the io_remap_pfn_range.
> Also it adds new panel setting.

Thanks. There are some other small cleanups I have to do so I'll take
care of it at the same time.

Pete
