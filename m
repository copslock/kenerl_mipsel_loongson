Received:  by oss.sgi.com id <S553831AbQLRLHp>;
	Mon, 18 Dec 2000 03:07:45 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:23561 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553837AbQLRLH2>;
	Mon, 18 Dec 2000 03:07:28 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 93A107FC; Mon, 18 Dec 2000 12:07:25 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id D608E8F74; Mon, 18 Dec 2000 12:07:14 +0100 (CET)
Date:   Mon, 18 Dec 2000 12:07:14 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Martin Michlmayr <tbm@cyrius.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Kernel Oops when booting on DECstation
Message-ID: <20001218120714.C401@paradigm.rfc822.org>
References: <20001216085603.A514@sumpf.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001216085603.A514@sumpf.cyrius.com>; from tbm@cyrius.com on Sat, Dec 16, 2000 at 08:56:03AM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Dec 16, 2000 at 08:56:03AM +0100, Martin Michlmayr wrote:

> Linux version 2.4.0-test8-pre1 (flo@slimer.rfc822.org) (gcc version egcs-2.90.20
[...]
> Any ideas?  (I hope and think that it has nothing to do with me
> booting from a NetBSD partition.  I don't have ethernet on the machine
> and thus have to boot the kernel from the existing FFS partition in
> order to start Linux and then run delo.  NetBSD boots and works, btw.)

I have the suspicion that you are running into a bug Harald and me
solved when booting my /150 from Disk. It seems the Firmware KN04 V2.1k
doesnt correctly reset/disable the SCSI Controller and the Ethernet
chip causing the system to crash immediatly in the "request_irq" section.

I guess the backtrace is bogus but i might be wrong. I would recommend
trying to compile a current cvs kernel yourself and retry.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
