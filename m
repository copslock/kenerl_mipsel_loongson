Received:  by oss.sgi.com id <S553665AbRCKNyE>;
	Sun, 11 Mar 2001 05:54:04 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:55057 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553655AbRCKNxr>;
	Sun, 11 Mar 2001 05:53:47 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id D38617F6; Sun, 11 Mar 2001 14:53:34 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 59FA7EFC1; Sun, 11 Mar 2001 16:52:08 +0100 (CET)
Date:   Sun, 11 Mar 2001 16:52:08 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Klaus Naumann <spock@mgnet.de>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Failure 2.4.2 + glibc 2.2 still illegal instruction
Message-ID: <20010311165208.C7415@paradigm.rfc822.org>
References: <20010310205028.B16121@paradigm.rfc822.org> <Pine.LNX.4.21.0103102131450.24319-100000@spock.mgnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0103102131450.24319-100000@spock.mgnet.de>; from spock@mgnet.de on Sat, Mar 10, 2001 at 09:34:00PM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Mar 10, 2001 at 09:34:00PM +0100, Klaus Naumann wrote:
> On Sat, 10 Mar 2001, Florian Lohoff wrote:
> I have also seen these things with tar and other stuff.
> Anyway - Keith said that it went away after he compiled
> glibc against 2.4.X (X > 1) kernel sources. Can
> anyone confirm that ?
> 
> > strace shows that the last system call called is
> > "sysmips(MIPS_ATOMIC_SET, ...)"
> 
> I have tried building strace but failed. What is your code base ? 

I am still using the very old strace 3.2 from the cobalt
distribution which is aehm - complicated - as i wont decode
everything and some things even wrong.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
