Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 23:12:43 +0000 (GMT)
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([IPv6:::ffff:213.105.254.86]:14800
	"EHLO irongate.swansea.linux.org.uk") by linux-mips.org with ESMTP
	id <S8225223AbTCMXMm>; Thu, 13 Mar 2003 23:12:42 +0000
Received: from irongate.swansea.linux.org.uk (localhost [127.0.0.1])
	by irongate.swansea.linux.org.uk (8.12.7/8.12.7) with ESMTP id h2E0L6Yf027532;
	Fri, 14 Mar 2003 00:21:06 GMT
Received: (from alan@localhost)
	by irongate.swansea.linux.org.uk (8.12.7/8.12.7/Submit) id h2E0L4nn027530;
	Fri, 14 Mar 2003 00:21:04 GMT
X-Authentication-Warning: irongate.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: Disabling lwl and lwr instruction generation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Ranjan Parthasarathy <ranjanp@efi.com>,
	Richard Hodges <rh@matriplex.com>, linux-mips@linux-mips.org
In-Reply-To: <20030313223529.D30512@linux-mips.org>
References: <D9F6B9DABA4CAE4B92850252C52383AB07968241@ex-eng-corp.efi.com>
	 <20030313223529.D30512@linux-mips.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047601263.27471.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 14 Mar 2003 00:21:03 +0000
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Thu, 2003-03-13 at 21:35, Ralf Baechle wrote:
> Replace those unaligned copies with a word-wise or even bytewise copying.
> Not good for performance but ...

Depends on (src^dest) & 3. Glibc may have the code you need to get it
right, although it will also depend on how smart the cpu cache is - if
you have a write through cache then shift/mask/write in 32/64 chunks
may be fastest


Alan
