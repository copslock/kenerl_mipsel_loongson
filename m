Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2006 06:02:32 +0200 (CEST)
Received: from MGW2.Sony.CO.JP ([137.153.0.14]:30338 "HELO mgw2.sony.co.jp")
	by ftp.linux-mips.org with SMTP id S8133396AbWEaECY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2006 06:02:24 +0200
Received: from mail7.sony.co.jp ([43.0.1.209])
Received: from mail7.sony.co.jp (localhost [127.0.0.1])
	by mail7.sony.co.jp (R8/Sony) with ESMTP id k4V42KQM013285;
	Wed, 31 May 2006 13:02:20 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail7.sony.co.jp (R8/Sony) with ESMTP id k4V42KjT013274;
	Wed, 31 May 2006 13:02:20 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.4.191.32]) by smail1.sm.sony.co.jp (8.11.6p2/8.11.6) with ESMTP id k4V42JY22488; Wed, 31 May 2006 13:02:20 +0900 (JST)
Received: from localhost (tidal.sm.sony.co.jp [43.4.195.112])
	by imail.sm.sony.co.jp (8.12.11/3.7W) with ESMTP id k4V42ePn025979;
	Wed, 31 May 2006 13:02:40 +0900 (JST)
Date:	Wed, 31 May 2006 12:59:06 +0900 (JST)
Message-Id: <20060531.125906.126597849.kaminaga@sm.sony.co.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, kaminaga@sm.sony.co.jp
Subject: Re: SIGSTKFLT in mips
From:	Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
In-Reply-To: <20060530124043.GB3185@linux-mips.org>
References: <20060530.181218.74754108.kaminaga@sm.sony.co.jp>
	<20060530124043.GB3185@linux-mips.org>
X-Mailer: Mew version 4.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kaminaga@sm.sony.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaminaga@sm.sony.co.jp
Precedence: bulk
X-list: linux-mips

From: Ralf Baechle <ralf@linux-mips.org>
> SIGSTKFLT is used for stack faults on coprocessors.  That condition
> simply doesn't exist on MIPS thus no SIGSTKFLT.

Thank you for your reply!

(Hiroki Kaminaga)
t
--
