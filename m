Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2009 16:32:27 +0100 (CET)
Received: from www.tglx.de ([62.245.132.106]:58351 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493371AbZKCPcU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Nov 2009 16:32:20 +0100
Received: from localhost (www.tglx.de [127.0.0.1])
	by www.tglx.de (8.13.8/8.13.8/TGLX-2007100201) with ESMTP id nA3FTfBc029842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 3 Nov 2009 16:29:42 +0100
Date:	Tue, 3 Nov 2009 16:29:41 +0100 (CET)
From:	Thomas Gleixner <tglx@linutronix.de>
To:	Linus Walleij <linus.ml.walleij@gmail.com>
cc:	Linus Walleij <linus.walleij@stericsson.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@linux-mips.org, Mikael Pettersson <mikpe@it.uu.se>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Make MIPS dynamic clocksource/clockevent clock code
 generic v2
In-Reply-To: <63386a3d0911030551j1accd6fby7038895df544385b@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.0911031628480.12138@localhost.localdomain>
References: <1256078002-27919-1-git-send-email-linus.walleij@stericsson.com>  <63386a3d0910251518i42149642g183f2d3f6c43384f@mail.gmail.com> <63386a3d0911030551j1accd6fby7038895df544385b@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: clamav-milter 0.95.1 at www.tglx.de
X-Virus-Status:	Clean
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

On Tue, 3 Nov 2009, Linus Walleij wrote:
> > Ping on tglx on this, I will uninline the functions if you think
> > it's better in the long run, just tell me, else can you pick this
> > patch?
> 
> Ping again...

Still catching up with mail backlog. Will come to this in the next
days.

      tglx
