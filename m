Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Dec 2005 19:11:38 +0000 (GMT)
Received: from web410.biz.mail.mud.yahoo.com ([68.142.201.41]:48047 "HELO
	web410.biz.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133560AbVLGTLS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Dec 2005 19:11:18 +0000
Received: (qmail 20650 invoked by uid 60001); 7 Dec 2005 19:11:00 -0000
Message-ID: <20051207191100.20648.qmail@web410.biz.mail.mud.yahoo.com>
Received: from [64.163.129.139] by web410.biz.mail.mud.yahoo.com via HTTP; Wed, 07 Dec 2005 11:11:00 PST
Date:	Wed, 7 Dec 2005 11:11:00 -0800 (PST)
From:	Peter Popov <ppopov@embeddedalley.com>
Subject: Re: [PATCH] Philips PNX8550
To:	"Vladimir A. Barinov" <vbarinov@ru.mvista.com>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <43973277.6070301@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips



> I used a quite different board (STB810), but it's
> based on the same board dependent code as JBS (i.e
> arch/mips/philips/pnx8550/jbs). I haven't 
> worked with
> JBS board and I'm not sure if slot=10 is needed for
> that, but it's really necessary for STB810.

The JBS has only 3 pci slots and I tested all three.
So the fourth one you added won't do any damage but
it's not quite right either. 

> I also has another question - Could you please
> advice: shall I create a different
> arch/mips/philips/pnx8550/stb810
> and add MACH_PHILIPS_STB810 ID and defconfig
> or I can use exiting JBS one?

Is anything else different that would justify the new
directory? If not, perhaps we just need an STB board
selection in arch/mips/Kconfig, a defconfig, and an
ifdef around that pci slot you sent.

BTW, regarding your serial driver patch ... I have one
outstanding change (small) I still have to make, as
requested by rmk. Mind if I forward that email to you
so you can take care of it :)?

Pete

Pete
