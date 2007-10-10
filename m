Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2007 13:32:07 +0100 (BST)
Received: from rs25s3.datacenter.cha.cantv.net ([200.44.33.4]:44982 "EHLO
	rs25s3.datacenter.cha.cantv.net") by ftp.linux-mips.org with ESMTP
	id S20021823AbXJJMb6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Oct 2007 13:31:58 +0100
Received: from [192.168.0.2] (dC9D0EE2C.dslam-04-10-6-02-1-01.apr.dsl.cantv.net [201.208.238.44])
	by rs25s3.datacenter.cha.cantv.net (8.13.8/8.13.0/3.0) with ESMTP id l9ACUp9i025370
	for <linux-mips@linux-mips.org>; Wed, 10 Oct 2007 08:30:52 -0400
X-Matched-Lists: []
Message-ID: <470C8F8E.3010301@kanux.com>
Date:	Wed, 10 Oct 2007 04:38:38 -0400
From:	Ricardo Mendoza <ricmm@kanux.com>
User-Agent: Thunderbird 2.0.0.0 (X11/20070601)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: O2 KGDB problem
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV 0.91.2/4480/Fri Oct  5 10:51:39 2007
	clamav-milter version 0.91.2 on 10.128.1.88
X-Virus-Status:	Clean
Return-Path: <ricmm@kanux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ricmm@kanux.com
Precedence: bulk
X-list: linux-mips

Been messing around with the O2 and KGDB and well, theres a problem that
I don't quite know how to tackle, when building a 64-bit kernel with
mips64 target toolchain and with CONFIG_BUILD_ELF64 and then trying to
start remote gdb with that image I get a Segfault from gdb. What do you
think is the cause of this?

I guess its just file format mixup confusing gdb? any pointer from a gdb
guru
towards making this work?


     Ricardo
