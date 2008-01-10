Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jan 2008 16:49:07 +0000 (GMT)
Received: from an-out-0708.google.com ([209.85.132.250]:20207 "EHLO
	an-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S28577544AbYAJQs7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 Jan 2008 16:48:59 +0000
Received: by an-out-0708.google.com with SMTP id d26so172750and.64
        for <linux-mips@linux-mips.org>; Thu, 10 Jan 2008 08:48:57 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=bVT2nsH0pOK0c4/FN70aeR4APjP4gLURzOyO4N0qRgA=;
        b=xJLkNr/muViISVUHbHeBTa5OOWdNsJ5CegPswAJyZ6n+1t+y+E987wmmri+sSIPFEjchOL/PYmInbRZMHl6JA9+uF7GE+axeOdivJaz+AMiNByHbWDxhLwTNgKOSGTsXOAZu/gfFau6O9ya4XkDcILytGA0La+nJw33Qb3qKTdw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AryJ9zNEL46wJOfluHpe+AEwm3hrNRSne1L0BvRD1TvvmGyFXqtHaTKjQIcFeyBrBNBiLUwxrOWQkpccBy2RCD0LXumRisaGO4xAIUwuw/Cb0oYAmg4MjA47Ph5JGgABCUUgpPXN09SqSvVwfn4M7VS1G+C68unNw2jIHwrYfOc=
Received: by 10.100.94.14 with SMTP id r14mr4542839anb.101.1199983737107;
        Thu, 10 Jan 2008 08:48:57 -0800 (PST)
Received: by 10.100.163.14 with HTTP; Thu, 10 Jan 2008 08:48:57 -0800 (PST)
Message-ID: <acd2a5930801100848o36935a1al44c6b16eb746dcff@mail.gmail.com>
Date:	Thu, 10 Jan 2008 19:48:57 +0300
From:	"Vitaly Wool" <vitalywool@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: pnx8xxx: move to clocksource
Cc:	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
In-Reply-To: <20080110162744.GA16880@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4786273D.7010006@gmail.com> <478645FD.2090708@ru.mvista.com>
	 <20080110162744.GA16880@linux-mips.org>
Return-Path: <vitalywool@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vitalywool@gmail.com
Precedence: bulk
X-list: linux-mips

> >    Something probably have converted tabs to 8 spaces...

No, it's just the lines of original code moved.

> > [...]
> >
> >> +static struct clock_event_device pnx8xxx_clockevent = {
> >> +    .name        = "pnx8xxx_clockevent",
> >> +    .features    = CLOCK_EVT_FEAT_ONESHOT,
> >
> >    Aren't PNX8550 timers actually periodic in nature?
>
> All I recall is they were odd ;-)
>
> The hardware nature of timers and how to declare them to the Linux timer
> code is not always the same.  CLOCK_EVT_FEAT_ONESHOT be used if the
> time to the next shot can be programmed.

Absolutely :)

> >    Enabling timers before they are actually set up? :-|
>
> Are the additional timers used at all?

Heh, that also was the original code which was just moved from one
place in the file to the other.

Sergei, I decided not to mix whitespace cleanups and the clocksource
changes. I'll come up with the whitespace/tab fixups soon arranging it
as a separate patch.

Vitaly
