Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0FKloE31514
	for linux-mips-outgoing; Tue, 15 Jan 2002 12:47:50 -0800
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0FKlkP31511
	for <linux-mips@oss.sgi.com>; Tue, 15 Jan 2002 12:47:46 -0800
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 2C1229F36; Tue, 15 Jan 2002 20:47:42 +0100 (CET)
Date: Tue, 15 Jan 2002 20:47:42 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@oss.sgi.com
Subject: Re: -ELOOP: Problem during package installation
Message-ID: <20020115204742.Q15285@lug-owl.de>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20020115184839.M15285@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020115184839.M15285@lug-owl.de>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux mail 2.4.15-pre2 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 2002-01-15 18:48:39 +0100, Jan-Benedict Glaw <jbglaw@lug-owl.de>
wrote in message <20020115184839.M15285@lug-owl.de>:
> I'm running the standard debian kernel that comes with a plain
> installation on a R4k6 Indy. When installing packages (dpkg --install
> ....) I sometimes get error messages that there have been too
> many links in file name chain (-ELOOP). This only happens sometimes,
> and is not reproduceable. So, if a package failed to install, I
> can try it again, any may have success...
> 
> Oh, this is on nfsroot...

Well, I've just seen this in dmesg's output:

kernel: nfs_refresh_inode: inode 424854012 mode changed, 0120777 to 0100000

I brute-force installed some packages, and magically, whenever I
see the -ELOOP bug, I get (at least) one of the above messages:-)

MfG, JBG

-- 
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/
