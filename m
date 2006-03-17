Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Mar 2006 14:02:53 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:57240 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133502AbWCQOCo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Mar 2006 14:02:44 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k2HEC7E5008233;
	Fri, 17 Mar 2006 14:12:07 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k2HEC7PE008232;
	Fri, 17 Mar 2006 14:12:07 GMT
Date:	Fri, 17 Mar 2006 14:12:07 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Vadivelan@soc-soft.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Init not working in 64-bit kernel
Message-ID: <20060317141207.GB3771@linux-mips.org>
References: <4BF47D56A0DD2346A1B8D622C5C5902C01524E41@soc-mail.soc-soft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BF47D56A0DD2346A1B8D622C5C5902C01524E41@soc-mail.soc-soft.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 17, 2006 at 07:19:08PM +0530, Vadivelan@soc-soft.com wrote:

> I've another doubt. Is it enough to set only the bits KX,SX and UX of
> the status register to work in 64-bit mode?

KX, SX and UX will be set by the kernel itself on startup.

SX doesn't actually matter because Linux doesn't use the supervisor mode.

More for completness sake - there are some slight differences between the
various 64-bit processors if attempting to execute 64-bit instructions or
addresses on a processor configured to 32-bit mode.

> Though I've used the cross compiler mips64_fp_be-gcc from MontaVista,
> the generated vmlinux image seems to boot fine even without setting the
> above bits.
> I don't know if I'm operating in 32-bit or 64-bit mode.
> But I've enabled 64-bit support in kernel configuration.

Always 64-bit mode on a 64-bit kernels - even for 32-bit software.
Always 32-bit mode on 32-bit kernels - even on 64-bit hardware.

  Ralf
