Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2004 18:32:19 +0000 (GMT)
Received: from p508B6B36.dip.t-dialin.net ([IPv6:::ffff:80.139.107.54]:40482
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225566AbUATScT>; Tue, 20 Jan 2004 18:32:19 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0KIW6ex006298;
	Tue, 20 Jan 2004 19:32:06 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0KIVvE8006288;
	Tue, 20 Jan 2004 19:31:57 +0100
Date: Tue, 20 Jan 2004 19:31:57 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Pavel Kiryukhin <savl@dev.rtsoft.ru>
Cc: linux-mips@linux-mips.org
Subject: Re: __MIPSEL__ in sys32_rt_sigtimedwait
Message-ID: <20040120183157.GB5495@linux-mips.org>
References: <400D6877.1000105@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400D6877.1000105@dev.rtsoft.ru>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 20, 2004 at 08:42:15PM +0300, Pavel Kiryukhin wrote:

> Hi all,
> my question - does endiannes matters in sigset translation in 
> sys32_rt_sigtimedwait (arch/mips/signal32.c)?

Think about where bit 33 ends for a big endian machine with an without
the conversion.

  Ralf
