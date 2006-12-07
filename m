Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2006 04:13:15 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:16369 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037675AbWLGENL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Dec 2006 04:13:11 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 7 Dec 2006 13:13:09 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id EE81F41E11;
	Thu,  7 Dec 2006 13:13:06 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id E392F41DBA;
	Thu,  7 Dec 2006 13:13:06 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id kB74D6W0089930;
	Thu, 7 Dec 2006 13:13:06 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 07 Dec 2006 13:13:06 +0900 (JST)
Message-Id: <20061207.131306.63741931.nemoto@toshiba-tops.co.jp>
To:	ashlesha@kenati.com
Cc:	sshtylyov@ru.mvista.com, linux-mips@linux-mips.org
Subject: Re: Cant analyze prologue code
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1165462754.6516.40.camel@sandbar.kenati.com>
References: <1165450403.6516.28.camel@sandbar.kenati.com>
	<20061207.103714.25910613.nemoto@toshiba-tops.co.jp>
	<1165462754.6516.40.camel@sandbar.kenati.com>
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
X-archive-position: 13389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 06 Dec 2006 19:39:14 -0800, Ashlesha Shintre <ashlesha@kenati.com> wrote:
> I cant build the kernel with this patch -- i m using the 2.6.14.6
> kernel..

Then these patch might fit your needs:

http://www.linux-mips.org/archives/linux-mips/2005-11/msg00088.html
or
http://www.linux-mips.org/archives/linux-mips/2006-02/msg00097.html
(http://www.linux-mips.org/git?p=linux.git;a=commitdiff;h=63077519899721120b61d663a68adced068a459d)

> also, the kernel does not hang, but the output produced on the console 
> is not complete: eg
> i.e. I get this:

Anyway, "Cant analyze prologue code" message should not irrelevant to
your serial console problem.

---
Atsushi Nemoto
