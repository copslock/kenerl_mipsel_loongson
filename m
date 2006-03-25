Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Mar 2006 17:25:03 +0000 (GMT)
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37904 "EHLO
	caramon.arm.linux.org.uk") by ftp.linux-mips.org with ESMTP
	id S8133768AbWCYRYu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 25 Mar 2006 17:24:50 +0000
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.52)
	id 1FNCf6-0001rK-DH; Sat, 25 Mar 2006 17:34:52 +0000
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.52)
	id 1FNCf4-0006Iv-Qb; Sat, 25 Mar 2006 17:34:50 +0000
Date:	Sat, 25 Mar 2006 17:34:50 +0000
From:	Russell King <rmk@arm.linux.org.uk>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org, jblache@debian.org
Subject: Re: IP22 doesn't shutdown properly
Message-ID: <20060325173450.GC6100@flint.arm.linux.org.uk>
References: <20060217225824.GE20785@deprecation.cyrius.com> <20060223221350.GA5239@deprecation.cyrius.com> <20060224190517.GA28013@lst.de> <20060227105236.GI12044@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227105236.GI12044@deprecation.cyrius.com>
User-Agent: Mutt/1.4.1i
Return-Path: <rmk+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Mon, Feb 27, 2006 at 10:52:36AM +0000, Martin Michlmayr wrote:
> @@ -360,10 +367,10 @@ static void ip22zilog_status_handle(stru
>  		 * But it does not tell us which bit has changed, we have to keep
>  		 * track of this ourselves.
>  		 */
> -		if ((status & DCD) ^ up->prev_status)
> +		if ((status ^ up->prev_status) ^ DCD)

Shouldn't this be (status ^ up->prev_status) & DCD ?

>  			uart_handle_dcd_change(&up->port,
>  					       (status & DCD));
> -		if ((status & CTS) ^ up->prev_status)
> +		if ((status ^ up->prev_status) ^ CTS)

Shouldn't this be (status ^ up->prev_status) & CTS ?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
