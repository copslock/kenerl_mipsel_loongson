Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9QIC0b01302
	for linux-mips-outgoing; Fri, 26 Oct 2001 11:12:00 -0700
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9QIBx001299
	for <linux-mips@oss.sgi.com>; Fri, 26 Oct 2001 11:11:59 -0700
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f9QIBJE0008908;
	Fri, 26 Oct 2001 11:11:19 -0700
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f9QIBGFL008904;
	Fri, 26 Oct 2001 11:11:19 -0700
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Fri, 26 Oct 2001 11:11:16 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Pete Popov <ppopov@pacbell.net>
cc: Wayne Gowcher <wgowcher@yahoo.com>, linux-mips@oss.sgi.com
Subject: Re: Backspace on Virtual Console causes oops
In-Reply-To: <1004119562.14540.3.camel@adsl.pacbell.net>
Message-ID: <Pine.LNX.4.10.10110261110090.2184-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> I'll make a guess.  With no input at the line, when you hit backspace,
> the shell is probably generating a beep.  Your kernel is not handling
> that.  I don't remember exactly where the "beep code" was but you can
> probably find it pretty quickly.

linux/drivers/char/vt.c.

It is the functions kd_nosound and _kd_mksound.
