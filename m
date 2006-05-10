Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 May 2006 04:41:37 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:28860 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S8126484AbWEJCl3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 May 2006 04:41:29 +0200
Received: from ala-mail04.corp.ad.wrs.com (ala-mail04 [147.11.57.145])
	by mail.wrs.com (8.13.6/8.13.3) with ESMTP id k4A2fKum009855;
	Tue, 9 May 2006 19:41:22 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ala-mail04.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 9 May 2006 19:41:20 -0700
Received: from [192.168.96.26] ([192.168.96.26]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 9 May 2006 19:41:19 -0700
Message-ID: <446152CC.6020904@windriver.com>
Date:	Wed, 10 May 2006 10:41:16 +0800
From:	"Mark.Zhan" <rongkai.zhan@windriver.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] Wind River 4KC PPMC Eval Board Support
References: <445C6694.6010901@windriver.com> <20060509164127.GA10647@linux-mips.org>
In-Reply-To: <20060509164127.GA10647@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 May 2006 02:41:19.0553 (UTC) FILETIME=[37A99310:01C673DB]
Return-Path: <rongkai.zhan@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rongkai.zhan@windriver.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Sat, May 06, 2006 at 05:04:20PM +0800, Mark.Zhan wrote:
> 
>> According to your comments, I re-create the patch. Hopefully, no line-wrapped problems:-)
>> Patch 1 and 2 in the original mails are concatenated into one patch in this mail.
> 
> Well, this patch was still somewhat corrupt, a few spaces were missing

Huhh, I don't what's wrong with my thunderbird.

> but I was somehow able to talk git into taking it.  So it's applied on
> the queue branch.
> 
>   Ralf

After looking into the changeset ac58afdfac792c0583af30dbd9eae53e24c78b, 
  I find what I want to do has been done by you:-)

For those MIPS32 boards which only use IRQ_CPU, I think, we can provide 
a default plat_irq_dispatch() implemention, maybe like this:

asmlinkage plat_irq_dispatch(struct pt_regs *regs)
{
	unsigned int pending = read_c0_status() & read_c0_cause();
	int irq;

	irq = ffs(pending >> 8) - 1;
	return do_IRQ(irq, regs);
}

I this it will clean up more codes......

Best Regards,
Mark.Zhan
