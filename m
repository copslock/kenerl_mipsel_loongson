Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2004 08:51:04 +0000 (GMT)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:24567 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225242AbUAIIvB>;
	Fri, 9 Jan 2004 08:51:01 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id RAA21557;
	Fri, 9 Jan 2004 17:50:58 +0900 (JST)
Received: 4UMDO00 id i098owJ03213; Fri, 9 Jan 2004 17:50:58 +0900 (JST)
Received: 4UMRO00 id i098ovN08185; Fri, 9 Jan 2004 17:50:57 +0900 (JST)
	from rally.montavista.co.jp (sonicwall.montavista.co.jp [202.232.97.131]) (authenticated)
Date: Fri, 9 Jan 2004 17:50:57 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: Re: [PATCH][2.4] cache workaround for VR4131
Message-Id: <20040109175057.5774b2b7.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20040109070615.GA1576@linux-mips.org>
References: <20040109022554.49768c94.yuasa@hh.iij4u.or.jp>
	<20040109070615.GA1576@linux-mips.org>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

On Fri, 9 Jan 2004 08:06:15 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Fri, Jan 09, 2004 at 02:25:54AM +0900, Yoichi Yuasa wrote:
> 
> > I made a patch for cache workaround of VR4131.
> > This patch moves cache workaround to common part from board dependence part.
> > 
> > Please apply this patch.
> 
> Applied - but please keep arch/mips/mm/c-r4k.c and arch/mips64/mm/c-r4k.c
> in sync; the same applies to many other files that are identical in both
> mips and mips64.

Oops, I'm sorry.

and Thanks,

Yoichi
