Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2004 01:58:46 +0000 (GMT)
Received: from adsl-66-123-66-42.dsl.pltn13.pacbell.net ([IPv6:::ffff:66.123.66.42]:65417
	"EHLO stella-blue.herbertphamily.com") by linux-mips.org with ESMTP
	id <S8225467AbUA1B6q>; Wed, 28 Jan 2004 01:58:46 +0000
Received: from [192.168.1.8] (shakedown.herbertphamily.com [192.168.1.8])
	(authenticated bits=0)
	by stella-blue.herbertphamily.com (8.12.10/8.12.8) with ESMTP id i0S1whAc018705
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-mips@linux-mips.org>; Tue, 27 Jan 2004 17:58:44 -0800
Subject: Removal of ____raw_readq() and ____raw_writeq() from asm-mips/io.h
From: Kevin Paul Herbert <kph@cisco.com>
To: linux-mips@linux-mips.org
Content-Type: text/plain
Organization: cisco Systems, Inc.
Message-Id: <1075255111.8744.4.camel@shakedown>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Jan 2004 17:58:31 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <kph@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kph@cisco.com
Precedence: bulk
X-list: linux-mips

In edit 1.68, the non-interrupt locking versions of
raw_readq()/raw_writeq() were removed, in favor of locking ones. While
this makes sense in general, it breaks the compilation of the sb1250
which uses the non-locking versions (____raw_readq() and
____raw_writeq()) in interrupt handlers.

Personally, I think that it is very confusing to have so many similar
macros with similar names and increasing numbers of underscores, so I
don't really have a problem with this. I've modified
arch/mips/sibyte/sb1250/time.c and arch/mips/sibyte/sb1250/irq.c to use
the __ versions and have a few more instructions of overhead.

My question is whether this removal was intended or not, or whether
there are some other changes to the handlers in the sb1250-specific code
that got dropped somewhere.

If the consensus is that the ____ versions really should perish for the
sake of simplicity, I'll send my simple patches to the list to fix the
sb1250 build.

Thanks,
Kevin
-- 
Kevin Paul Herbert <kph@cisco.com>
cisco Systems, Inc.
