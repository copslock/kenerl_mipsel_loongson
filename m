Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Dec 2004 21:43:57 +0000 (GMT)
Received: from pD956258C.dip.t-dialin.net ([IPv6:::ffff:217.86.37.140]:23211
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224989AbULFVnx>; Mon, 6 Dec 2004 21:43:53 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iB6Lhpkt004550;
	Mon, 6 Dec 2004 22:43:51 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iB6Lhk57004474;
	Mon, 6 Dec 2004 22:43:46 +0100
Date: Mon, 6 Dec 2004 22:43:46 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Manish Lachwani <mlachwani@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Ocelot-3 supports 256 MB memory
Message-ID: <20041206214346.GA1182@linux-mips.org>
References: <20041206212720.GA11390@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041206212720.GA11390@prometheus.mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 06, 2004 at 01:27:20PM -0800, Manish Lachwani wrote:

> Small patch for Ocelot-3 to support 256 MB memory. Please apply ...

Does this board really have a fixed memory configuration?  If not we should
use a safe default, the minimum configuration.  Or probe which obviously
is the right thing to do.

  Ralf
