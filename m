Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB310iZ11999
	for linux-mips-outgoing; Sun, 2 Dec 2001 17:00:44 -0800
Received: from buzz.ichilton.co.uk (pc3-stoc4-0-cust138.mid.cable.ntl.com [213.107.175.138])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB310eo11996
	for <linux-mips@oss.sgi.com>; Sun, 2 Dec 2001 17:00:40 -0800
Received: by buzz.ichilton.co.uk (Postfix, from userid 100)
	id C58911CE31E; Mon,  3 Dec 2001 00:00:36 +0000 (GMT)
Date: Mon, 3 Dec 2001 00:00:36 +0000
From: Ian Chilton <mailinglist@ichilton.co.uk>
To: linux-mips@oss.sgi.com
Subject: 2.4.16 success on Indy (was Re: 2.4.16 success on Decstation 5000/150)
Message-ID: <20011203000036.A10356@buzz.ichilton.local>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
References: <20011203000338.A30090@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011203000338.A30090@paradigm.rfc822.org>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

> the current cvs (as of a couple hours ago) works without additional
> patches on my Decstation 5000/150 like a charm:

It also worked for me earlier on an Indy R4600 - 1st kernel I have had
properly boot since 2.4-test9 IIRC.


/proc/cpuinfo output:

processor               : 0
cpu model               : R4600 V2.0  FPU V2.0
BogoMIPS                : 100.23
wait instruction        : yes
microsecond timers      : yes
extra interrupt vector  : no
hardware watchpoint     : no
VCED exceptions         : not available
VCEI exceptions         : not available


Bye for Now,

Ian
