Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Aug 2007 08:20:09 +0100 (BST)
Received: from mail.ok-labs.com ([221.199.209.5]:52927 "EHLO mail.ok-labs.com")
	by ftp.linux-mips.org with ESMTP id S20021571AbXHTHUH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Aug 2007 08:20:07 +0100
Received: from [10.21.11.188]
	by mail.ok-labs.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <carl@ok-labs.com>)
	id 1IN1EF-0002h2-Vf
	for linux-mips@linux-mips.org; Mon, 20 Aug 2007 16:59:12 +1000
Message-ID: <46C93BB5.9050809@ok-labs.com>
Date:	Mon, 20 Aug 2007 16:59:01 +1000
From:	Carl van Schaik <carl@ok-labs.com>
Organization: Open Kernel Labs Inc.
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: TLS register for NPTL
X-Enigmail-Version: 0.95.3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 10.21.11.188
X-SA-Exim-Mail-From: carl@ok-labs.com
X-SA-Exim-Scanned: No (on mail.ok-labs.com); SAEximRunCond expanded to false
Return-Path: <carl@ok-labs.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carl@ok-labs.com
Precedence: bulk
X-list: linux-mips

Hi All,

It seems the rdhwr emulation is used/proposed for accessing the thread
word in NPTL.
I've been reading some of the posts from 2005 about this choice of this
and what I have missed is anyone talking about using the "k0" register
for TLS. It seems logical that the kernel could always restore k0 on
returning to user-land and having k1 only for the last part of returning
to user is sufficient. Any reason why this was not looked at?

regards,
Carl van Schaik
