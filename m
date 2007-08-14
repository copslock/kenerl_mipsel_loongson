Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2007 15:11:52 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:30147 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023237AbXHNOLn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 14 Aug 2007 15:11:43 +0100
Received: from localhost (p6135-ipad28funabasi.chiba.ocn.ne.jp [220.107.205.135])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6140E7E40; Tue, 14 Aug 2007 23:11:40 +0900 (JST)
Date:	Tue, 14 Aug 2007 23:12:55 +0900 (JST)
Message-Id: <20070814.231255.74753150.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Use generic NTP code for all MIPS platforms
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <46C0A83B.2090003@gmail.com>
References: <46C07F36.1070308@gmail.com>
	<20070814.020229.29578157.anemo@mba.ocn.ne.jp>
	<46C0A83B.2090003@gmail.com>
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
X-archive-position: 16179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 13 Aug 2007 20:51:39 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> Well a more general question could be how is the RTC class layer
> supposed to interact with the kernel ?
> 
> Should RTC class layer implement a general service to update/read the
> RTC, IOW should it implement {read,update}_persistent_clock() ?

Some difficulties are:

* timekeeping subsystem calls {read,update}_persistent_clock() with
  irq-disabled.  But most RTC class routines might sleep.

* RTC class can have multiple RTCs on the system.

* There are already some conflicting features in RTC class ---
  rtc_suspend and rtc_resume try to adjust the wall clock.

* IIRC Some people said "NTP sync can be done all in userland" ;-)


Does anybody know if there was "general consensus" on this topic?

---
Atsushi Nemoto
