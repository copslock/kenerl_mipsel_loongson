Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2002 18:02:12 +0000 (GMT)
Received: from rwcrmhc53.attbi.com ([IPv6:::ffff:204.127.198.39]:16610 "EHLO
	rwcrmhc53.attbi.com") by linux-mips.org with ESMTP
	id <S8225285AbSLQSCL>; Tue, 17 Dec 2002 18:02:11 +0000
Received: from lucon.org (12-234-88-146.client.attbi.com[12.234.88.146])
          by rwcrmhc53.attbi.com (rwcrmhc53) with ESMTP
          id <20021217180203053007bb9oe>; Tue, 17 Dec 2002 18:02:03 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id 4DC122C699; Tue, 17 Dec 2002 10:02:03 -0800 (PST)
Date: Tue, 17 Dec 2002 10:02:03 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: Long Li <long21st@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: .reginfo and .mdebug section
Message-ID: <20021217100203.A8806@lucon.org>
References: <20021217084303.20121.qmail@web40407.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021217084303.20121.qmail@web40407.mail.yahoo.com>; from long21st@yahoo.com on Tue, Dec 17, 2002 at 12:43:03AM -0800
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 17, 2002 at 12:43:03AM -0800, Long Li wrote:
> Hi, 
> 
> I have some problems after building a linux-mips cross
> compiler on Red Hat7.1. 
> 
> 1. I tried to compile some c code targetting mips4k,
> which is 32-bit ISA. However, the map file tells me
> that the compiled code are 64-bit, since the address
> are 64-bit.

Mine is 32bit.

> 
> 2. When I compiled the c code, I found in the mapfile
> that there are some sections called .reginfo and
> .mdebug. What are those sections? I would like to get
> rid of them. However, they still exists even if I
> deleted the '-g' option for gcc. Is there a way I can
> avoid the .reginfo and .mdebug sections?

Your toolchain is very old. The newer ones no longer use .mdebug.


H.J.
