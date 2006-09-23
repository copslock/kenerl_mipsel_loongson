Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Sep 2006 15:50:05 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:9933 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038812AbWIWOuD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 23 Sep 2006 15:50:03 +0100
Received: from localhost (p1054-ipad29funabasi.chiba.ocn.ne.jp [221.184.68.54])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C5F08948B; Sat, 23 Sep 2006 23:49:57 +0900 (JST)
Date:	Sat, 23 Sep 2006 23:52:03 +0900 (JST)
Message-Id: <20060923.235203.126573787.anemo@mba.ocn.ne.jp>
To:	imipak@yahoo.com
Cc:	linux-mips@linux-mips.org
Subject: Re: 64K page patch hiccup on SB1
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060923002427.64159.qmail@web31504.mail.mud.yahoo.com>
References: <20060923002427.64159.qmail@web31504.mail.mud.yahoo.com>
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
X-archive-position: 12634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 22 Sep 2006 17:24:27 -0700 (PDT), Jonathan Day <imipak@yahoo.com> wrote:
> Hi, tried using the 64K page patch with the latest GIT
> repository. Everything runs fine. It brings up all the
> networking code OK, the bonding driver warning is
> perfectly normal, and then it throws a wobbly. Any
> ideas?
...
> Call
> Trace:[<ffffffff80102d38>][<ffffffff8010a020>][<ffffffff80126dec>][<ffffffff8010a020>][<ffffffff80102d38>][<ffffffff801273e0>][<ffffffff8012a7dc>][<fff]

Enable CONFIG_KALLSYMS.  Then you can see more useful information.

---
Atsushi Nemoto
