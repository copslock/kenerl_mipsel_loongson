Received:  by oss.sgi.com id <S553953AbRAaKQI>;
	Wed, 31 Jan 2001 02:16:08 -0800
Received: from gandalf.physik.uni-konstanz.de ([134.34.144.69]:64005 "EHLO
        gandalf.physik.uni-konstanz.de") by oss.sgi.com with ESMTP
	id <S553951AbRAaKPp>; Wed, 31 Jan 2001 02:15:45 -0800
Received: from bilbo.physik.uni-konstanz.de [134.34.144.81] 
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 14NuIR-0001ln-00; Wed, 31 Jan 2001 11:15:27 +0100
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 14NuIR-0001fU-00; Wed, 31 Jan 2001 11:15:27 +0100
Date:   Wed, 31 Jan 2001 11:15:27 +0100
From:   Guido Guenther <guido.guenther@uni-konstanz.de>
To:     Calvine Chew <calvine@sgi.com>
Cc:     'linux-mips' <linux-mips@oss.sgi.com>
Subject: Re: Building XFree86 4.0.2?
Message-ID: <20010131111527.B6057@bilbo.physik.uni-konstanz.de>
Mail-Followup-To: Calvine Chew <calvine@sgi.com>,
	'linux-mips' <linux-mips@oss.sgi.com>
References: <43FECA7CDC4CD411A4A3009027999112267E3E@sgp-apsa001e--n.singapore.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <43FECA7CDC4CD411A4A3009027999112267E3E@sgp-apsa001e--n.singapore.sgi.com>; from calvine@sgi.com on Wed, Jan 31, 2001 at 02:20:17PM +0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jan 31, 2001 at 02:20:17PM +0800, Calvine Chew wrote:
> I'm trying to build XFree86 4.0.2 on HardHat 5.1 (unpatched) and I'm looking
> at the Mips.cf, which mentions a bootstrapcflag, but the relnotes say
> supported configs don't need bootstrapcflag="-DMips" passed to make. If I
> pass bootstrap I get a conflict on stdio.h early on (conflicting type
> sys_errlist), whereas if I don't pass bootstrapcflag, I get an error around
> after 5000 lines of output (undefined references to __libc_accept, etc, from
> libpthread.so when trying to make makekeys.c).
I'm running 4.0.2 on glib2.0.6 fine here. There are updated glibc2.0
rpms on oss.sgi.com/mips. With them you can build 4.0.2 without any need
to pass additional flags.
 -- Guido
