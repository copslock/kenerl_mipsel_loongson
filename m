Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Aug 2006 09:38:55 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.170]:46450 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S8133458AbWHAIiq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 1 Aug 2006 09:38:46 +0100
Received: by ug-out-1314.google.com with SMTP id m2so1361902ugc
        for <linux-mips@linux-mips.org>; Tue, 01 Aug 2006 01:38:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=SPD8GsOvpgwP9Yqh9BUahGkELItC+lGVGI2Plu9qQqJ82qIejXcjbOLhKacQlnEhc7hVRq4clSBGOJZYwFv62xiVMlBG/w7b48/qRHQaa5gPlixZ5gDScX/zIyWBCaV307NsuAePgElm95oskVbkxFEQvT3BKw5+tcZAUWasWRo=
Received: by 10.65.97.18 with SMTP id z18mr654644qbl;
        Tue, 01 Aug 2006 01:38:45 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id f13sm1280312qba.2006.08.01.01.38.10;
        Tue, 01 Aug 2006 01:38:12 -0700 (PDT)
Message-ID: <44CF12BD.6010902@innova-card.com>
Date:	Tue, 01 Aug 2006 10:37:17 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] dump_stack() based on prologue code analysis (take 2)
References: <20060729.232720.108740310.anemo@mba.ocn.ne.jp>	<44CDC657.9090403@innova-card.com> <20060731.235626.86888625.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060731.235626.86888625.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Mon, 31 Jul 2006 10:59:03 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>>
>> I pass regs to unwind_stack(), that simplify the caller because
>> it needn't to deal with leaf or nested case. Simply test for pc
>> is 0.
> 
> It seems a bit fragile.  The regs->regs[31] can be used for top of
> stack, but we should consider that get_frame_info() might return wrong
> result (again, get_frame_info() is not perfect).  If get_frame_info()
> returned 0 on middle level of the stack, taking regs->regs[31] leads
> wrong trace.  Maybe you can use NULL value as regs for non-toplevel.
> 

Yes get_frame_info() is not perfect in sense where it can't analyses
_all_ possible frames. But it should be able to detect these case at 
least.

		Franck
