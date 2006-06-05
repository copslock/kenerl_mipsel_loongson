Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jun 2006 09:51:46 +0200 (CEST)
Received: from sigrand.ru ([80.66.88.167]:6107 "HELO mail.sigrand.com")
	by ftp.linux-mips.org with SMTP id S8133470AbWFEHvi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 5 Jun 2006 09:51:38 +0200
Received: from develop (unknown [192.168.2.238])
	by mail.sigrand.com (Postfix) with ESMTP id AC4B712A0011
	for <linux-mips@linux-mips.org>; Mon,  5 Jun 2006 14:51:37 +0700 (NOVST)
Date:	Mon, 5 Jun 2006 14:51:31 +0700
From:	art <art@sigrand.ru>
X-Mailer: The Bat! (v1.38e) S/N A1D26E39 / Educational
Reply-To: art <art@sigrand.ru>
Organization: Sigrand LLC
X-Priority: 3 (Normal)
Message-ID: <13619.060605@sigrand.ru>
To:	linux-mips@linux-mips.org
Subject: Re: Perfomance problem on MIPS
In-reply-To: <3617.060605@sigrand.ru>
References: <3617.060605@sigrand.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <art@sigrand.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: art@sigrand.ru
Precedence: bulk
X-list: linux-mips

Kernel 2.6.16 from linux-mips.org
a>> Hello all!
a>>       I work with processor: MIPS 4KC.
a>>       I check network performance without iptables & conntrac enabled
a>>       and it has near 80Mbit/s.
a>>       When I enable (without adding rules) network performance was
a>>       near 40Mbit/s.
a>>       While testing ksoftirqd is get near 50% of cpu. And (it is so
a>>       strange) top eats the same! However cpu has 100% load and
a>>       perfomance is real bad.
a>>       Has anybody same problem?
  







-- 
Best regards,
 art                            mailto:art@sigrand.ru
