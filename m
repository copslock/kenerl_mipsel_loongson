Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Apr 2006 16:52:58 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:49887 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133461AbWDNPwu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 14 Apr 2006 16:52:50 +0100
Received: from localhost (p1197-ipad209funabasi.chiba.ocn.ne.jp [58.88.112.197])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 2CF09A4EE; Sat, 15 Apr 2006 01:04:55 +0900 (JST)
Date:	Sat, 15 Apr 2006 01:05:18 +0900 (JST)
Message-Id: <20060415.010518.126141918.anemo@mba.ocn.ne.jp>
To:	geoffrey.levand@am.sony.com
Cc:	linux-mips@linux-mips.org
Subject: Re: tx49 Ether problems
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <443FC1D8.8010500@am.sony.com>
References: <443FC1D8.8010500@am.sony.com>
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
X-archive-position: 11100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 14 Apr 2006 08:38:00 -0700, Geoff Levand <geoffrey.levand@am.sony.com> wrote:
> I seem to get a lot of problems with an nfs root fs
> on tx4937 board.  I haven't looked at it closely yet,
> but I guess its some problem with the ne2000 driver.
> I wanted to know if you know anything about this.

Please look at:

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20060226.230541.75185772.anemo%40mba.ocn.ne.jp

With a quick glance of ne.c, it seems ei_status.stop_page should be
changed to 0x60 on the board.  Please confirm its value.

---
Atsushi Nemoto
