Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Oct 2002 18:56:00 +0200 (CEST)
Received: from 12-234-88-146.client.attbi.com ([12.234.88.146]:61654 "EHLO
	lucon.org") by linux-mips.org with ESMTP id <S1123897AbSJEQ4A>;
	Sat, 5 Oct 2002 18:56:00 +0200
Received: by lucon.org (Postfix, from userid 1000)
	id 00E312C59D; Sat,  5 Oct 2002 09:55:53 -0700 (PDT)
Date: Sat, 5 Oct 2002 09:55:53 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: linux-mips@linux-mips.org
Subject: [hjl@lucon.org: Re: Does swap on IDE HD work on malta/mipsel?]
Message-ID: <20021005095553.A4302@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

My emails sent to linux-mips.org were bounced back. Has swap on IDE HD
been fixed?


H.J.
----- Forwarded message from "H. J. Lu" <hjl@lucon.org> -----

Date: Sat, 28 Sep 2002 00:34:11 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Does swap on IDE HD work on malta/mipsel?
User-Agent: Mutt/1.2.5.1i

On Fri, Sep 27, 2002 at 11:03:07PM -0700, H. J. Lu wrote:
> I compiled today's 2.4 kernel from CVS. Swap on IDE HD doesn't work. I
> got
> 
> # mkswap /dev/hda3
> Setting up swapspace version 1, size = 512060K
> # swapon /dev/hda3
> swapon: /dev/hda3: Invalid argument
> 
> and kernel reported
> 
> Unable to find swap-space signature
> 
> BTW, it used to work fine.
> 

After switching to 2.4.19 with

# cvs update -A -r linux_2_4_19 -dP

swap works fine.


H.J.

----- End forwarded message -----
