Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2005 09:00:59 +0100 (BST)
Received: from 64-30-195-78.dsl.linkline.com ([IPv6:::ffff:64.30.195.78]:13517
	"EHLO jg555.com") by linux-mips.org with ESMTP id <S8225989AbVFNIAo>;
	Tue, 14 Jun 2005 09:00:44 +0100
Received: from [172.16.0.55] ([::ffff:172.16.0.55])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Tue, 14 Jun 2005 01:00:39 -0700
  id 001DC0AC.42AE8EA7.00007085
Message-ID: <42AE8E85.4080708@jg555.com>
Date:	Tue, 14 Jun 2005 01:00:05 -0700
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Daniel Jacobowitz <dan@debian.org>
CC:	Christoph Hellwig <hch@lst.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Building o32 glibc on mips64
References: <42AB3366.8030206@jg555.com> <20050613195602.GA3739@nevyn.them.org> <Pine.LNX.4.61L.0506132100080.1725@blysk.ds.pg.gda.pl> <20050613200820.GA29872@lst.de> <20050613205558.GA26829@nevyn.them.org>
In-Reply-To: <20050613205558.GA26829@nevyn.them.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

 From my understanding it's only supported when using IRIX shared 
libraries, but the standard MIPS64 still only builds n32 and n64 only, 
and not the o32 libraries.

I don't see why GCC didn't just allow all MIPS have that capability.

-- 
----
Jim Gifford
maillist@jg555.com
