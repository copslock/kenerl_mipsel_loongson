Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0FKo7f31610
	for linux-mips-outgoing; Tue, 15 Jan 2002 12:50:07 -0800
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0FKo4P31607
	for <linux-mips@oss.sgi.com>; Tue, 15 Jan 2002 12:50:04 -0800
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 03BCA9F36; Tue, 15 Jan 2002 20:50:00 +0100 (CET)
Date: Tue, 15 Jan 2002 20:50:00 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@oss.sgi.com
Subject: Re: Perl on R4k6 (_not_ the segfault problem)
Message-ID: <20020115205000.R15285@lug-owl.de>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20020115190514.N15285@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020115190514.N15285@lug-owl.de>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux mail 2.4.15-pre2 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 2002-01-15 19:05:14 +0100, Jan-Benedict Glaw <jbglaw@lug-owl.de>
wrote in message <20020115190514.N15285@lug-owl.de>:
> Hi!
> 
> I'm facing another problem with Perl. (Again, this is on nfsroot.)
> Some perl scripts ( notably update-info) stall, they do not(!)

s/update-info/install-info/

install-info is provided by dpkg, so I can't simply uninstall the
package. I've "fixed" this bug for now by setting the shell bang
to /bin/true...

MfG, JBG

-- 
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/
