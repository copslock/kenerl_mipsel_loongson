Received:  by oss.sgi.com id <S42256AbQHFPOk>;
	Sun, 6 Aug 2000 08:14:40 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:36620 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S42254AbQHFPOX>;
	Sun, 6 Aug 2000 08:14:23 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 86F1A7F5; Sun,  6 Aug 2000 16:50:13 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 590408FF5; Fri,  4 Aug 2000 20:58:16 +0200 (CEST)
Date:   Fri, 4 Aug 2000 20:58:16 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Keith M Wesolowski <wesolows@foobazco.org>
Cc:     linux-mips@oss.sgi.com
Subject: Re: sgi prom console
Message-ID: <20000804205816.B313@paradigm.rfc822.org>
References: <20000726215416.A18398@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20000726215416.A18398@foobazco.org>; from wesolows@foobazco.org on Wed, Jul 26, 2000 at 09:54:16PM -0700
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jul 26, 2000 at 09:54:16PM -0700, Keith M Wesolowski wrote:
> 
> This patch gets the sgi prom console outputting again, and eliminates
> the "cannot open initial console" error. Unfortunately, all output
> from userland goes to the serial port, not the the prom console.
> Looking at the code, this isn't at all surprising; the prom console
> pretends to be 4,64, ttyS0. It's quite beyond me how the prom console
> could ever have worked for userland.

It never has :) - There is a major difference between the console
for the Kernel (Really called console in the kernel) and a TTY. The
TTY implementation for the Prom Console has never been done from what
i see in the code - Although this would be quiet helpful to do
a full implementation for a TTY as we than had the possibility to
boot the Indigo2 etc with Framebuffer/Keyboard.

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
     "If you're not having fun right now, you're wasting your time."
