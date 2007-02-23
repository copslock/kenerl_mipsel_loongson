Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Feb 2007 15:14:19 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:64202 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038879AbXBWPOO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 23 Feb 2007 15:14:14 +0000
Received: from localhost (p8193-ipad03funabasi.chiba.ocn.ne.jp [219.160.88.193])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 08AA4B792; Sat, 24 Feb 2007 00:12:50 +0900 (JST)
Date:	Sat, 24 Feb 2007 00:12:49 +0900 (JST)
Message-Id: <20070224.001249.92583553.anemo@mba.ocn.ne.jp>
To:	kevink@mips.com
Cc:	ralf@linux-mips.org, sathesh_edara2003@yahoo.co.in,
	rajat.noida.india@gmail.com, linux-mips@linux-mips.org
Subject: Re: unaligned access
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <005701c7573f$6aca0890$10eca8c0@grendel>
References: <20070223030645.GA1349@linux-mips.org>
	<20070223.123630.92584856.nemoto@toshiba-tops.co.jp>
	<005701c7573f$6aca0890$10eca8c0@grendel>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 23 Feb 2007 09:18:59 +0100, "Kevin D. Kissell" <kevink@mips.com> wrote:
> One thing about the current, system-call based interface that is kind-of
> cool, and different from both what you propose and what was described
> as being implemented for ARM, is that Ralf's scheme is per-thread.
> I don't know if that power really outweighs the ease-of-use aspect
> of being able to manipuate it from the shell command line, but it's 
> not something to throw away lightly.  I have no issues with moving
> the log data, should it be resurrected, from syslog to /sys/kernel/whatever,
> though.

Well, /sys/kernel method can coexist with per-thread FIXADE method.
We can use /sys/kernel (or something) to change default action.  And
sysmips() or something can be used to override it.

---
Atsushi Nemoto
