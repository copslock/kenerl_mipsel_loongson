Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2005 10:01:04 +0100 (BST)
Received: from mra02.ch.as12513.net ([IPv6:::ffff:82.153.252.24]:8322 "EHLO
	mra02.ch.as12513.net") by linux-mips.org with ESMTP
	id <S8225264AbVGVJAs>; Fri, 22 Jul 2005 10:00:48 +0100
Received: from localhost (localhost [127.0.0.1])
	by mra02.ch.as12513.net (Postfix) with ESMTP id 1A1CAD4A60;
	Sat, 23 Jul 2005 10:01:36 +0100 (BST)
Received: from mra02.ch.as12513.net ([127.0.0.1])
 by localhost (mra02.ch.as12513.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 10687-01-61; Sat, 23 Jul 2005 10:01:35 +0100 (BST)
Received: from euskadi.packetvision (unknown [82.152.104.245])
	by mra02.ch.as12513.net (Postfix) with ESMTP id AE1B4D4A88;
	Sat, 23 Jul 2005 10:01:34 +0100 (BST)
Subject: Going over 512M of memory
From:	Alex Gonzalez <linux-mips@packetvision.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20050722043057.GA3803@linux-mips.org>
References: <20050721153359Z8225218-3678+3745@linux-mips.org>
	 <20050722043057.GA3803@linux-mips.org>
Content-Type: text/plain
Message-Id: <1122023087.30605.3.camel@euskadi.packetvision>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date:	Fri, 22 Jul 2005 10:04:47 +0100
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by Eclipse VIRUSshield at eclipse.net.uk
Return-Path: <linux-mips@packetvision.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@packetvision.com
Precedence: bulk
X-list: linux-mips

Hi,

Our target experienced a kernel panic at startup when trying to access
memory above 512MB.

Reading the list archives I found this thread with a proposed patch:

http://www.linux-mips.org/archives/linux-mips/2005-02/msg00115.html

After applying the patch our target boots OK and appears to be able to
access the whole memory range without problems.

Any idea why this patch didn't make it to the repository? Is it safe?

Thanks,
Alex
