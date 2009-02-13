Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Feb 2009 13:44:11 +0000 (GMT)
Received: from smtp3-g21.free.fr ([212.27.42.3]:6625 "EHLO smtp3-g21.free.fr")
	by ftp.linux-mips.org with ESMTP id S21102778AbZBMNoJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Feb 2009 13:44:09 +0000
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0803C8180A9;
	Fri, 13 Feb 2009 14:44:03 +0100 (CET)
Received: from [213.228.1.107] (sakura.staff.proxad.net [213.228.1.107])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D6E3F8181B0;
	Fri, 13 Feb 2009 14:44:00 +0100 (CET)
Subject: Re: [PATCH] MIPS: Allocate exception vector on 64 KiB boundary
From:	Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:	"David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	David Daney <ddaney@caviumnetworks.com>
In-Reply-To: <FF038EB85946AA46B18DFEE6E6F8A28982392E@xmb-rtp-218.amer.cisco.com>
References: <FF038EB85946AA46B18DFEE6E6F8A28982392E@xmb-rtp-218.amer.cisco.com>
Content-Type: text/plain
Organization: Freebox
Date:	Fri, 13 Feb 2009 14:44:00 +0100
Message-Id: <1234532640.711.63.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Content-Transfer-Encoding: 7bit
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips


On Fri, 2009-01-30 at 13:43 -0500, David VomLehn (dvomlehn) wrote:

> Fix problem with code that incorrectly modifies ebase.
> 
> Commit 566f74f6b2f8b85d5b8d6caaf97e5672cecd3e3e had a change that
> incorrectly
> modified ebase. This backs out the lines that modified ebase and then
> modified

I confirm this commit prevents my 4kec board from booting.

My c0_ebase is set to 0x90000000.

In trap_init() ebase is first set to CAC_BASE => 0x80000000, then
0x90000000 after adding c0_ebase offset.

set_uncached_handler() starts with uncached_ebase sets to
KSEG1ADDR(ebase) => 0xb0000000, which is already the correct value, but
it then add the c0_ebase offset again => 0xc0000000 => boom.

-- 
Maxime
