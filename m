Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Dec 2004 14:28:32 +0000 (GMT)
Received: from pD9562F66.dip.t-dialin.net ([IPv6:::ffff:217.86.47.102]:60435
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225204AbULOO22>; Wed, 15 Dec 2004 14:28:28 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iBFESHba029560;
	Wed, 15 Dec 2004 15:28:17 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iBFESHZB029559;
	Wed, 15 Dec 2004 15:28:17 +0100
Date: Wed, 15 Dec 2004 15:28:17 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: show_stack, show_trace does not work for other process
Message-ID: <20041215142817.GE29222@linux-mips.org>
References: <20041210.141226.01918307.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041210.141226.01918307.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Dec 10, 2004 at 02:12:26PM +0900, Atsushi Nemoto wrote:

> On kernel 2.6, SysRq-T (show_task()) can not show correct stack dump
> because show_stack() ignores an 'task' argument.  Here is a patch.  I
> fixed show_trace too.

Thanks,  applied.

  Ralf
