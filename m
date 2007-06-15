Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2007 15:41:27 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:63001 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20022442AbXFOOlZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2007 15:41:25 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 1CD443ECA; Fri, 15 Jun 2007 07:40:53 -0700 (PDT)
Message-ID: <4672A55E.7000109@ru.mvista.com>
Date:	Fri, 15 Jun 2007 18:42:38 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time
 code.
References: <11818164011355-git-send-email-fbuihuu@gmail.com> <11818164023940-git-send-email-fbuihuu@gmail.com> <20070614111748.GA8223@alpha.franken.de> <cda58cb80706140643g63c3bf34sbd5b843a15653c3d@mail.gmail.com> <Pine.LNX.4.64N.0706141501080.25868@blysk.ds.pg.gda.pl> <cda58cb80706140731j1b6e8e36l96d4423db1ffd9e7@mail.gmail.com> <Pine.LNX.4.64N.0706141648540.25868@blysk.ds.pg.gda.pl> <cda58cb80706150159j5c3d5b7p4293dc529d5ee97c@mail.gmail.com> <20070615134948.GB16133@linux-mips.org>
In-Reply-To: <20070615134948.GB16133@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ralf Baechle wrote:

>>>Please note that this generic calibration code may be used for
>>>calibrating the CP0 timer too -- all that you need is defining

>>Actually the current patchset breaks it since it changes the calibration
>>code to be used only for the cp0 hpt calibration. I'll change that.

> To many this really fun it also needs to become possible to calibrate

    Huh? :-)

> each processor's clock individually - not all MIPS MP systems run their
> clocks at the same rate.

>   Ralf

WBR, Sergei
