Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2009 21:14:07 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:44910 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493654AbZKDUOE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Nov 2009 21:14:04 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA4KFPtA027742;
	Wed, 4 Nov 2009 21:15:26 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA4KFK0E027740;
	Wed, 4 Nov 2009 21:15:20 +0100
Date:	Wed, 4 Nov 2009 21:15:20 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Arnaud Patard <apatard@mandriva.com>, linux-mips@linux-mips.org,
	LKML <linux-kernel@vger.kernel.org>, huhb@lemote.com,
	yanh@lemote.com, Zhang Le <r0bertz@gentoo.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>, zhangfx@lemote.com,
	liujl@lemote.com
Subject: Re: [PATCH -queue v0 1/6] [loongson] add basic loongson-2f support
Message-ID: <20091104201520.GA26504@linux-mips.org>
References: <cover.1257325319.git.wuzhangjin@gmail.com> <a1bd2470bc465e505281c761adca8c2287d102b3.1257325319.git.wuzhangjin@gmail.com> <m3iqdqtwgk.fsf@anduin.mandriva.com> <1257332652.8716.5.camel@falcon.domain.org> <20091104111957.GA13549@linux-mips.org> <1257348226.16033.4.camel@falcon.domain.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1257348226.16033.4.camel@falcon.domain.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 04, 2009 at 11:23:46PM +0800, Wu Zhangjin wrote:

> > We have other systems where 32-bit kernel support is just remarkably ugly.
> > We've dropped 32-bit support for the SGI IP32 aka O2 - nobody seems to even
> > have really noticed that.  The Sibyte systems would be good candidates to do
> > the same as accesses to outside the 32-bit address space are needed very
> > frequently.
> > 
> 
> So, we really remove the 32bit support?
> 
> 1312 config CPU_LOONGSON2
> 1313         bool
> 1314         select CPU_SUPPORTS_32BIT_KERNEL  --> remove it?
> 1315         select CPU_SUPPORTS_64BIT_KERNEL
> 1316         select CPU_SUPPORTS_HIGHMEM
> 
> If you all agree, I will send a new patch to remove the above line and
> resend the corresponding patches without 32bit support, and removed the
> relative CONFIG_64BIT lines in the patches too.

If you need highmem with 32-bit (and with Loongson systems I assume that
virtually all systems will have enough RAM to require that) then you're
almost certainly better off going 64-bit.  Highmem takes a performance toll
which for some workloads can be very significant.  And while highmem won't
go away any time soon it's nothing kernel performance is being tuned for,
so it's only going to get worse into the future so I'd not waste time on
highmem unless I have to.

  Ralf
