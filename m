Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jan 2008 10:25:35 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:43193 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28578555AbYAKKYq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 Jan 2008 10:24:46 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0BAOPPK008486;
	Fri, 11 Jan 2008 10:24:27 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0ALoUSG020892;
	Thu, 10 Jan 2008 21:50:30 GMT
Date:	Thu, 10 Jan 2008 21:50:30 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Vitaly Wool <vitalywool@gmail.com>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: pnx8xxx: move to clocksource
Message-ID: <20080110215030.GA20875@linux-mips.org>
References: <4786273D.7010006@gmail.com> <478645FD.2090708@ru.mvista.com> <20080110162744.GA16880@linux-mips.org> <acd2a5930801100848o36935a1al44c6b16eb746dcff@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acd2a5930801100848o36935a1al44c6b16eb746dcff@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 10, 2008 at 07:48:57PM +0300, Vitaly Wool wrote:

> Sergei, I decided not to mix whitespace cleanups and the clocksource
> changes. I'll come up with the whitespace/tab fixups soon arranging it
> as a separate patch.

Generally that's a good approach - but for lines which are modified anyway
I see no reason not to clean the whitespace stuff anyway.

  Ralf
