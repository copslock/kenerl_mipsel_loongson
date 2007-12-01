Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Dec 2007 23:22:23 +0000 (GMT)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50665 "EHLO
	caramon.arm.linux.org.uk") by ftp.linux-mips.org with ESMTP
	id S20026751AbXLAXWO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 1 Dec 2007 23:22:14 +0000
Received: from flint.arm.linux.org.uk ([2002:4e20:1eda:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.62)
	(envelope-from <rmk@arm.linux.org.uk>)
	id 1IybbN-0002ly-SD; Sat, 01 Dec 2007 23:18:26 +0000
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.62)
	(envelope-from <rmk@flint.arm.linux.org.uk>)
	id 1IybbL-0004Qn-QZ; Sat, 01 Dec 2007 23:18:23 +0000
Date:	Sat, 1 Dec 2007 23:18:23 +0000
From:	Russell King <rmk@arm.linux.org.uk>
To:	Franck Bui-Huu <fbuihuu@gmail.com>
Cc:	linux-arch@vger.kernel.org, macro@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] Yet another __initxxx annotations: __initbss/__exitbss
Message-ID: <20071201231823.GB5411@flint.arm.linux.org.uk>
Mail-Followup-To: Franck Bui-Huu <fbuihuu@gmail.com>,
	linux-arch@vger.kernel.org, macro@linux-mips.org,
	linux-mips@linux-mips.org
References: <1196543586-6698-1-git-send-email-fbuihuu@gmail.com> <1196543586-6698-2-git-send-email-fbuihuu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1196543586-6698-2-git-send-email-fbuihuu@gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <rmk+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Sat, Dec 01, 2007 at 10:13:05PM +0100, Franck Bui-Huu wrote:
> To select the BSS attribute for a peculiar section, the name of the
> section must start with 'bss.' pattern. This is at least how GCC
> 3.2/4.1.2 works and it's the reason why the 2 new sections haven't
> been called '.{init,exit}.bss'.
> 
> To mark a data part of one of these 2 sections, we use the 2 new
> annotations: __initbss/__exitbss.
> 
> All data marked as part of this section must not be initialized,
> of course.

Are you sure about this?  The gcc manual for 4.1.1 says:

     Use the `section' attribute with an _initialized_ definition of a
     _global_ variable, as shown in the example.  GCC issues a warning
     and otherwise ignores the `section' attribute in uninitialized
     variable declarations.

which has had that paragraph since at least 3.4.0.  Either the GCC
documentation is wrong or the compiler is misbehaving if what you say
works.  Either way, I'd be nervous about relying on this given that
GCC developers like to change the compiler behaviour.

Suggest getting the GCC developers nailed down to ensure we know what
the intended compiler behaviour is (and getting the docs to reflect that)
before relying on the existing behaviour.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
