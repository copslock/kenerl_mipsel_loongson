Received:  by oss.sgi.com id <S42510AbQJFCwx>;
	Thu, 5 Oct 2000 19:52:53 -0700
Received: from u-174.karlsruhe.ipdial.viaginterkom.de ([62.180.18.174]:28677
        "EHLO u-174.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42509AbQJFCwk>; Thu, 5 Oct 2000 19:52:40 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869490AbQJFCvv>;
        Fri, 6 Oct 2000 04:51:51 +0200
Date:   Fri, 6 Oct 2000 04:51:51 +0200
From:   Ralf Baechle <ralf@uni-koblenz.de>
To:     Gordon McNutt <gmcnutt@ridgerun.com>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: insmod hates RELA?
Message-ID: <20001006045151.B4123@bacchus.dhis.org>
References: <39DCDBA0.8EED1CBD@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39DCDBA0.8EED1CBD@ridgerun.com>; from gmcnutt@ridgerun.com on Thu, Oct 05, 2000 at 01:50:56PM -0600
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Oct 05, 2000 at 01:50:56PM -0600, Gordon McNutt wrote:

> I've compiled a module natively on an Indy (linux 2.4.0-test8), but when
> I try to do an insmod (2.3.9) I get this error:
> 
> RELA relocations not supported on this architecture

Correct.  The Indy kernel is 32 bit ELF which uses only REL relocs.

Only the newer N32 and 64 ABI flavours use RELA relocs and we don't use
those file types except for Origin kernels, therefore I'm pretty surprised
to see your report.

> I don't yet understand enough about ELF layouts to know what this means
> and why MIPS doesn't support it. I thought I saw a message in the
> archives stating that 64bit MIPS supports it, but maybe 32bit doesn't.
> I've tried to make sure my compiler options match those being used to
> compile the kernel (which works), but perhaps I'm overlooking something.
> 
> If anyone can give me some hints about what's going wrong I'd greatly
> appreciate it. And if you can reply to me that would be best as I don't
> subscribe to this list.

A possible explanation would be that you use the wrong binutils, have a
corrupt module file or try to load a module for another architecture or
modutils being plain broken?

  Ralf
