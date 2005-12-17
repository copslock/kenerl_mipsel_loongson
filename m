Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Dec 2005 02:34:08 +0000 (GMT)
Received: from [62.38.104.168] ([62.38.104.168]:62863 "EHLO pfn3.pefnos")
	by ftp.linux-mips.org with ESMTP id S8133608AbVLQCdu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 17 Dec 2005 02:33:50 +0000
Received: from xorhgos2.pefnos (xorhgos2.pefnos [192.168.0.3])
	by pfn3.pefnos (Postfix) with ESMTP id 549701F101
	for <linux-mips@linux-mips.org>; Sat, 17 Dec 2005 04:34:28 +0200 (EET)
From:	"P. Christeas" <p_christ@hol.gr>
To:	linux-mips@linux-mips.org
Subject: Build error: undefined reference to `__ashrdi3'
Date:	Sat, 17 Dec 2005 04:34:19 +0200
User-Agent: KMail/1.9
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200512170434.21990.p_christ@hol.gr>
Return-Path: <p_christ@hol.gr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p_christ@hol.gr
Precedence: bulk
X-list: linux-mips

Please, a little help here..
I tried to rebuild the toolchain, giving --with-float=soft, and still get the 
same (as with no such option). It is gcc 4.0.2 + ÏClibc
I am porting mips to a new board, so this may be my mistake. Somewhere I can 
kick-start this?
How can a kernel build (which should be autonomous) depend on some compiler 
setup?
