Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2003 21:14:50 +0100 (BST)
Received: from 66-122-194-201.ded.pacbell.net ([IPv6:::ffff:66.122.194.201]:57985
	"EHLO localhost.localdomain") by linux-mips.org with ESMTP
	id <S8225223AbTDQUOt>; Thu, 17 Apr 2003 21:14:49 +0100
Received: from localhost.localdomain (greglaptop [127.0.0.1])
	by localhost.localdomain (8.12.8/8.12.5) with ESMTP id h3HKF3hv001633
	for <linux-mips@linux-mips.org>; Thu, 17 Apr 2003 13:15:03 -0700
Received: (from lindahl@localhost)
	by localhost.localdomain (8.12.8/8.12.8/Submit) id h3HKF3dI001631
	for linux-mips@linux-mips.org; Thu, 17 Apr 2003 13:15:03 -0700
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Thu, 17 Apr 2003 13:15:03 -0700
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux-mips@linux-mips.org
Subject: Re: your mail
Message-ID: <20030417201503.GF1345@greglaptop.internal.keyresearch.com>
Mail-Followup-To: linux-mips@linux-mips.org
References: <56BEF0DBC8B9D611BFDB00508B5E2634102F10@TLEXMAIL> <20030417111710.F1642@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030417111710.F1642@mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

On Thu, Apr 17, 2003 at 11:17:10AM -0700, Jun Sun wrote:

> It really depends on the applications.  The biggest gain from 64bit,
> other than the obviously bigger address space, is 64bit data
> manipulation.  A single 64bit instruction (add/sub/...) is carried
> out by several instructions in 32bit.

A big gain is the increased # of registers and better calling
sequence. Everyone sees that, not just people who want to use 64-bit
integers. At the moment you need to run the 64-bit kernel -- and the
new binutils & glibc -- in order to get n32 programs to work.

-- greg
