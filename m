Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Feb 2005 10:09:29 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:26392 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224944AbVBYKJO>; Fri, 25 Feb 2005 10:09:14 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j1PA2mH5012851;
	Fri, 25 Feb 2005 10:02:49 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j1PA2msi012845;
	Fri, 25 Feb 2005 10:02:48 GMT
Date:	Fri, 25 Feb 2005 10:02:47 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Tsang-Ren Chang <690190029@s90.tku.edu.tw>
Cc:	linux-mips@linux-mips.org
Subject: Re: ADM5120: Data bus error
Message-ID: <20050225100247.GA10193@linux-mips.org>
References: <421DF870.30708@s90.tku.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421DF870.30708@s90.tku.edu.tw>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 24, 2005 at 11:53:20PM +0800, Tsang-Ren Chang wrote:

> Hi,
> I'm porting linux-2.4.27 on adm5120 (MIPS 4Kc core).
> But when I copied /sbin/pppd , It crashed.

In addition to what Maciej said I'd like to add that bus errors are often
signalled asynchronously, so the machine state in a register dump very
often has no relation to the actual problem.

  Ralf
