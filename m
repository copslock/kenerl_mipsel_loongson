Received:  by oss.sgi.com id <S553802AbQKQJZw>;
	Fri, 17 Nov 2000 01:25:52 -0800
Received: from gandalf.physik.uni-konstanz.de ([134.34.144.69]:56082 "EHLO
        gandalf.physik.uni-konstanz.de") by oss.sgi.com with ESMTP
	id <S553779AbQKQJZa>; Fri, 17 Nov 2000 01:25:30 -0800
Received: from gimli.physik.uni-konstanz.de [134.34.144.85] 
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 13whlq-00066M-00; Fri, 17 Nov 2000 10:25:22 +0100
Received: from agx by gimli.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 13whlq-0000rI-00; Fri, 17 Nov 2000 10:25:22 +0100
Date:   Fri, 17 Nov 2000 10:25:22 +0100
From:   Guido Guenther <guido.guenther@gmx.net>
To:     Joe Berens <jberens@sgi.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: X
Message-ID: <20001117102522.A2972@gimli.physik.uni-konstanz.de>
References: <Pine.SGI.4.10.10011161506530.11923-100000@jberens.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <Pine.SGI.4.10.10011161506530.11923-100000@jberens.americas.sgi.com>; from jberens@sgi.com on Thu, Nov 16, 2000 at 03:10:53PM -0600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Nov 16, 2000 at 03:10:53PM -0600, Joe Berens wrote:
> Hello,
> 
> I have compiled X on my Indy running linux following the directions found
> at http://honk.physik.uni-konstanz.de/~agx/mipslinux/x/x.html.  When i to
> startx it seems to start X but no x ever shows up.  From
> /var/log/xdm-errrors:
> 
[..snip..] 
> Operating System: Linux 2.1.100 mips [ELF] 
> xdm error (pid 4268): Hung in XOpenDisplay(:0), aborting
> xdm error (pid 4268): server open failed for :0, giving up
> xdm error (pid 4265): Display :0 cannot be opened
I've never seen this kind of error before but the kernel you're using is
ancient, probably switching to a more recent one helps (2.2.16 and
2.4.0-test9 work fine for me). What version of glibc are you using? If
it is as old as your kernel you won't get anything to work.( I'm using
2.0.6-5lm here).
Regards,
 -- Guido
