Received:  by oss.sgi.com id <S553743AbRAPHPJ>;
	Mon, 15 Jan 2001 23:15:09 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:10739 "EHLO
        lappi.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553708AbRAPHOk>; Mon, 15 Jan 2001 23:14:40 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S868141AbRAPHN3>; Tue, 16 Jan 2001 05:13:29 -0200
Date:	Tue, 16 Jan 2001 05:13:29 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Quinn Jensen <jensenq@Lineo.COM>
Cc:	Erik Andersen <andersen@Lineo.COM>,
        Michael Shmulevich <michaels@jungo.com>,
        busybox@opensource.lineo.com,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: [BusyBox] 0.48 - Can't mount /proc
Message-ID: <20010116051329.C2068@bacchus.dhis.org>
References: <3A5CAC53.60700@jungo.com> <20010110122159.A24714@lineo.com> <3A5D609C.2080201@jungo.com> <20010111044808.A1592@lineo.com> <20010111130450.B5811@paradigm.rfc822.org> <3A5DD6A8.1040600@Lineo.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5DD6A8.1040600@Lineo.COM>; from jensenq@Lineo.COM on Thu, Jan 11, 2001 at 08:52:08AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Jan 11, 2001 at 08:52:08AM -0700, Quinn Jensen wrote:

> Here's a kernel patch.  The __access_ok macro looks one byte
> too far and fails.  Since copy_mount_options() isn't
> sure how long the string arguments are, it just copies
> to the end of the page.  Since this is on busybox's
> stack, the copy wants to go all the way to 0x7FFFFFF
> and hits this corner case.

I don't like this solution as it inflates the kernel noticably.  Actually
even the bug itself hasn't been one; this off by one mistake was deliberatly
accepted in the - obviously wrong - assumption that nobody would ever try to
use the last byte of userspace.  See also the Alpha variant of the code;
looks like they suffer from the same problem.

My solution will be to truncate userspace by by at least 4kb.  I've choosen
to even truncate it by 32kb; this will also make the layout of the address
space for 32-bit processes on 64-bit kernels and 32-bit kernel identical
again.

  Ralf
