Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2006 01:37:24 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:22456 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20039024AbWLGBhU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Dec 2006 01:37:20 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 7 Dec 2006 10:37:19 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id F172D41D16;
	Thu,  7 Dec 2006 10:37:15 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id E6C6D20427;
	Thu,  7 Dec 2006 10:37:15 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id kB71bEW0089330;
	Thu, 7 Dec 2006 10:37:14 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 07 Dec 2006 10:37:14 +0900 (JST)
Message-Id: <20061207.103714.25910613.nemoto@toshiba-tops.co.jp>
To:	ashlesha@kenati.com
Cc:	sshtylyov@ru.mvista.com, linux-mips@linux-mips.org
Subject: Re: Cant analyze prologue code
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1165450403.6516.28.camel@sandbar.kenati.com>
References: <1165434577.6516.8.camel@sandbar.kenati.com>
	<45772013.70907@ru.mvista.com>
	<1165450403.6516.28.camel@sandbar.kenati.com>
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
X-archive-position: 13386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 06 Dec 2006 16:13:23 -0800, Ashlesha Shintre <ashlesha@kenati.com> wrote:
> However, I now get a "Cant analyze prologue code at 80294aec." error!
> 
> Any remedies/suggestions for the same?

Please look at this thread:

http://www.linux-mips.org/archives/linux-mips/2004-09/msg00123.html

Final patch is:

http://www.linux-mips.org/archives/linux-mips/2004-10/msg00312.html

And actual commit is:

http://www.linux-mips.org/git?p=linux.git;a=commitdiff;h=dc953df1ba5526814982676f47580c8e1bcdbfeb

---
Atsushi Nemoto
