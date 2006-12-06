Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2006 08:40:55 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.171]:17489 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20038322AbWLFIkv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Dec 2006 08:40:51 +0000
Received: by ug-out-1314.google.com with SMTP id 40so83838uga
        for <linux-mips@linux-mips.org>; Wed, 06 Dec 2006 00:40:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BL1dD1A19paWMmd8HKOeGHSXepDDHyi5PWwq6cFUkgIRqRKLvst6lQ7i2RuYRl2YgBAncP+fdD9k/YeOjRwfK/6CA7NPjqox5FNM1KUIIxkEfMf3Is3UyK69zTZyby5rUKeRm4BJB70vW8jqtfofmqeW554dRZcsQqYnWH0vIyg=
Received: by 10.78.128.15 with SMTP id a15mr403269hud.1165394450547;
        Wed, 06 Dec 2006 00:40:50 -0800 (PST)
Received: by 10.78.123.2 with HTTP; Wed, 6 Dec 2006 00:40:50 -0800 (PST)
Message-ID: <cda58cb80612060040o17ec40f3x4c2f7d0037d3cd1@mail.gmail.com>
Date:	Wed, 6 Dec 2006 09:40:50 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>,
	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] Import updates from i386's i8259.c
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20061205195702.GA2097@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061206.012311.86891097.anemo@mba.ocn.ne.jp>
	 <20061205194907.GA1088@linux-mips.org>
	 <20061205195702.GA2097@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 12/5/06, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Dec 05, 2006 at 07:49:07PM +0000, Ralf Baechle wrote:
>
> > > Import many updates from i386's i8259.c, especially genirq
> > > transitions.
> >
> > With this patch applied Malta fails ...
>
> Which meant I removed this patch from my tree for now.  Which means nothing
> is blocking Franck's patch anymore so I applied it with a trivial build fix
> to irq_cpu.c.
>

Thanks !

Except the mips_mt_cpu_irq_controller have not used flow handler yet
as Astushi already reported.

Atsushi, could you take care of removing "select
GENERIC_HARDIRQS_NO__DO_IRQ" in your patch where needed ? specially
all boards based on NEC VR41XX cpu.

thanks
-- 
               Franck
