Received:  by oss.sgi.com id <S553816AbQJNMOA>;
	Sat, 14 Oct 2000 05:14:00 -0700
Received: from u-118.karlsruhe.ipdial.viaginterkom.de ([62.180.21.118]:47881
        "EHLO u-118.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553800AbQJNMNt>; Sat, 14 Oct 2000 05:13:49 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870063AbQJNKcd>;
        Sat, 14 Oct 2000 12:32:33 +0200
Date:   Sat, 14 Oct 2000 12:32:33 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Ian Chilton <mailinglist@ichilton.co.uk>
Cc:     linux-mips@oss.sgi.com
Subject: Re: ld problem
Message-ID: <20001014123233.B4407@bacchus.dhis.org>
References: <20001014011056.A27588@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001014011056.A27588@woody.ichilton.co.uk>; from mailinglist@ichilton.co.uk on Sat, Oct 14, 2000 at 01:10:56AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Oct 14, 2000 at 01:10:56AM +0100, Ian Chilton wrote:

> I am running a system with glibc 2.0.6 (-5lm), binutils 2.8.1 and
> egcs 1.0.3a, oh, and linux-2.2.14-mips
> 
> Everything compiled fine, including X4.0.1, except when I try to run
> startx, I get:
> 
> bash-2.04# startx
> xinit: error in loading shared libraries
> libXmu.so.6: cannot open shared object file: No such file or directory

> That's when I found the ldconfig problem:
> 
> bash-2.04# /sbin/ldconfig 
> Bus error

Which is probably the root of the evil - I assume at the point when it's
crashing the new /etc/ld.so.conf file is still incomplete.  I don't have
a theory what's causing that, sorry.

Hmm...  Checkout your /etc/ld.so.conf file.  It should exist and contain
a number of lines like:

/usr/X11R6/lib
/usr/lib
/usr/local/lib

and probably others more.

Maybe ldconfig crashes if the file doesn't exist or contains garbage.

A workaround which may try is the LD_LIBRARY_PATH variable:

  export LD_LIBRARY_PATH=`tr '\n' ':' </etc/ld.so.conf`

After this command you should be able to execute binaries as long as they
are not SUID or SGID binaries.

  Ralf
