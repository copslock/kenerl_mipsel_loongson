Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Sep 2003 07:37:45 +0100 (BST)
Received: from mtaw6.prodigy.net ([IPv6:::ffff:64.164.98.56]:57812 "EHLO
	mtaw6.prodigy.net") by linux-mips.org with ESMTP
	id <S8225217AbTIGGhN>; Sun, 7 Sep 2003 07:37:13 +0100
Received: from [10.2.2.60] (adsl-63-194-214-47.dsl.snfc21.pacbell.net [63.194.214.47])
	by mtaw6.prodigy.net (8.12.9/8.12.3) with ESMTP id h876auZi004939;
	Sat, 6 Sep 2003 23:36:56 -0700 (PDT)
Subject: Re: New to MIPS Linux
From: Pete Popov <ppopov@mvista.com>
To: "prabhakark@contechsoftware.com" <prabhakark@contechsoftware.com>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <01C3746B.02106F20.prabhakark@contechsoftware.com>
References: <01C3746B.02106F20.prabhakark@contechsoftware.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 06 Sep 2003 23:38:22 -0700
Message-Id: <1062916704.1237.1.camel@localhost.localdomain>
Mime-Version: 1.0
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Sat, 2003-09-06 at 04:35, Prabhakar Kalasani wrote:
> Hi all,
> I'm new to MIPS Linux , I got to port Linux on pb1500 evalution board,
> I got 2.4.22 kernel from http://www.kernel.org/ and toolchain from http://www.linux-mips.org/
> anybody can help me out how to compile and port the kernel.

The latest stable mips kernels are on linux-mips.org, not kernel.org.
The Pb1500 is fully supported and stable in linux-mips.org, so use that
source tree and you won't have to "port" anything.

Pete
