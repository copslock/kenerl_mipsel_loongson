Received:  by oss.sgi.com id <S42211AbQGQRGl>;
	Mon, 17 Jul 2000 10:06:41 -0700
Received: from rotor.chem.unr.edu ([134.197.32.176]:40198 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S42208AbQGQRGI>;
	Mon, 17 Jul 2000 10:06:08 -0700
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id KAA07383;
	Mon, 17 Jul 2000 10:05:34 -0700
Date:   Mon, 17 Jul 2000 10:05:34 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     Keith M Wesolowski <wesolows@foobazco.org>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Analysis of Samba configure oops
Message-ID: <20000717100534.D6424@chem.unr.edu>
References: <20000716182428.A972@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20000716182428.A972@foobazco.org>; from wesolows@foobazco.org on Sun, Jul 16, 2000 at 06:24:28PM -0700
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Jul 16, 2000 at 06:24:28PM -0700, Keith M Wesolowski wrote:

Responding to my own mail, yeesh. I was obviously suffering a dumbass
attack when I wrote this.

> Code;  8801eb1c <r4k_flush_cache_page_s128d16i16+74/324>
>    8:   8ce5003c  lw      $a1,60($a3)
> Code;  8801eb20 <r4k_flush_cache_page_s128d16i16+78/324>   <=====
>    c:   8c62003c  lw      $v0,60($v1)   <=====
> 
> The fault address is 0x3c. The offset of mm in current is 0x2c. Thus
> the immediate cause appears to be that current->mm is 0x10, obviously
> nonsense.

The interesting bit is not current->mm, but current->mm->context. The
offset of context is 60 as shown above in the disassembly. 60 = 3c, so
it's clear that current->mm is in fact NULL.

Hope this makes things a bit clearer.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
