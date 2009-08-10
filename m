Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Aug 2009 22:19:03 +0200 (CEST)
Received: from 136-022.dsl.LABridge.com ([206.117.136.22]:2825 "EHLO
	mail.perches.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493526AbZHJUS4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 10 Aug 2009 22:18:56 +0200
Received: from [192.168.1.158] (Joe-Laptop.home [192.168.1.158])
	by mail.perches.com (8.9.3/8.9.3) with ESMTP id NAA06659;
	Mon, 10 Aug 2009 13:18:16 -0700
Subject: [PATCH] MAINTAINERS: Add Matt Mackall and Herbert Xu to HARDWARE
 RANDOM NUMBER GENERATOR
From:	Joe Perches <joe@perches.com>
To:	Matt Mackall <mpm@selenic.com>
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-mips <linux-mips@linux-mips.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <1249934094.3807.32.camel@calx>
References: <4A806529.3060609@caviumnetworks.com>
	 <1249934094.3807.32.camel@calx>
Content-Type: text/plain
Date:	Mon, 10 Aug 2009 13:18:29 -0700
Message-Id: <1249935509.8895.63.camel@Joe-Laptop.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
Precedence: bulk
X-list: linux-mips

On Mon, 2009-08-10 at 14:54 -0500, Matt Mackall wrote:
> On Mon, 2009-08-10 at 11:21 -0700, David Daney wrote:
> > I am copying AKPM and Linus as there seems to be no hw_random maintainer.
> These now go through Herbert Xu and I.

Perhaps this then:

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index b1114cf..9a27822 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2260,7 +2260,9 @@ S:	Orphan
 F:	drivers/hwmon/
 
 HARDWARE RANDOM NUMBER GENERATOR CORE
-S:	Orphan
+M:	Matt Mackall <mpm@selenic.com>
+M:	Herbert Xu <herbert@gondor.apana.org.au>
+S:	Odd fixes
 F:	Documentation/hw_random.txt
 F:	drivers/char/hw_random/
 F:	include/linux/hw_random.h
