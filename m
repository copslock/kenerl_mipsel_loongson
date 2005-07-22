Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2005 10:06:51 +0100 (BST)
Received: from mra02.ch.as12513.net ([IPv6:::ffff:82.153.252.24]:42630 "EHLO
	mra02.ch.as12513.net") by linux-mips.org with ESMTP
	id <S8225264AbVGVJGe>; Fri, 22 Jul 2005 10:06:34 +0100
Received: from localhost (localhost [127.0.0.1])
	by mra02.ch.as12513.net (Postfix) with ESMTP id D9670D49EA
	for <linux-mips@linux-mips.org>; Sat, 23 Jul 2005 10:07:22 +0100 (BST)
Received: from mra02.ch.as12513.net ([127.0.0.1])
 by localhost (mra02.ch.as12513.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 17291-01-53 for <linux-mips@linux-mips.org>;
 Sat, 23 Jul 2005 10:07:21 +0100 (BST)
Received: from euskadi.packetvision (unknown [82.152.104.245])
	by mra02.ch.as12513.net (Postfix) with ESMTP id E0529D4685
	for <linux-mips@linux-mips.org>; Sat, 23 Jul 2005 10:07:19 +0100 (BST)
Subject: Realtime preemption patches
From:	Alex Gonzalez <linux-mips@packetvision.com>
To:	linux-mips@linux-mips.org
In-Reply-To: <20050722043057.GA3803@linux-mips.org>
References: <20050721153359Z8225218-3678+3745@linux-mips.org>
	 <20050722043057.GA3803@linux-mips.org>
Content-Type: text/plain
Message-Id: <1122023432.30605.10.camel@euskadi.packetvision>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date:	Fri, 22 Jul 2005 10:10:32 +0100
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by Eclipse VIRUSshield at eclipse.net.uk
Return-Path: <linux-mips@packetvision.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@packetvision.com
Precedence: bulk
X-list: linux-mips

Hi,

I am not having much success trying to apply Ingo's realtime patches (
http://people.redhat.com/mingo/realtime-preempt/) to a 2.6.12-rc3 linux-mips kernel.

Has anybody succeeded in doing so? Is there an intermediate patch I'm missing available?

Alex
