Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0FImln28939
	for linux-mips-outgoing; Tue, 15 Jan 2002 10:48:47 -0800
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0FImhP28936
	for <linux-mips@oss.sgi.com>; Tue, 15 Jan 2002 10:48:44 -0800
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id B6DC3A092; Tue, 15 Jan 2002 18:48:39 +0100 (CET)
Date: Tue, 15 Jan 2002 18:48:39 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@oss.sgi.com
Subject: -ELOOP: Problem during package installation
Message-ID: <20020115184839.M15285@lug-owl.de>
Mail-Followup-To: linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux mail 2.4.15-pre2 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi!

I'm running the standard debian kernel that comes with a plain
installation on a R4k6 Indy. When installing packages (dpkg --install
....) I sometimes get error messages that there have been too
many links in file name chain (-ELOOP). This only happens sometimes,
and is not reproduceable. So, if a package failed to install, I
can try it again, any may have success...

Oh, this is on nfsroot...

MfG, JBG

-- 
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/
