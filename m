Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Feb 2003 10:55:12 +0000 (GMT)
Received: from yue.hongo.wide.ad.jp ([IPv6:::ffff:203.178.139.94]:10756 "EHLO
	yue.hongo.wide.ad.jp") by linux-mips.org with ESMTP
	id <S8224939AbTBYKzM>; Tue, 25 Feb 2003 10:55:12 +0000
Received: from localhost (localhost [127.0.0.1])
	by yue.hongo.wide.ad.jp (8.12.3+3.5Wbeta/8.12.3/Debian -4) with ESMTP id h1PAtDBF028906;
	Tue, 25 Feb 2003 19:55:13 +0900
Date: Tue, 25 Feb 2003 19:55:12 +0900 (JST)
Message-Id: <20030225.195512.18953246.yoshfuji@linux-ipv6.org>
To: ipv6_san@rediffmail.com
Cc: usagi-users@linux-ipv6.org, netdev@oss.sgi.com,
	linux-mips@linux-mips.org
Subject: Re: USAGI Kernel for MIPS based device
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030225101731.9289.qmail@webmail14.rediffmail.com>
References: <20030225101731.9289.qmail@webmail14.rediffmail.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <yoshfuji@linux-ipv6.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoshfuji@linux-ipv6.org
Precedence: bulk
X-list: linux-mips

In article <20030225101731.9289.qmail@webmail14.rediffmail.com> (at 25 Feb 2003 10:17:31 -0000), "Santosh " <ipv6_san@rediffmail.com> says:

> Now i want to port latest USAGI kernel code onto my device.
:
> Is the USAGI code, platform independent ??

It should be.  We run our code on our
 - ix86
 - Ultra SPARC
 - Power PC
 - MIPS
 - ARM
machines.
(Unfortunately, we don't have x86-64, ia86 or alpha machines...)

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
