Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Oct 2006 09:45:13 +0100 (BST)
Received: from topsns2.0.225.230.202.in-addr.arpa ([202.230.225.126]:61875
	"EHLO topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20039829AbWJYIpL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Oct 2006 09:45:11 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 25 Oct 2006 17:45:10 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 6725D418D8;
	Wed, 25 Oct 2006 17:45:07 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 5AB054180E;
	Wed, 25 Oct 2006 17:45:07 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k9P8j5W0095581;
	Wed, 25 Oct 2006 17:45:06 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 25 Oct 2006 17:45:04 +0900 (JST)
Message-Id: <20061025.174504.71086461.nemoto@toshiba-tops.co.jp>
To:	creideiki+linux-mips@ferretporn.se
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: Extreme system overhead on large IP27
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <6285.136.163.203.3.1161704681.squirrel@www.ferretporn.se>
References: <53979.136.163.203.3.1161698036.squirrel@www.ferretporn.se>
	<20061024140614.GB27800@linux-mips.org>
	<6285.136.163.203.3.1161704681.squirrel@www.ferretporn.se>
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
X-archive-position: 13094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 24 Oct 2006 17:44:41 +0200 (CEST), "Karl-Johan Karlsson" <creideiki+linux-mips@ferretporn.se> wrote:

> 2. Timekeeping is broken. The clock in /proc/driver/rtc seems correct, but
> the system clock advances at about 1/16 of real time.

Is this problem still happen if you disabled CONFIG_OPROFILE ?

> 3. When booting, the kernel started, did a bit of initialization,
> restarted, and did everything all over again, this time going all the way.

It is not a problem.  Your log is usual ERALY_PRINTK behaviour.

>    [17179569.184000] Linux version 2.6.19-rc3 (root@viggen) (gcc version
> 4.1.1 (Gentoo 4.1.1)) #2 SMP Tue Oct 24 16:49:51 CEST 2006
>    [17179569.184000] ARCH: SGI-IP27
...
>    [17179569.184000] Using 1.250 MHz high precision timer.

These lines are printed by initial console driver (ioc3).

>    [17179569.184000] Linux version 2.6.19-rc3 (root@viggen) (gcc version
> 4.1.1 (Gentoo 4.1.1)) #2 SMP Tue Oct 24 16:49:51 CEST 2006
>    [17179569.184000] ARCH: SGI-IP27

And rest are printed by standard console driver (8250).

---
Atsushi Nemoto
