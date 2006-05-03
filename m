Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 May 2006 17:14:32 +0100 (BST)
Received: from witte.sonytel.be ([80.88.33.193]:161 "EHLO witte.sonytel.be")
	by ftp.linux-mips.org with ESMTP id S8133465AbWECQOV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 May 2006 17:14:21 +0100
Received: from pademelon.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id k43GEJCQ017887;
	Wed, 3 May 2006 18:14:19 +0200 (MEST)
Date:	Wed, 3 May 2006 18:14:18 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Ratin <mrahman@sypixx.com>
cc:	Freddy Spierenburg <freddy@dusktilldawn.nl>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: changing IP address on mipsel-linux
In-Reply-To: <005501c66ecc$4b2ef470$2300a8c0@ratin>
Message-ID: <Pine.LNX.4.62.0605031813190.11602@pademelon.sonytel.be>
References: <4456960D.70403@telus.net> <20060502193838.GA3474@linux-mips.org>
 <007e01c66e2e$8008f720$2300a8c0@ratin> <20060503071103.GC11097@dusktilldawn.nl>
 <005501c66ecc$4b2ef470$2300a8c0@ratin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 3 May 2006, Ratin wrote:
> Hi Freddy, Thanks for your response, I appreciate your help. I am kind of new
> to this version of Linux.
> The uname -a gives me this:
> 
> Linux 192.168.0.62 2.6.10-idt20050328 #1 Tue Dec 13 10:36:55 PST 2005 mips
> unknown
> 
> But it is referred as Mipsel-Linux. It is running busybox.  I guess I have to
> dig more into kernel code to see how the
> kernel sets the IP address during init. I was hoping somebody here would know
> the Mipsel-Linux IP address assignment
> process. Thanks,

The kernel does not set the IP address during init. That's the responsibility
of user space, i.e. the scripts that call busybox in your case.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
