Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Jan 2003 03:35:55 +0000 (GMT)
Received: from 12-234-88-56.client.attbi.com ([IPv6:::ffff:12.234.88.56]:61328
	"EHLO localhost.localdomain") by linux-mips.org with ESMTP
	id <S8225200AbTAZDfy>; Sun, 26 Jan 2003 03:35:54 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.12.5/8.12.5) with ESMTP id h0Q3ZUOf004377
	for <linux-mips@linux-mips.org>; Sat, 25 Jan 2003 19:35:30 -0800
Received: (from lindahl@localhost)
	by localhost.localdomain (8.12.5/8.12.5/Submit) id h0Q3ZTBb004375
	for linux-mips@linux-mips.org; Sat, 25 Jan 2003 19:35:29 -0800
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Sat, 25 Jan 2003 19:35:29 -0800
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux-mips@linux-mips.org
Subject: Re: [PATCH 2.5] FPU
Message-ID: <20030126033529.GA4296@greglaptop.attbi.com>
Mail-Followup-To: linux-mips@linux-mips.org
References: <Pine.LNX.4.21.0301260251300.15950-100000@melkor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0301260251300.15950-100000@melkor>
User-Agent: Mutt/1.4i
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1221
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

On Sun, Jan 26, 2003 at 02:58:09AM +0100, Vivien Chappelier wrote:

> 	At various places in the 2.5 kernel, the fpu is accessed in
> kernel mode with CU1 not set, causing an unexpected exception.

Vivien,

One good way to start with 2.5 bugs is to compare the code to the 2.4
kernel. Often you can see places where bugs were fixed in 2.4 but the
fixes were not also made to the equivalent 2.5 code. This will keep
2.4 and 2.5 as close as possible, just like we want to keep the 64-bit
and 32-bit kernels as close as possible.

-- greg
