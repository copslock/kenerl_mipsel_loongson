Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2007 10:38:37 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.181]:27033 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20023195AbXFRJif (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 18 Jun 2007 10:38:35 +0100
Received: by py-out-1112.google.com with SMTP id f31so3134476pyh
        for <linux-mips@linux-mips.org>; Mon, 18 Jun 2007 02:38:29 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VLEagSDgoRe3g/TC2aWu8QnHl0AfS50ErBqkwAFfCNxnsmb+ec8WWb+ZHqOW6/YMpeBwHisNv+hkTUTtjIpVJrLvI95zjM3tXkKrZVYyFF9Ws0LqCG/fKXhKN/r93TUYqq6rRekj2b42QhzNrlJSRx3gu/HYw4QITkobBYEo+1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Rwwb+Sh27dMm0ZuIFAzie9zzcRfuftSAcxEphob+eoJs3qbXbTL4/IZykJbHjhf0iCUButvO6AcEVul3/JHALSmAGaqeWuJpDyHNGXcR9XdjPnsnzL81ycSbyu5FT+ADnrQF490rO04L6yYOhstGxgCURPkEym1ePPPdieaeSnc=
Received: by 10.65.197.13 with SMTP id z13mr1247708qbp.1182159509058;
        Mon, 18 Jun 2007 02:38:29 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Mon, 18 Jun 2007 02:38:28 -0700 (PDT)
Message-ID: <cda58cb80706180238r17da4434jcdee307b0385729b@mail.gmail.com>
Date:	Mon, 18 Jun 2007 11:38:28 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time code.
Cc:	ralf@linux-mips.org, macro@linux-mips.org, sshtylyov@ru.mvista.com,
	linux-mips@linux-mips.org
In-Reply-To: <20070618.011425.93018724.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80706150159j5c3d5b7p4293dc529d5ee97c@mail.gmail.com>
	 <20070615134948.GB16133@linux-mips.org>
	 <cda58cb80706170636kbff000cw849fa1d5ccf31152@mail.gmail.com>
	 <20070618.011425.93018724.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Atsushi,

On 6/17/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Sun, 17 Jun 2007 15:36:53 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> > b) Are there some weird MIPS CPUs out there which don't read/ack cp0
> > hpt in the normal way ?
>
> PNX8550?  Their count/compare interrupt altomatically clears the count
> register.  Please refer this thread:
>
> http://www.linux-mips.org/archives/linux-mips/2006-12/msg00194.html
>

Oh no, another weirdo :(

What is suprising me is that there's no comment explaining what is
going on in pnx8550/common/time.c...

> I'm not sure this fits new clockevent codes or not.

Not really. What could be done in this case is to use cp0 hpt for
dealing with clock events _only_. I don't think it's an issue if the
count register is automatically cleared in this case.

And it should write it's own clocksource support which would use
different timer.

It shoud result in something like this:

unsigned __init get_freq(int cpu)
{
	return 27UL * ((1000000UL * n)/(m * pow2p));
}

void __init plat_timer_init()
{
	struct cp0_hpt_info info;

	info.get_freq = get_freq;
	info.irq = PNX8550_INT_TIMER1;
	setup_cp0_hpt(&info, CLKEVT_ONLY);

	setup_my_clocksource_using_a_different_timer();
}

Note that 'CLKEVT_ONLY' flag currently doesn't exist.

What do you think ?
-- 
               Franck
