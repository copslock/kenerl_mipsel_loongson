Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 01:33:43 +0200 (CEST)
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:10998
	"EHLO irongate.swansea.linux.org.uk") by linux-mips.org with ESMTP
	id <S1122958AbSIDXdm>; Thu, 5 Sep 2002 01:33:42 +0200
Received: from irongate.swansea.linux.org.uk (localhost [127.0.0.1])
	by irongate.swansea.linux.org.uk (8.12.5/8.12.5) with ESMTP id g84NYN30004596;
	Thu, 5 Sep 2002 00:34:24 +0100
Received: (from alan@localhost)
	by irongate.swansea.linux.org.uk (8.12.5/8.12.5/Submit) id g84NYLur004593;
	Thu, 5 Sep 2002 00:34:21 +0100
X-Authentication-Warning: irongate.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: patch to kaweth.c to align IP header
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Quinn Jensen <jensenq@Lineo.COM>
Cc: linux-mips@linux-mips.org
In-Reply-To: <3D765072.60208@Lineo.COM>
References: <3D765072.60208@Lineo.COM>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 05 Sep 2002 00:34:21 +0100
Message-Id: <1031182461.3017.137.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 93
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Wed, 2002-09-04 at 19:26, Quinn Jensen wrote:
> All,
> 
> The Kawasaki LSI USB Ethernet driver was causing a crash
> in ipt_do_table() on mips because the address fields in
> the IP header were not word aligned.  Many (all?) other

You -must- handle alignment traps in the kernel for networking. The
network code assumes and relies on this property and there are plenty of
other ways to get misaligned datagrams through things like ip in ip.

> ethernet drivers do an skb_reserve of 2 to word align
> the address fields, and doing this in kaweth.c fixed
> my crash.

Its not the crash fix, its however right in the sense its a good
performance optimisation for most platforms
