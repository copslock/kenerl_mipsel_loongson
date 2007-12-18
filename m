Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Dec 2007 22:50:22 +0000 (GMT)
Received: from 1wt.eu ([62.212.114.60]:55050 "EHLO 1wt.eu")
	by ftp.linux-mips.org with ESMTP id S28580378AbXLRWuP (ORCPT
	<rfc822;linux-mips@ftp.linux-mips.org>);
	Tue, 18 Dec 2007 22:50:15 +0000
Date:	Tue, 18 Dec 2007 23:47:03 +0100
From:	Willy Tarreau <w@1wt.eu>
To:	Alon Bar-Lev <alon.barlev@gmail.com>
Cc:	"H. Peter Anvin" <hpa@zytor.com>, linux-mips@ftp.linux-mips.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [MIPS] Build an embedded initramfs into mips kernel
Message-ID: <20071218224702.GI15227@1wt.eu>
References: <9e0cf0bf0712181208m7f16b9acpf3dba67f3556a613@mail.gmail.com> <47683B2D.9030608@zytor.com> <9e0cf0bf0712181409p2475e1fdk779fdee4fa274722@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e0cf0bf0712181409p2475e1fdk779fdee4fa274722@mail.gmail.com>
User-Agent: Mutt/1.5.11
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@ftp.linux-mips.org
Original-Recipient: rfc822;linux-mips@ftp.linux-mips.org
X-archive-position: 17857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w@1wt.eu
Precedence: bulk
X-list: linux-mips

On Wed, Dec 19, 2007 at 12:09:46AM +0200, Alon Bar-Lev wrote:
> On 12/18/07, H. Peter Anvin <hpa@zytor.com> wrote:
> > Make sure your /init doesn't depend on an interpreter or library which
> > isn't available.
> 
> Thank you for your answer.
> 
> I already checked.
> 
> /init is hardlink to busybox, it depends on libc.so.0 which is available at /lib

Are you sure that libc.so.0 is enough and that you don't need any ld.so ?

> But shouldn't I get a different error code if this is the case?

If it does not find part of the dynamic linker or libraries, this error
makes sense to me.

You should try to build a static init with any stupid thing such as a
hello world to ensure that the problem really comes from the init and
nothing else.

Regards,
Willy
