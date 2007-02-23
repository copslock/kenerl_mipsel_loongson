Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Feb 2007 03:37:01 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:36685 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20038865AbXBWDg4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Feb 2007 03:36:56 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 23 Feb 2007 12:36:55 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 841ED41ECF;
	Fri, 23 Feb 2007 12:36:31 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 70C5C20474;
	Fri, 23 Feb 2007 12:36:31 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l1N3aUW0035256;
	Fri, 23 Feb 2007 12:36:31 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 23 Feb 2007 12:36:30 +0900 (JST)
Message-Id: <20070223.123630.92584856.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	kevink@mips.com, sathesh_edara2003@yahoo.co.in,
	rajat.noida.india@gmail.com, linux-mips@linux-mips.org
Subject: Re: unaligned access
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070223030645.GA1349@linux-mips.org>
References: <80178.32924.qm@web7903.mail.in.yahoo.com>
	<01fc01c75693$195858b0$10eca8c0@grendel>
	<20070223030645.GA1349@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 23 Feb 2007 03:06:45 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> There used to be a configuration option to allow logging which was a
> leftover from the times when I implemented the unaligned emulation.  I
> did never find it useful later on, so I removed that in almost 9 years
> ago and nobody missed it since :-)
> 
> But I don't mind putting it back, controllable by sysctl if there is any
> demand for it.

Sometimes I want to know a value of unaligned_instructions variable,
to make sure nobody is causing such exceptions.  I just wanted to know
the statistics and did not want to control it, but showing name of the
process and PC would help to find out who is guilty.  I wonder if
anybody really want to handle the exception manually.

So how about this interface?

1. echo show > /sys/kernel/unaligned_action

Show register dump and processor name at each unaligned exception,
using show_regs() or someting.

2. echo quiet > /sys/kernel/unaligned_action

Siliently fixup unaligned exceptions.

3. cat /sys/kernel/unaligned_instructions

Print unaligned_instructions variable.


Creating files in /sys/kernel is fairly simple:

	subsys_create_file(&kernel_subsys, &foo_attr);

Any comments?
---
Atsushi Nemoto
