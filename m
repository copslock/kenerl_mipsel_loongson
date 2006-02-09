Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Feb 2006 16:20:44 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:18888 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133489AbWBIQUZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Feb 2006 16:20:25 +0000
Received: from localhost (p5155-ipad30funabasi.chiba.ocn.ne.jp [221.184.80.155])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 03EBF9BDB; Fri, 10 Feb 2006 01:26:16 +0900 (JST)
Date:	Fri, 10 Feb 2006 01:25:59 +0900 (JST)
Message-Id: <20060210.012559.89066702.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix build error by removal of obsoleted au1x00_uart
 driver.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060209154959.GA3558@linux-mips.org>
References: <20060210.004302.96686142.anemo@mba.ocn.ne.jp>
	<20060209154959.GA3558@linux-mips.org>
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
X-archive-position: 10383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 9 Feb 2006 15:49:59 +0000, Ralf Baechle <ralf@linux-mips.org> said:

ralf> You were seconds to late, I already checked in an identical
ralf> patch :)

Oh I see.  It seems linux-2.6.15.git is a bit behind linux.git ;-)


BTW, linux-2.6.15.git repository is somewhat broken, isn't it?  When I
pull using git protocol just after rsync, I got following error.  I'm
using git 1.1.6.

$ git-pull rsync://ftp.linux-mips.org/pub/scm/linux-2.6.15.git
receiving file list ... done

sent 107 bytes  received 162 bytes  41.38 bytes/sec
total size is 64135739  speedup is 238422.82
Already up-to-date.
$ git-pull git://ftp.linux-mips.org/pub/scm/linux-2.6.15.git
error: Could not read 91483db9b01b547ae9cc45c8c98b217642acb40a
error: Could not read 826eeb53a6f264842200d3311d69107d2eb25f5e
Already up-to-date.
$

---
Atsushi Nemoto
