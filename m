Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 19:29:35 +0000 (GMT)
Received: from p508B5DCD.dip.t-dialin.net ([IPv6:::ffff:80.139.93.205]:51879
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225349AbSLRT3e>; Wed, 18 Dec 2002 19:29:34 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gBIJTVu20311;
	Wed, 18 Dec 2002 20:29:31 +0100
Date: Wed, 18 Dec 2002 20:29:31 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: linux mips mailing list <linux-mips@linux-mips.org>
Subject: Re: [PATCH]:
Message-ID: <20021218202931.B20144@linux-mips.org>
References: <m2smwwqf0e.fsf@demo.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m2smwwqf0e.fsf@demo.mitica>; from quintela@mandrakesoft.com on Wed, Dec 18, 2002 at 02:42:25AM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 18, 2002 at 02:42:25AM +0100, Juan Quintela wrote:

> PD. Someone can explain me what mean:
>     __attribute__ ((__mode__ (__SI__)));
> 
>     The SI part don't appear in the gcc info pages :(

Single Integer, a 32-bit integer.

  Ralf
