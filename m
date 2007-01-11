Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jan 2007 17:15:01 +0000 (GMT)
Received: from wf1.mips-uk.com ([194.74.144.154]:43456 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28581298AbXAKRO7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Jan 2007 17:14:59 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0BHBjup012808;
	Thu, 11 Jan 2007 17:11:45 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0BHBfdO012807;
	Thu, 11 Jan 2007 17:11:41 GMT
Date:	Thu, 11 Jan 2007 17:11:41 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Joseph S. Myers" <joseph@codesourcery.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Use compat_sys_pselect6
Message-ID: <20070111171138.GC23014@linux-mips.org>
References: <Pine.LNX.4.64.0701101228450.6217@digraph.polyomino.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701101228450.6217@digraph.polyomino.org.uk>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 10, 2007 at 12:30:50PM +0000, Joseph S. Myers wrote:

> The N32 and O32 pselect6 syscalls need to use compat_sys_pselect6 to
> translate arguments from 32-bit to 64-bit layout.

Thanks, applied.

  Ralf
