Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jun 2007 09:29:47 +0100 (BST)
Received: from wr-out-0506.google.com ([64.233.184.233]:57276 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021576AbXFHI3p (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 8 Jun 2007 09:29:45 +0100
Received: by wr-out-0506.google.com with SMTP id 69so613382wri
        for <linux-mips@linux-mips.org>; Fri, 08 Jun 2007 01:29:42 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TgJUem85BINlU5uy5xmPww98hOQutQo1j7m9EbMrXcSQmKYYf+21xlcLX9hjvFrGHMWacHDcmSJyKhORyDEEXjikgiH7W4rwkfb3JMQA1EwtLVAFzNT8lACQvC9yslZRuvgvF8a93h4IsO6taVZ88zIhUgA4S5KC9lIXYHdMvIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ahKRB+Ny55TSoXUqzAs4WEUn8rHQdK0AX671gZ1PMbYN6ZsDDIBMN7q1frFxXOa5GTm41DhmHNT52JYLMKLgnvSzV5hr3JxtoMMLQFmxo29NvZG1iCT+OqSmxZRjt9hXjEYrAecKKSSi8zUZoHijZpTg13QiiA+a8jVK375z0vA=
Received: by 10.65.103.14 with SMTP id f14mr4696680qbm.1181291382134;
        Fri, 08 Jun 2007 01:29:42 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Fri, 8 Jun 2007 01:29:42 -0700 (PDT)
Message-ID: <cda58cb80706080129h77450e6cx52824a4dbb654717@mail.gmail.com>
Date:	Fri, 8 Jun 2007 10:29:42 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: Tickless/dyntick kernel, highres timer and general time crapectomy
Cc:	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
In-Reply-To: <20070607154801.GG26047@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070606185450.GA10511@linux-mips.org>
	 <cda58cb80706070059k3765cbf6w7e8907a2f0d83e1d@mail.gmail.com>
	 <20070607113032.GA26047@linux-mips.org>
	 <cda58cb80706070611t3083f026p769e3e1beee1f11e@mail.gmail.com>
	 <46680B75.5040809@ru.mvista.com>
	 <cda58cb80706070744v21e1bbf3sa28990b4477a8844@mail.gmail.com>
	 <20070607154801.GG26047@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

Ralf Baechle wrote:
> On Thu, Jun 07, 2007 at 04:44:11PM +0200, Franck Bui-Huu wrote:
>
>>>   No, it doesn't. Even on dyntick kernels, interrupts do happen several
>>> times a second. Dynticks have nothing to do with disabling timer
>>> interrupts...
>>>
>> That's true however if your system has 2 clock devices. One is the r4k-hpt
>> and the other one soemthing else with a higher rating. If you don't stop
>> r4k-hpt interrupts, how does it work ?
>
> To some degree this question is hypothetic because generally the cp0
> count/compare timer will be the highest rated counter.
>

Well it increments every other clock. So it's not impossible to have a
an other higher rated counter.

> But even if so, the basic solution is the same - just ignore the interrupt
> whenever it happens to be triggered.  Or if it isn't shared with an
> active performance counter interrupt, you could even disable_irq() it.
>

OK, but the current code doesn't seem to support very well multiple
clock event devices. For example the global_cd array is not updated if
a new clock event device is registered. Even ll_timer_interrupt()
handler should be renamed something like ll_hpt_interrupt() for
example.

Thanks,


-- 
               Franck
