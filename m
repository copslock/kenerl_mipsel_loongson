Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6B1YD622061
	for linux-mips-outgoing; Tue, 10 Jul 2001 18:34:13 -0700
Received: from humbolt.nl.linux.org (IDENT:root@humbolt.nl.linux.org [131.211.28.48])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6B1YAV22058
	for <linux-mips@oss.sgi.com>; Tue, 10 Jul 2001 18:34:11 -0700
Received: from humbolt.nl.linux.org ([131.211.28.48]:39951 "HELO starship")
	by humbolt.nl.linux.org with SMTP id <S16469AbRGKBeH>;
	Wed, 11 Jul 2001 03:34:07 +0200
Content-Type: 	text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jun Sun <jsun@mvista.com>, linux-kernel@vger.kernel.org,
   linux-mips@oss.sgi.com
Subject: Re: memory alloc failuer : __alloc_pages: 1-order allocation failed.
Date: 	Wed, 11 Jul 2001 03:37:59 +0200
X-Mailer: KMail [version 1.2]
References: <3B4BA24E.1FB614B0@mvista.com>
In-Reply-To: <3B4BA24E.1FB614B0@mvista.com>
MIME-Version: 1.0
Message-Id: <0107110337590G.22952@starship>
Content-Transfer-Encoding: 7BIT
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wednesday 11 July 2001 02:48, Jun Sun wrote:
> Content-Type: text/plain; charset=us-ascii
> Content-Transfer-Encoding: 7bit
>
> I am running 2.4.2 on a linux/mips box, with 32MB system RAM (no
> swap).  When I run a stress test, I will hit memory allocation
> failure:
>
> __alloc_pages: 1-order allocation failed.
> IP: queue_glue: no memory for gluing queue 8108cce0

Next step: install the latest stable kernel and see if the problem 
persists.  (In this case I doubt it will)

--
Daniel
