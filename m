Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jul 2007 15:33:03 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:24045 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021851AbXGEOc6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Jul 2007 15:32:58 +0100
Received: from localhost (p8154-ipad202funabasi.chiba.ocn.ne.jp [222.146.79.154])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 630E5AE6B; Thu,  5 Jul 2007 23:32:54 +0900 (JST)
Date:	Thu, 05 Jul 2007 23:33:43 +0900 (JST)
Message-Id: <20070705.233343.88471693.anemo@mba.ocn.ne.jp>
To:	sadarul.firos@nestgroup.net
Cc:	linux-mips@linux-mips.org
Subject: Re: Glibc - Segmentation Fault
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <9A1299C7A40D7447A108107E951450CA01C9E087@MAIL-TVM.tvm.nestgroup.net>
References: <9A1299C7A40D7447A108107E951450CA01C9E087@MAIL-TVM.tvm.nestgroup.net>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 5 Jul 2007 10:04:25 +0530, "Sadarul Firos" <sadarul.firos@nestgroup.net> wrote:
> I'm performing continuous reboot test on a MIPS based board running
> linux-2.6.18/glibc-2.3.5/gcc-3.3.6. After several hours of rebooting
> (say after 80, purely random) I've observed Segmentation fault or
> Illegal instruction error while starting the udevd and ntpd programs
> during the startup. The error appears pretty much random, it doesn't
> usually take more than an hour or two to catch an instance of the
> Segfault.
...
> 11. Changed the order of invocation of the programs udevd and ntpd.
> Previously, in the init scripts, udevd was started first and ntpd was
> called somewhere near the last stage of init scripts. Now ntpd is
> started immediately after invoking udevd. Surprisingly, the frequency of
> appearing segfault was increased, ie previously it would take nearly 100
> reboots to observe a segfault, but now it would take nearly 10 reboots
> to observe a segfault!

I think all these implies some cache related issue (or hardware
issue).  I have seen such a strange errors (reserved instruction
exception, etc.) with a bit unstable power-supply.

Does your kernel based on vanilla 2.6.18?  It lacks some fixes related
D-cache aliasing.  It might be worth to try latest 2.6.18-stable or
master branch in linux-mips.org git tree.

---
Atsushi Nemoto
