Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4RDP4nC006218
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 27 May 2002 06:25:04 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4RDP4LF006217
	for linux-mips-outgoing; Mon, 27 May 2002 06:25:04 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4RDP1nC006212
	for <linux-mips@oss.sgi.com>; Mon, 27 May 2002 06:25:01 -0700
Received: from localhost.localdomain ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 17CKVp-0008Dh-00; Mon, 27 May 2002 08:26:13 -0500
Message-ID: <3CF233DA.2040602@realitydiluted.com>
Date: Mon, 27 May 2002 08:25:46 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020520 Debian/1.0rc2-3
MIME-Version: 1.0
To: "Kevin D. Kissell" <kevink@mips.com>
CC: linux-mips@oss.sgi.com
Subject: Re: PCI Graphics/Video Card for Malta Board?
References: <019401c20563$e7f6af40$10eca8c0@grendel>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Kevin D. Kissell wrote:
 >
> I'd like to get a video-capable graphics card up
> and running on a MIPS Malta board (therefore
> PCI), ideally something mainstream like ATI.
> Does anyone on the list have any positive or
> negative recommendations in terms of cards
> and particularly in terms of the degree to which
> the drivers (and PCI set-up) have been ported
> to MIPS/Linux?  I'll do what I must, but I hate
> re-inventing the wheel.
> 
I can think of two things. First, a lot of graphics cards
rely on BIOS calls to be set up before the operating system
even boots. Second, I would stick to graphics cards that
have framebuffer support in the kernel as you stand at least
half a chance that those cards don't rely so heavily on a
peecee bios. Just my $.02.

-Steve
