Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g08DKBD04553
	for linux-mips-outgoing; Tue, 8 Jan 2002 05:20:11 -0800
Received: from emma.patton.com (emma.patton.com [209.49.110.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g08DK7g04550
	for <linux-mips@oss.sgi.com>; Tue, 8 Jan 2002 05:20:07 -0800
Received: from patton.com (decpc.patton.com [209.49.110.83])
	by emma.patton.com (8.9.0/8.9.0) with ESMTP id HAA15566;
	Tue, 8 Jan 2002 07:20:09 -0500 (EST)
Message-ID: <3C3AE3EE.761CB1CD@patton.com>
Date: Tue, 08 Jan 2002 07:19:58 -0500
From: Paul Kasper <paul@patton.com>
Reply-To: paul@patton.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ellis@spinics.net
CC: linux-mips@oss.sgi.com
Subject: Re: Galileo 64240
References: <200201072217.g07MHrY20022@spinics.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

ellis@spinics.net wrote:
> 
> Is there any support code around for the Galileo 64240?  A serial
> driver would be really nice ;)

I started an MPSC/Uart driver for the 64240/64240A chips.  Didn't get
much of it working when we got fed up with all of the Galileo errata
about which registers could or could not be read at which times and
their confusion as to whether or not they were planning to ever fix the
errata.

We broke down and added a 162550 UART to the board.

The driver code was abandoned in the midst of early debugging stages and
is in a horrific state.  You're welcome to a copy if you really can't
find something better.

-- 
 /"\ . . . . . . . . . . . . . . . /"\
 \ /   ASCII Ribbon Campaign       \ /     Paul R. Kasper
  X    - NO HTML/RTF in e-mail      X      Patton Electronics Co.
 / \   - NO MSWord docs in e-mail  / \     301-975-1000 x173
