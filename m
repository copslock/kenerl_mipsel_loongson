Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2004 21:32:52 +0000 (GMT)
Received: from savages.net ([IPv6:::ffff:12.154.202.18]:56315 "EHLO
	savages.net") by linux-mips.org with ESMTP id <S8225507AbUBCVcw>;
	Tue, 3 Feb 2004 21:32:52 +0000
Received: from savages.net ([::ffff:192.168.4.181])
  (TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by server with esmtp; Tue, 03 Feb 2004 13:32:46 -0800
Message-ID: <4020137E.9020005@savages.net>
Date: Tue, 03 Feb 2004 13:32:46 -0800
From: Shaun Savage <savages@savages.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: dietlibc nash  pic/non-pic errors
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <savages@savages.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: savages@savages.net
Precedence: bulk
X-list: linux-mips

Hi
I am want to cross compile dietlibc and nash(mkinitrd).

I can cross compile static mipsel dietlibc libs
but when I try to link it with nash I get
   the pic and non-pic error,  can't merge

I have gotten QPDF, SD on linux, busybox and ulibc cross compiled and 
working, so I sort of know what I am doing.

I am using Maciej toolchain

any help?

shaun
