Received:  by oss.sgi.com id <S553817AbQJNMOA>;
	Sat, 14 Oct 2000 05:14:00 -0700
Received: from u-118.karlsruhe.ipdial.viaginterkom.de ([62.180.21.118]:47881
        "EHLO u-118.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553816AbQJNMNv>; Sat, 14 Oct 2000 05:13:51 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870070AbQJNKiO>;
        Sat, 14 Oct 2000 12:38:14 +0200
Date:   Sat, 14 Oct 2000 12:38:14 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Ian Chilton <mailinglist@ichilton.co.uk>
Cc:     linux-mips@oss.sgi.com
Subject: Re: 2.4 Kernel Problem on Indy
Message-ID: <20001014123814.C4407@bacchus.dhis.org>
References: <20001013192029.A27003@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001013192029.A27003@woody.ichilton.co.uk>; from mailinglist@ichilton.co.uk on Fri, Oct 13, 2000 at 07:20:29PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Oct 13, 2000 at 07:20:29PM +0100, Ian Chilton wrote:

> Just compiled the CVS 2.4 kernel from this morning, with egcs 1.0.3a, glibc 2.0.6 and binutils 2.8.1 (compiled nativly)
> 
> When I try to boot, it says this...something I have done wrong, or a kernel bug?
> (the cvs 2.2 one I did at the same time works though :))
> 
> >> boot bootp():/vmlinux root=/dev/sda5             

Boot with ``boot -f ...''.  If then your Indy rejects the kernel binary you
have a very old firmware and will have to rebuild a kernel as ECOFF binary
with ``make vmlinux.ecoff'' and boot that one.

(If this procedure actually works for you then you still have a few IRIX
bits left on your disk.)

  Ralf
