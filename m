Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2002 23:41:19 +0000 (GMT)
Received: from p508B6DCE.dip.t-dialin.net ([IPv6:::ffff:80.139.109.206]:53913
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225311AbSLQXlS>; Tue, 17 Dec 2002 23:41:18 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gBHNfEr01528;
	Wed, 18 Dec 2002 00:41:14 +0100
Date: Wed, 18 Dec 2002 00:41:14 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "David D. McCoach" <ddm@wmi.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Unaligned Instruction Trap
Message-ID: <20021218004114.B1301@linux-mips.org>
References: <016401c2a5fb$0d636fb0$8b01a8c0@wmiddm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <016401c2a5fb$0d636fb0$8b01a8c0@wmiddm>; from ddm@wmi.com on Tue, Dec 17, 2002 at 01:35:19PM -0500
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 17, 2002 at 01:35:19PM -0500, David D. McCoach wrote:

> I have a problem with random "Unaligned Instruction Traps: during the boot
> process.  After rcS starts executing.
> I am using as Flash file system through a MTD driver.
> Does anyone have a thread for me pull on?

Not really.  The exception you're getting is really just the sympthom.
The actual problem is somewhere else ...

  Ralf
