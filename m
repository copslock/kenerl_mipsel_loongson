Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jan 2003 07:13:01 +0000 (GMT)
Received: from p508B69C2.dip.t-dialin.net ([IPv6:::ffff:80.139.105.194]:15278
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225197AbTA2HNA>; Wed, 29 Jan 2003 07:13:00 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0T7Cv515613;
	Wed, 29 Jan 2003 08:12:57 +0100
Date: Wed, 29 Jan 2003 08:12:56 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Long Li <long21st@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Possible bug in gcc for mips?
Message-ID: <20030129081256.B7741@linux-mips.org>
References: <20030129031421.89385.qmail@web40408.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030129031421.89385.qmail@web40408.mail.yahoo.com>; from long21st@yahoo.com on Tue, Jan 28, 2003 at 07:14:21PM -0800
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 28, 2003 at 07:14:21PM -0800, Long Li wrote:

> Subject: Possible bug in gcc for mips?

It's always possible to blame the tools for broken source.

>  asm volatile ("mfc0 %0,$12" :: "r"(status_reg));

Make that:

asm volatile ("mfc0 %0,$12" : "=r"(status_reg));

> Is this a possible bug or a feature for gcc 3.0.4?

Yes.  Broken source in, broken code out :-)

  Ralf
