Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Mar 2005 23:25:04 +0000 (GMT)
Received: from caramon.arm.linux.org.uk ([IPv6:::ffff:212.18.232.186]:29201
	"EHLO caramon.arm.linux.org.uk") by linux-mips.org with ESMTP
	id <S8224922AbVCTXYs>; Sun, 20 Mar 2005 23:24:48 +0000
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DD9mi-0006x8-3O; Sun, 20 Mar 2005 23:24:40 +0000
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DD9mh-0000OC-0W; Sun, 20 Mar 2005 23:24:39 +0000
Date:	Sun, 20 Mar 2005 23:24:38 +0000
From:	Russell King <rmk+lkml@arm.linux.org.uk>
To:	Pete Popov <ppopov@embeddedalley.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: Bitrotting serial drivers
Message-ID: <20050320232438.B31657@flint.arm.linux.org.uk>
Mail-Followup-To: Pete Popov <ppopov@embeddedalley.com>,
	Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
References: <20050319172101.C23907@flint.arm.linux.org.uk> <20050319141351.74f6b2a5.akpm@osdl.org> <20050320224028.GB6727@linux-mips.org> <423DFE7C.7040406@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <423DFE7C.7040406@embeddedalley.com>; from ppopov@embeddedalley.com on Sun, Mar 20, 2005 at 02:51:40PM -0800
Return-Path: <rmk+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk+lkml@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Sun, Mar 20, 2005 at 02:51:40PM -0800, Pete Popov wrote:
> >>>- __register_serial, register_serial, unregister_serial
> >>>  (this driver doesn't support PCMCIA cards, all of which are based on
> >>>   8250-compatible devices.)
>
> I tried a couple of times to cleanly add support to the 8250 for the Au1x 
> serial. The uart is just different enough to make that hard, though I admit I 
> never spent too much time on it. Sounds like it's time to revisit it again.

I would prefer to have a patch to remove (or ack to do so myself) the
above three mentioned functions so I can avoid breaking your driver,
rather than a large update to it.

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
