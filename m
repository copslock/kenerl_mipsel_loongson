Received:  by oss.sgi.com id <S42274AbQHHWEu>;
	Tue, 8 Aug 2000 15:04:50 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:17678 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S42218AbQHHWEW>;
	Tue, 8 Aug 2000 15:04:22 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 4184C7F7; Wed,  9 Aug 2000 00:05:52 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id E632A8FF5; Mon,  7 Aug 2000 10:16:20 +0200 (CEST)
Date:   Mon, 7 Aug 2000 10:16:20 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Famille Chauvat <famille.chauvat@free.fr>
Cc:     linux-mips@oss.sgi.com
Subject: Re: [Install trouble]
Message-ID: <20000807101620.B302@paradigm.rfc822.org>
References: <39847F16.543AA232@free.fr> <20000804210304.C313@paradigm.rfc822.org> <398D7E42.88D4005E@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <398D7E42.88D4005E@free.fr>; from famille.chauvat@free.fr on Sun, Aug 06, 2000 at 03:03:30PM +0000
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Aug 06, 2000 at 03:03:30PM +0000, Famille Chauvat wrote:
> Hi Florian,
> 
> Thanks for your response. Humm, I don't know how to boot with rw support...
> And, Keith M Wesolowski, see messages in this thread, modify the kernel to
> have a ramdisk support.

Look into /usr/src/linux/Documentation 

Booting with an "rw" root you just have to append "rw" to the command
line you boot with ...

> That what I don't understand, except a lot of another things :-), is how it
> runs. You know, I took a lot of things on internet, I read a lot of papers,
> perhaps not those I had to, and I've never ask to support or not the
> ramdisk. So my question is, how the kernel I took doesn't support something
> I never asked for. I'm not sure to be very clear :-)

Not the kernel uses it - The installer does - The installer tries
to create a /tmp filesystem in a ramdisk to proceed installation.
When there is no ramdisk support the /tmp filesystem creation will fail.

> With the new kernel I have, I've a new trouble. After the partition step, a
> message "mount failed, bad address" appears and I 've to reboot. Of course,
> the next time I'ld the same things. Any suggestion, any help, would be very
> appreciate.

No idea

> Btw, if you know someone of your team or friends who speak french, it could
> be better, for me, to explain what going wrong.

Sorry - Cant help you :)

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
     "If you're not having fun right now, you're wasting your time."
