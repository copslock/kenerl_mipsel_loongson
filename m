Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2003 02:21:57 +0100 (BST)
Received: from p508B6FF8.dip.t-dialin.net ([IPv6:::ffff:80.139.111.248]:62938
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225239AbTGBBVz>; Wed, 2 Jul 2003 02:21:55 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h621LsDB010683;
	Wed, 2 Jul 2003 03:21:54 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h621LsUn010682;
	Wed, 2 Jul 2003 03:21:54 +0200
Date: Wed, 2 Jul 2003 03:21:54 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Vince Bridgers <vince_bridgers@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Au1500 Event and Performance Counters
Message-ID: <20030702012154.GA8530@linux-mips.org>
References: <20030630214641.36770.qmail@web41412.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030630214641.36770.qmail@web41412.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 30, 2003 at 02:46:41PM -0700, Vince Bridgers wrote:

> Has anyone used the Au1x00 performance event counter
> register in CP0 (Register 25 - where it says AMD will
> provide a list of the valid units and events when you
> ask them) ? 
> 
> Are they the same as some other MIPS processor that
> defines the events in their databook?

The MIPS32 spec to which the Au1x00 complies defines the structure and
interface of performance counters.  It does not define which events
the counters count.  Some non-MIPS32/64 processors also have slightly
different performance counter implementations.  The R10000 and R12000
performance counters values are pretty similar.

  Ralf
