Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Oct 2004 04:41:34 +0100 (BST)
Received: from pD9562DA8.dip.t-dialin.net ([IPv6:::ffff:217.86.45.168]:57713
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224772AbUJ0Dla>; Wed, 27 Oct 2004 04:41:30 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i9R3fP3Z022029;
	Wed, 27 Oct 2004 05:41:25 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i9R3fOUj022028;
	Wed, 27 Oct 2004 05:41:24 +0200
Date: Wed, 27 Oct 2004 05:41:24 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Thomas Petazzoni <thomas.petazzoni@enix.org>
Cc: uclibc@uclibc.org, linux-mips@linux-mips.org
Subject: Re: [buildroot] Compilation failure on MIPS with 2.6.9.1 kernel headers
Message-ID: <20041027034124.GD14668@linux-mips.org>
References: <417E1747.9020603@enix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417E1747.9020603@enix.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 26, 2004 at 11:22:15AM +0200, Thomas Petazzoni wrote:

> As I understand it, #ifdef __KERNEL__ conditionnal is missing, leading 
> to SOCK_* being visible to the userspace, and conflicting with libc 
> definitions.

In general the policy is to avoid the use of kernel headers in userspace
but glibc is one of those exceptions which we still tollerate ...

  Ralf
