Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Feb 2008 17:04:37 +0000 (GMT)
Received: from smtp.movial.fi ([62.236.91.34]:45764 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S20027001AbYBSREf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Feb 2008 17:04:35 +0000
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 7FEE0C8175;
	Tue, 19 Feb 2008 17:04:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id r5MP8qtaOW5L; Tue, 19 Feb 2008 19:04:29 +0200 (EET)
Received: from ext-ssh.movial.fi (ext-ssh.movial.fi [62.236.91.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id 63F74C8010;
	Tue, 19 Feb 2008 17:04:29 +0000 (UTC)
Received: by ext-ssh.movial.fi (Postfix, from userid 30103)
	id 51E682006F; Tue, 19 Feb 2008 19:04:29 +0200 (EET)
Date:	Tue, 19 Feb 2008 19:04:29 +0200
From:	Adrian Bunk <adrian.bunk@movial.fi>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Aurelien Jarno <aurelien@aurel32.net>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: mips: compile testing of 2.6.25-rc2
Message-ID: <20080219170429.GC23655@movial.fi>
References: <20080218010314.GO1403@cs181133002.pp.htv.fi> <20080219165008.GA14178@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20080219165008.GA14178@linux-mips.org>
User-Agent: Mutt/1.5.9i
Return-Path: <adrian.bunk@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adrian.bunk@movial.fi
Precedence: bulk
X-list: linux-mips

On Tue, Feb 19, 2008 at 04:50:08PM +0000, Ralf Baechle wrote:
> On Mon, Feb 18, 2008 at 03:03:14AM +0200, Adrian Bunk wrote:
> 
> > I did a compile testing of all mips defconfigs in 2.6.25-rc2.
> 
> There is a public autobuilder at http://mipslinux.simtec.co.uk/kautobuild.

Neat, I only knew about http://armlinux.simtec.co.uk/kautobuild/ .

Are arm and mips the only architectures with autobuilders there or are 
more architectures available?

>   Ralf

cu
Adrian
