Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g46CpawJ016313
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 6 May 2002 05:51:36 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g46Cpaln016312
	for linux-mips-outgoing; Mon, 6 May 2002 05:51:36 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g46CpWwJ016306
	for <linux-mips@oss.sgi.com>; Mon, 6 May 2002 05:51:32 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id FAA03423
	for <linux-mips@oss.sgi.com>; Mon, 6 May 2002 05:52:42 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id FAA20156;
	Mon, 6 May 2002 05:51:41 -0700 (PDT)
Message-ID: <01db01c1f4fd$94f6ccb0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Kjeld Borch Egevang" <kjelde@mips.com>,
   "linux-mips mailing list" <linux-mips@oss.sgi.com>
References: <Pine.LNX.4.44.0205061440210.21711-100000@coplin19.mips.com>
Subject: Re: zsh on console
Date: Mon, 6 May 2002 14:57:28 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> When I run zsh on the console (serial interface) the process hangs. I can 
> login with /bin/bash, but when I start /bin/zsh it waits forever. I can 
> interrupt the process and regain control.
> 
> It's only related to the console. If I login with telnet it works just 
> fine.
> 
> Any idea, what could be wrong?

I don't know what it would be specifically, but having
dealt with similar problems on other Unix systems,
it's proably the case that zsh uses a particular tty
mode that isn't correctly supported by the serial
console driver, either due to a bug in the driver or
due to a conflict with some other feature enabled
on the console port.  The next step to take would
be to run "stty -all" under /bin/bash and under
/bin/zsh on a telnet session, and compare the 
outputs.
