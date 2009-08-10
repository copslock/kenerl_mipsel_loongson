Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Aug 2009 21:55:58 +0200 (CEST)
Received: from waste.org ([173.11.57.241]:57446 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493533AbZHJTzu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Aug 2009 21:55:50 +0200
Received: from [192.168.1.100] ([10.0.0.100])
	(authenticated bits=0)
	by waste.org (8.13.8/8.13.8/Debian-3) with ESMTP id n7AJt5iP000363
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 10 Aug 2009 14:55:05 -0500
Subject: Re: [PATCH 0/2] New hardware RNG for Octeon SOCs.
From:	Matt Mackall <mpm@selenic.com>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-mips <linux-mips@linux-mips.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <4A806529.3060609@caviumnetworks.com>
References: <4A806529.3060609@caviumnetworks.com>
Content-Type: text/plain
Date:	Mon, 10 Aug 2009 14:54:54 -0500
Message-Id: <1249934094.3807.32.camel@calx>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new
Return-Path: <mpm@selenic.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpm@selenic.com
Precedence: bulk
X-list: linux-mips

On Mon, 2009-08-10 at 11:21 -0700, David Daney wrote:
> Behold the Random Number Generator driver for Octeon!
> 
> The first patch adds some port definitions and the octeon_rng platform
> device.  The second is the driver.
> 
> I am copying AKPM and Linus as there seems to be no hw_random maintainer.

These now go through Herbert Xu and I.

-- 
http://selenic.com : development and support for Mercurial and Linux
