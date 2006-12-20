Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Dec 2006 15:24:30 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:15555 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28583403AbWLTPYZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 Dec 2006 15:24:25 +0000
Received: from localhost (p3074-ipad206funabasi.chiba.ocn.ne.jp [222.145.77.74])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 0E0CFB63E; Thu, 21 Dec 2006 00:24:21 +0900 (JST)
Date:	Thu, 21 Dec 2006 00:24:20 +0900 (JST)
Message-Id: <20061221.002420.132303561.anemo@mba.ocn.ne.jp>
To:	danieljlaird@hotmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6.19 timer API changes
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <7987092.post@talk.nabble.com>
References: <7949125.post@talk.nabble.com>
	<20061220.021508.97296486.anemo@mba.ocn.ne.jp>
	<7987092.post@talk.nabble.com>
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
X-archive-position: 13490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 20 Dec 2006 01:37:17 -0800 (PST), Daniel Laird <danieljlaird@hotmail.com> wrote:
> Then I get  a normal startup.  i.e it boots fast (no 10second hang).  If I
> remove the write_c0_count then I get the 10 second hang.

I think Kevin's analysis about this 10 second hang is correct.  Then I
think my last patch will work as well.

> I have no idea if gettimeofday is broken.  ANy ideas on testing this? Is
> there a test package / application that will do this?  Before I write my own

Calling gettimeofday() continuously many times (at least some tick
periods) and calculates times between each call.  Those differences
should be almost same.  Of course you must run this program on very
idle system (or you must raise its priority).

---
Atsushi Nemoto
