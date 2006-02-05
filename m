Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Feb 2006 23:56:25 +0000 (GMT)
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2571 "EHLO
	caramon.arm.linux.org.uk") by ftp.linux-mips.org with ESMTP
	id S8133870AbWBDX4Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 4 Feb 2006 23:56:16 +0000
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.52)
	id 1F5XLS-0002i7-BR; Sun, 05 Feb 2006 00:01:34 +0000
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.52)
	id 1F5XLU-0004Il-Nq; Sun, 05 Feb 2006 00:01:36 +0000
Date:	Sun, 5 Feb 2006 00:01:36 +0000
From:	Russell King <rmk+lkml@arm.linux.org.uk>
To:	Hirokazu Takata <takata@linux-m32r.org>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	linuxppc-dev@ozlabs.org, pfg@sgi.com
Subject: Re: [CFT] Don't use ASYNC_* nor SERIAL_IO_* with serial_core
Message-ID: <20060205000136.GF24887@flint.arm.linux.org.uk>
Mail-Followup-To: Hirokazu Takata <takata@linux-m32r.org>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	linuxppc-dev@ozlabs.org, pfg@sgi.com
References: <20060121211407.GA19984@dyn-67.arm.linux.org.uk> <20060202102721.GE5034@flint.arm.linux.org.uk> <20060202.231033.1059963967.takata.hirokazu@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060202.231033.1059963967.takata.hirokazu@renesas.com>
User-Agent: Mutt/1.4.1i
Return-Path: <rmk+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk+lkml@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Thu, Feb 02, 2006 at 11:10:33PM +0900, Hirokazu Takata wrote:
> On m32r,
>   compile and boot test: OK

Is that an Acked-by ?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
