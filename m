Received:  by oss.sgi.com id <S42254AbQHFPOu>;
	Sun, 6 Aug 2000 08:14:50 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:36876 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S42236AbQHFPOX>;
	Sun, 6 Aug 2000 08:14:23 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id ACC5E7F6; Sun,  6 Aug 2000 16:50:13 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 049028FF5; Fri,  4 Aug 2000 21:03:04 +0200 (CEST)
Date:   Fri, 4 Aug 2000 21:03:04 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Famille Chauvat <famille.chauvat@free.fr>
Cc:     linux-mips@oss.sgi.com
Subject: Re: [Install trouble]
Message-ID: <20000804210304.C313@paradigm.rfc822.org>
References: <39847F16.543AA232@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <39847F16.543AA232@free.fr>; from famille.chauvat@free.fr on Sun, Jul 30, 2000 at 07:16:38PM +0000
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Jul 30, 2000 at 07:16:38PM +0000, Famille Chauvat wrote:
> Hello,
> 
> I'm working with an Indy station and the corresponding kernel.
> On the bootp() step, i got a message:
> >>>>>>>
> 
> creating 100k of ramdisk space... done
> mounting /tmp from ramdisk... failed
> 
> I can't recover from this.
> <<<<<<<

Probably this is a kernel with no ramdisk support ?  Ah wait - No - 
You have booted the kernel with a read-only root - Which means - When
mounting /tmp i tries to write /etc/mtab which is read-only - Try
to append "rw" to your prom console boot line

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
     "If you're not having fun right now, you're wasting your time."
