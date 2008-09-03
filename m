Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Sep 2008 17:02:37 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:53225 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28790828AbYICQCf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Sep 2008 17:02:35 +0100
Received: from localhost (p2165-ipad202funabasi.chiba.ocn.ne.jp [222.146.73.165])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 07B94B699; Thu,  4 Sep 2008 01:02:30 +0900 (JST)
Date:	Thu, 04 Sep 2008 01:02:29 +0900 (JST)
Message-Id: <20080904.010229.108120775.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 4/6] TXx9: Add TX4939 SoC support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <48BE6137.1090008@ru.mvista.com>
References: <1220275361-5001-4-git-send-email-anemo@mba.ocn.ne.jp>
	<48BE6137.1090008@ru.mvista.com>
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
X-archive-position: 20411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 03 Sep 2008 14:04:39 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
>    At last. Cool. I know this SoC has IDE controller. Planning on 
> submitting a driver?

Yes, but I'm wondering whether it is worth to submit before converting
to ata driver.  It seems the drivers/ide in in deep
cleanup/refactoring state.  (linux-next contains 100 patches from
Bartlomiej!)

Do you think a new ide driver will be accepted?

---
Atsushi Nemoto
