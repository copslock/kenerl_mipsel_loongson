Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8TAKrE00322
	for linux-mips-outgoing; Sat, 29 Sep 2001 03:20:53 -0700
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8TAKoD00319
	for <linux-mips@oss.sgi.com>; Sat, 29 Sep 2001 03:20:51 -0700
Received: from galadriel.physik.uni-konstanz.de [134.34.144.79] (8)
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 15nHEl-0004Ue-00; Sat, 29 Sep 2001 12:20:47 +0200
Received: from agx by galadriel.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 15nHEj-0003Kw-00; Sat, 29 Sep 2001 12:20:45 +0200
Date: Sat, 29 Sep 2001 12:20:45 +0200
From: Guido Guenther <agx@debian.org>
To: debian-mips@lists.debian.org, linux-mips@oss.sgi.com
Subject: Re: Need an account on a Linux/Mips box
Message-ID: <20010929122045.A12811@galadriel.physik.uni-konstanz.de>
Mail-Followup-To: debian-mips@lists.debian.org, linux-mips@oss.sgi.com
References: <1f05gge.7bt3xkxllentM@[10.0.12.137]> <vzay9n46373.fsf@false.linpro.no> <20010924173723.A2203@bunny.shuttle.de> <vzawv2o4kwe.fsf@false.linpro.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <vzawv2o4kwe.fsf@false.linpro.no>; from kristoffer@linpro.no on Mon, Sep 24, 2001 at 06:24:17PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Sep 24, 2001 at 06:24:17PM +0200, Kristoffer Gleditsch wrote:
[..snip..] 
> Apart from sshd (OpenSSH), which started dying from SIGFPE (floating
> point exception, whatever that means :) a few days ago, it's working
> OK.
Toolchain update problem - recompiling fixes this. I've put recompiled
debs at:

http://honk.physik.uni-konstanz.de/linux-mips/debian/ssl-tmp/

 -- Guido

-- 
This kind of limitation can lead administrators to do irrational things,
      like install Windows. Clearly a fix was required. (lwn.net)
