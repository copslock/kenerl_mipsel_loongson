Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3A2Dm8d022873
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 9 Apr 2002 19:13:48 -0700
Received: (from mail@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3A2DmQw022872
	for linux-mips-outgoing; Tue, 9 Apr 2002 19:13:48 -0700
X-Authentication-Warning: oss.sgi.com: mail set sender to owner-linux-mips@oss.sgi.com using -f
Received: from darth.paname.org (root@ns0.paname.org [212.27.32.70])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3A2Di8d022868
	for <linux-mips@oss.sgi.com>; Tue, 9 Apr 2002 19:13:45 -0700
Received: from darth.paname.org (localhost [127.0.0.1])
	by darth.paname.org (8.12.1/8.12.1/Debian -2) with ESMTP id g3A2E9ZB027838
	for <linux-mips@oss.sgi.com>; Wed, 10 Apr 2002 04:14:09 +0200
Received: (from rani@localhost)
	by darth.paname.org (8.12.1/8.12.1/Debian -2) id g3A2E87c027837
	for linux-mips@oss.sgi.com; Wed, 10 Apr 2002 04:14:08 +0200
From: Rani Assaf <rani@paname.org>
Date: Wed, 10 Apr 2002 04:14:08 +0200
To: linux-mips@oss.sgi.com
Subject: Question about r4k_clear_page_xxx()
Message-ID: <20020410041408.G23127@paname.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux darth 2.4.17-pre8 
X-NCC-RegID: fr.proxad
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

I was cleaning  duplicate code between my port of  IDT RC32355 and the
current tree. I want to use r4k_clear_page_d16() but the function uses
store double (sd) which is not available on this processor.

What's the reason for having r4k_clear_page_xxx() use store double and
not r4k_copy_page_xxx()??

Regards,
Rani
