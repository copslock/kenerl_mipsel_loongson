Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Oct 2006 11:37:06 +0100 (BST)
Received: from kilimandjaro.dyndns.org ([212.85.147.17]:56850 "EHLO
	kilimandjaro.dyndns.org") by ftp.linux-mips.org with ESMTP
	id S20039639AbWJXKhB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Oct 2006 11:37:01 +0100
Received: by kilimandjaro.dyndns.org (Postfix, from userid 500)
	id 430E15D; Tue, 24 Oct 2006 20:45:21 +0200 (CEST)
Received: from localhost ([127.0.0.1])
	by saperlipopette with esmtp (Exim 4.50)
	id 1GcJe1-0001II-T8; Tue, 24 Oct 2006 12:36:29 +0200
Message-ID: <453DECAD.7070805@kilimandjaro.dyndns.org>
Date:	Tue, 24 Oct 2006 12:36:29 +0200
From:	Dominique Quatravaux <dom@kilimandjaro.dyndns.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060927 Thunderbird/1.5.0.7 Mnenhy/0.7.4.666
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Massive clock drift on Cobalt Raq2 after upgrade to 2.6.18-1-r5k-cobalt
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <dom@kilimandjaro.dyndns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@kilimandjaro.dyndns.org
Precedence: bulk
X-list: linux-mips

Dear MIPS hackers,

The subject line pretty much says it all: between yesterday morning and
both my system clock and my uptime increased by about 2 days while only
10 hours actually elapsed... I was previously using kernel
2.4.27-r5k-cobalt (also from Debian) and the clock worked fine.

Maybe this is related to the following:

kilimandjaro:~# zgrep CONFIG_HZ= /proc/config.gz
CONFIG_HZ=250
kilimandjaro:~# grep periodic_freq /proc/driver/rtc
periodic_freq   : 1024

which from my ignorant POV would mean that the clock runs about 5 times
too fast?

How do I go about correcting the problem? I upgraded the kernel without
powering off, should I power-cycle now?

Many thanks in advance from a few days in the future :-)

-- 
<< Tout n'y est pas parfait, mais on y honore certainement les jardiniers >>

			Dominique Quatravaux <dom@kilimandjaro.dyndns.org>
