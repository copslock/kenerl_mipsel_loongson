Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f93I5C920509
	for linux-mips-outgoing; Wed, 3 Oct 2001 11:05:12 -0700
Received: from dea.linux-mips.net (a1as01-p32.stg.tli.de [195.252.185.32])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f93I57D20506
	for <linux-mips@oss.sgi.com>; Wed, 3 Oct 2001 11:05:07 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f93I4us28398;
	Wed, 3 Oct 2001 20:04:56 +0200
Date: Wed, 3 Oct 2001 20:04:56 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Brian <signal@shreve.net>
Cc: linux-mips@oss.sgi.com
Subject: Re: How do I console into Origin 200?
Message-ID: <20011003200456.B28205@dea.linux-mips.net>
References: <5.1.0.14.2.20011003172659.00a6c4a8@mail.it-academy.bg> <Pine.LNX.4.33.0110030946270.13741-100000@mercury.shreve.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0110030946270.13741-100000@mercury.shreve.net>; from signal@shreve.net on Wed, Oct 03, 2001 at 09:48:20AM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Oct 03, 2001 at 09:48:20AM -0500, Brian wrote:

> I am trying to boot an Origin 200 (which I believe currently has IRIX on
> it, I will be installing linux-mips).  It has 2 9 pin serial connectors on
> the back.  I have hooked my Wyse terminal up to it with a serial cable
> with and without a null connector @ 9600bps.  Is this correct?  I get
> nothing on the screen.  I have never consoled into an Origin, and am not
> sure if I am doing this right.

Yes, that's correct and by default IRIX also runs a getty on the console.
So you probably want to doublecheck cables.  Also disable handshaking.

  Ralf

PS: Replying when you actually want to start a new thread is a bad idea.
