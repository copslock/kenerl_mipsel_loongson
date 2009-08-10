Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Aug 2009 21:57:44 +0200 (CEST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:14900 "EHLO
	smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493430AbZHJT5h (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 10 Aug 2009 21:57:37 +0200
Received: from maexch1.caveonetworks.com (Not Verified[192.168.14.20]) by smtp2.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4a807b8e0001>; Mon, 10 Aug 2009 15:57:02 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by maexch1.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 10 Aug 2009 15:57:35 -0400
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 10 Aug 2009 12:57:33 -0700
Message-ID: <4A807BAD.5010708@caviumnetworks.com>
Date:	Mon, 10 Aug 2009 12:57:33 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Matt Mackall <mpm@selenic.com>
CC:	Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-mips <linux-mips@linux-mips.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 0/2] New hardware RNG for Octeon SOCs.
References: <4A806529.3060609@caviumnetworks.com> <1249934094.3807.32.camel@calx>
In-Reply-To: <1249934094.3807.32.camel@calx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Aug 2009 19:57:33.0928 (UTC) FILETIME=[CD394E80:01CA19F4]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Matt Mackall wrote:
> On Mon, 2009-08-10 at 11:21 -0700, David Daney wrote:
>> Behold the Random Number Generator driver for Octeon!
>>
>> The first patch adds some port definitions and the octeon_rng platform
>> device.  The second is the driver.
>>
>> I am copying AKPM and Linus as there seems to be no hw_random maintainer.
> 
> These now go through Herbert Xu and I.

I had been advised of this after I sent the messages.  Perhaps an entry 
in MAINTAINERS is in order.

David Daney
