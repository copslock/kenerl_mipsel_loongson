Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2004 11:14:15 +0000 (GMT)
Received: from p508B7260.dip.t-dialin.net ([IPv6:::ffff:80.139.114.96]:39177
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225299AbUA3LOO>; Fri, 30 Jan 2004 11:14:14 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0UBEDex018092;
	Fri, 30 Jan 2004 12:14:13 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0UBE8HH018091;
	Fri, 30 Jan 2004 12:14:08 +0100
Date: Fri, 30 Jan 2004 12:14:08 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Russell Berkoff <rberkoff@pioneer-pra.com>
Cc: linux-mips@linux-mips.org
Subject: Re: /proc/net/softnet_stat
Message-ID: <20040130111408.GA15657@linux-mips.org>
References: <4018B5C6.6080109@pioneer-pra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4018B5C6.6080109@pioneer-pra.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 28, 2004 at 11:27:02PM -0800, Russell Berkoff wrote:

> netdev_rx_stat[...].total++; in net/core/dev.c.
> 
> Appears to be redundant increment in: netif_rx() and netif_receive_skb().

This affects generic networking code; send related postings preferably
to netdev@oss.sgi.com.  On this list here it's probably not going to be
read by the responsible people.

  Ralf
