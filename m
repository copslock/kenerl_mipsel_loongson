Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2009 20:23:28 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:61573 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S21365339AbZAOUX0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Jan 2009 20:23:26 +0000
Received: (qmail 9201 invoked by uid 1000); 15 Jan 2009 21:22:10 +0100
Date:	Thu, 15 Jan 2009 21:22:10 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 06/14] MIPS: print irq handler description
Message-ID: <20090115202210.GC8656@roarinelk.homelinux.net>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net> <caebb02f97491d8e5830438e1a746b0e02fa2c7c.1229846411.git.mano@roarinelk.homelinux.net> <80cf5c7a0db39a7230bae7766264acbfc68d200e.1229846412.git.mano@roarinelk.homelinux.net> <e6862a9acc480a4f00d0b7ae738e8a355a7e4810.1229846412.git.mano@roarinelk.homelinux.net> <ac2064c64b746420a21008fa4e9e7c4ecf048d7a.1229846413.git.mano@roarinelk.homelinux.net> <dc79b2a4d9da426f867de084c75940109eff1287.1229846413.git.mano@roarinelk.homelinux.net> <535458cb8c8f570089b2712a1e73ca7314d5b7c7.1229846413.git.mano@roarinelk.homelinux.net> <496F90AA.7070407@caviumnetworks.com> <20090115194921.GB8656@roarinelk.homelinux.net> <496F9579.7050300@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <496F9579.7050300@caviumnetworks.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

David,

On Thu, Jan 15, 2009 at 11:58:49AM -0800, David Daney wrote:
> Manuel Lauss wrote:
> [...]
>> Or how about this?
> [...]  		seq_printf(p, " %14s", irq_desc[i].chip->name);
>> -		seq_printf(p, "-%-8s", irq_desc[i].name);
>> +		if (irq_desc[i].name)
>> +			seq_printf(p, "-%-8s", irq_desc[i].name);
>>  		seq_printf(p, "  %s", action->name);
>
> I will let you and Ralf decide.  However it would be nice if action->name 
> lined up with a mixture of NULL and non-NULL irq_desc[i].name.  It is not 
> clear to me if this is the case with your patch.

Good point, no it's not the case unfortunately; the gap between
the controller and irq names becomes unaesthetically wide.

So please revert the patch.

Thanks!
	Manuel Lauss
