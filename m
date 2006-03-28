Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Mar 2006 11:47:01 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:59616 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133469AbWC1Kqw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Mar 2006 11:46:52 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 28 Mar 2006 19:57:17 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 204052049D;
	Tue, 28 Mar 2006 19:57:15 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 13273203EE;
	Tue, 28 Mar 2006 19:57:15 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k2SAvE4D086802;
	Tue, 28 Mar 2006 19:57:14 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 28 Mar 2006 19:57:14 +0900 (JST)
Message-Id: <20060328.195714.21363712.nemoto@toshiba-tops.co.jp>
To:	dhunjukrishna@gmail.com, dhunjukrishna@yahoo.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: building cross compiler for compiling kernel 2.6.14 for BCM1480
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060328103557.25987.qmail@web53509.mail.yahoo.com>
References: <20060324224005.GA4145@linux-mips.org>
	<20060328103557.25987.qmail@web53509.mail.yahoo.com>
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
X-archive-position: 10956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 28 Mar 2006 02:35:57 -0800 (PST), Krishna <dhunjukrishna@yahoo.com> said:
> I went to the site (http://www.linux-mips.org/wiki/Toolchains >
> Pre-built/Build Kits ).. Downloaded the following tools
>   -binutils-2.16.1
>   -gcc-4.1.0
>   -gdb-6.4
> And followed the installation instruction as described there. First
> installed binutils successfully. But got follwing error while doing
> make -j2 in the process of installing gcc-4.1.c:

If you want to use gcc 4.1, Add --disable-libmudflap --disable-libssp
when configuring the bootstrap gcc.  These libraries are not required
to compile linux kernel.

---
Atsushi Nemoto
