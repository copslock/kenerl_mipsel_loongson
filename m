Received:  by oss.sgi.com id <S553777AbQKGDkG>;
	Mon, 6 Nov 2000 19:40:06 -0800
Received: from u-245.karlsruhe.ipdial.viaginterkom.de ([62.180.10.245]:3080
        "EHLO u-245.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553721AbQKGDjn>; Mon, 6 Nov 2000 19:39:43 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868617AbQKGDjW>;
        Tue, 7 Nov 2000 04:39:22 +0100
Date:   Tue, 7 Nov 2000 04:39:22 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:     Keith Owens <kaos@melbourne.sgi.com>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: Kernel compiler
Message-ID: <20001107043922.A31298@bacchus.dhis.org>
References: <20001104035326.A29005@bacchus.dhis.org> <E13s0ke-0004Sa-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E13s0ke-0004Sa-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Nov 04, 2000 at 10:40:42AM +0000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Nov 04, 2000 at 10:40:42AM +0000, Alan Cox wrote:

> > The reports regarding egcs 2.96 and newer misscompiling the kernel only
> > affect x86 or are other architecture affected as well?  I don't have any
> > pending compiler >= 2.96 related bug reports.
> 
> The Red Hat 2.96 seems to compile 2.2 correctly when you fix the 2.2 bugs but
> does miscompile x86 fs/buffers.c on 2.4 according to reports. I think with mips
> you'd have to experiment. Also AFAIK that tree branch hasn't been tested on
> mips 

I asked Cort about their PPC experience and they also got trouble.  Reason
enough to ignore gcc-current for kernel use for now.  It's doing well
for userland however so we'll also have to use two compilers from now on,
one for kernel and one for userland.

Btw, I've now placed srpm and i386-linux rpms of a new release of the
egcs-1.1.2 Linux/MIPS crosscompiler on oss.sgi.com.  Users of the 64-bit
kernel, read Origin users should also update as this release has several
fixes.

  Ralf
