Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jan 2003 21:41:22 +0000 (GMT)
Received: from 66-122-194-201.ded.pacbell.net ([IPv6:::ffff:66.122.194.201]:19328
	"EHLO localhost.localdomain") by linux-mips.org with ESMTP
	id <S8225240AbTAVVlV>; Wed, 22 Jan 2003 21:41:21 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.12.5/8.12.5) with ESMTP id h0MLlbQE001119
	for <linux-mips@linux-mips.org>; Wed, 22 Jan 2003 13:47:38 -0800
Received: (from lindahl@localhost)
	by localhost.localdomain (8.12.5/8.12.5/Submit) id h0MLlbgM001117
	for linux-mips@linux-mips.org; Wed, 22 Jan 2003 13:47:37 -0800
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Wed, 22 Jan 2003 13:47:36 -0800
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux-mips@linux-mips.org
Subject: Re: debian's mips userland on mips64
Message-ID: <20030122214736.GA1094@wumpus.internal.keyresearch.com>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20030122073006.GF6262@pureza.melbourne.sgi.com> <20030122124540.A31505@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030122124540.A31505@sgi.com>
User-Agent: Mutt/1.4i
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

On Wed, Jan 22, 2003 at 12:45:40PM -0500, Christoph Hellwig wrote:

> I don't think so.  You should rather implement a sys32_ptrace and
> reference it in the 32bit syscall vector.  Look at the version in
> arch/ia64/ia32/sys_ia32.c for an example.

This works as long as you aren't doing n32 - at some point we'll have
a mature enough toolchain to do that, and we're going to need to hack
up sys32_ptrace to do the right thing with the bigger fp register file...

-- greg
