Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 13:43:26 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:5148 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8134393AbWASNjl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Jan 2006 13:39:41 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0JDhVeo007151;
	Thu, 19 Jan 2006 13:43:33 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0J0ot9M008371;
	Thu, 19 Jan 2006 00:50:55 GMT
Date:	Thu, 19 Jan 2006 00:50:55 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mark Mason <mason@broadcom.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [patch] power-down linkage fix
Message-ID: <20060119005055.GF3337@linux-mips.org>
References: <20060117200407.GC19531@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060117200407.GC19531@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 17, 2006 at 12:04:07PM -0800, Mark Mason wrote:

> The last git import created a dependency on pm_power_down.  Borrowing from
> ARM the following patch provides definitions of the needed variables in
> order for kernels to link.

Our ages old _machine_power_off function pointer really already does what
pm_power_down does, so I've just renamed that variable.

  Ralf
