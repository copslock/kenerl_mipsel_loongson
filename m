Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 16:52:43 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:19682 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20038442AbWLAQwi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2006 16:52:38 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 380433ECA; Fri,  1 Dec 2006 08:52:33 -0800 (PST)
Message-ID: <45705E34.2030704@ru.mvista.com>
Date:	Fri, 01 Dec 2006 19:54:12 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Compile __do_IRQ() when really needed
References: <457042FF.2060908@innova-card.com>	 <20061202.004527.52131670.anemo@mba.ocn.ne.jp> <cda58cb80612010847g30213daau80c636b9dfc7dce3@mail.gmail.com>
In-Reply-To: <cda58cb80612010847g30213daau80c636b9dfc7dce3@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Franck Bui-Huu wrote:

>> > @@ -468,6 +473,7 @@ config DDB5477
>> >  config MACH_VR41XX
>> >       bool "NEC VR41XX-based machines"
>> >       select SYS_HAS_CPU_VR41XX
>> > +     select GENERIC_HARDIRQS_NO__DO_IRQ
>> >
>> >  config PMC_YOSEMITE
>> >       bool "PMC-Sierra Yosemite eval board"

>> Same here.

> are you sure ? I don't see any traces of i8259 selection.
> Moreover, Yoichi's vr41xx boards seem to have no problem

   CMB-Vr4133 has the Rockhopper backplane with 8259 integrated into ALi chip 
-- and it is supported via CONFIG_ROCKHOPPER.

> I agree with all the rest.

> Thanks

WBR, Sergei
