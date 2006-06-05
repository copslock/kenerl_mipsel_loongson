Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jun 2006 09:44:05 +0200 (CEST)
Received: from sigrand.ru ([80.66.88.167]:5595 "HELO mail.sigrand.com")
	by ftp.linux-mips.org with SMTP id S8133455AbWFEHnz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 5 Jun 2006 09:43:55 +0200
Received: from develop (unknown [192.168.2.238])
	by mail.sigrand.com (Postfix) with ESMTP id 4D96112A0011
	for <linux-mips@linux-mips.org>; Mon,  5 Jun 2006 14:43:53 +0700 (NOVST)
Date:	Mon, 5 Jun 2006 14:43:47 +0700
From:	art <art@sigrand.ru>
X-Mailer: The Bat! (v1.38e) S/N A1D26E39 / Educational
Reply-To: art <art@sigrand.ru>
Organization: Sigrand LLC
X-Priority: 3 (Normal)
Message-ID: <15613.060605@sigrand.ru>
To:	linux-mips@linux-mips.org
Subject: Perfomance problem on MIPS
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <art@sigrand.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: art@sigrand.ru
Precedence: bulk
X-list: linux-mips

Hello all!
      I work with processor: MIPS 4KC.
      I check network performance without iptables & conntrac enabled
      and it has near 80Mbit/s.
      When I enable (without adding rules) network performance was
      near 40Mbit/s.
      While testing ksoftirqd is get near 50% of cpu. And (it is so
      strange) top eats the same! However cpu has 100% load and
      perfomance is real bad.
      Has anybody same problem?
  

-- 
Best regards,
 art                          mailto:art@sigrand.ru
