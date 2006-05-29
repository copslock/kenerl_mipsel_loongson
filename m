Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 May 2006 08:45:12 +0200 (CEST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:55792 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133357AbWE2GpF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 May 2006 08:45:05 +0200
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 29 May 2006 15:45:03 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 903662020B;
	Mon, 29 May 2006 15:44:58 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 83C9120155;
	Mon, 29 May 2006 15:44:58 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k4T6iviX033231;
	Mon, 29 May 2006 15:44:58 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 29 May 2006 15:44:57 +0900 (JST)
Message-Id: <20060529.154457.27952799.nemoto@toshiba-tops.co.jp>
To:	mchitale@gmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: oprofile for mips 24k
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <d096a3ee0605282258y210244c7sbdf994d8c075a5e@mail.gmail.com>
References: <d096a3ee0605282258y210244c7sbdf994d8c075a5e@mail.gmail.com>
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
X-archive-position: 11590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 29 May 2006 11:28:06 +0530, "Mayuresh Chitale" <mchitale@gmail.com> wrote:
> But ps -aef shows oprofiled is not running.
> # ps -aef
...
> 
> Do we need to do some additional setup / init to get this working?
> Any experience/suggestion is welcome.

The oprofile requires bash.  If you were cross-compiling bash, please
check output of "kill -l".  If bash was not correctly cross-compiled,
a value of some signals might be wrong (ex. signal 10 is SIGUSR1 on
i386 but SIGBUS on MIPS).  The opcontrol send SIGUSR1/SIGUSR2 to
oprofiled.

---
Atsushi Nemoto
