Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Feb 2006 21:46:22 +0000 (GMT)
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37134 "EHLO
	caramon.arm.linux.org.uk") by ftp.linux-mips.org with ESMTP
	id S8133592AbWBJVqM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Feb 2006 21:46:12 +0000
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.52)
	id 1F7gB9-0008RW-Kw; Fri, 10 Feb 2006 21:51:48 +0000
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.52)
	id 1F7gBS-0000Sm-W9; Fri, 10 Feb 2006 21:52:07 +0000
Date:	Fri, 10 Feb 2006 21:52:06 +0000
From:	Russell King <rmk+lkml@arm.linux.org.uk>
To:	Pat Gefre <pfg@sgi.com>
Cc:	Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org, linuxppc-dev@ozlabs.org
Subject: Re: [CFT] Don't use ASYNC_* nor SERIAL_IO_* with serial_core
Message-ID: <20060210215206.GB30777@flint.arm.linux.org.uk>
Mail-Followup-To: Pat Gefre <pfg@sgi.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org, linuxppc-dev@ozlabs.org
References: <20060121211407.GA19984@dyn-67.arm.linux.org.uk> <20060210084445.GA1947@flint.arm.linux.org.uk> <200602101457.45847.pfg@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602101457.45847.pfg@sgi.com>
User-Agent: Mutt/1.4.1i
Return-Path: <rmk+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk+lkml@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Fri, Feb 10, 2006 at 02:57:45PM -0600, Pat Gefre wrote:
> Yeah this is something I should've fixed up... thanks
> 
> Acked-by: pfg@sgi.com

Thanks, applied.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
