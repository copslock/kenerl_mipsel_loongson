Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g08DjxN05377
	for linux-mips-outgoing; Tue, 8 Jan 2002 05:45:59 -0800
Received: from emma.patton.com (emma.patton.com [209.49.110.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g08Djug05374
	for <linux-mips@oss.sgi.com>; Tue, 8 Jan 2002 05:45:56 -0800
Received: from patton.com (decpc.patton.com [209.49.110.83])
	by emma.patton.com (8.9.0/8.9.0) with ESMTP id HAA15849;
	Tue, 8 Jan 2002 07:46:02 -0500 (EST)
Message-ID: <3C3AE9FC.F34C9794@patton.com>
Date: Tue, 08 Jan 2002 07:45:48 -0500
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

I also have a hacked-up port of MontaVista's HHLinux gt96100eth code
that is functional on 64240 and 64240A in little-endian mode and
untested in BE.  It still lacks support for any "advanced" features of
the Galileo chips.

-- 
 /"\ . . . . . . . . . . . . . . . /"\
 \ /   ASCII Ribbon Campaign       \ /     Paul R. Kasper
  X    - NO HTML/RTF in e-mail      X      Patton Electronics Co.
 / \   - NO MSWord docs in e-mail  / \     301-975-1000 x173
