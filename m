Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2007 18:54:17 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:42186 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024462AbXHGRyP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Aug 2007 18:54:15 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l77HsB3Z030351;
	Tue, 7 Aug 2007 18:54:11 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l77Hs35m030350;
	Tue, 7 Aug 2007 18:54:03 +0100
Date:	Tue, 7 Aug 2007 18:54:02 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	jiankemeng@gmail.com, tiansm@lemote.com, linux-mips@linux-mips.org,
	alsa-devel@alsa-project.org, tiwai@suse.de, greg@kroah.com
Subject: Re: ALSA on MIPS platform
Message-ID: <20070807175402.GA24731@linux-mips.org>
References: <46B332AC.8020403@lemote.com> <5861a7880708062253x7133659cm1ff17f451e4f82f8@mail.gmail.com> <5861a7880708062317t21970c81w3f16580858bf50af@mail.gmail.com> <20070807.230157.59463765.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070807.230157.59463765.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 07, 2007 at 11:01:57PM +0900, Atsushi Nemoto wrote:

> On Tue, 7 Aug 2007 10:18:04 +0400, "Dajie Tan" <jiankemeng@gmail.com> wrote:
> >  static inline unsigned long virt_to_phys(volatile const void *address)
> >  {
> > -       return (unsigned long)address - PAGE_OFFSET + PHYS_OFFSET;
> > +       return ((unsigned long)address & 0x1fffffff) + PHYS_OFFSET;
> >  }
> 
> This makes virt_to_phys() a bit slower, and more importantly, breaks
> 64-bit kernel.

It's ALSA that is doing funny things here so there is no point in fixing
the arch code to work for ALSA.

  Ralf
