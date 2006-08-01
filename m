Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Aug 2006 16:38:39 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.190]:39641 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133655AbWHAPiV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 1 Aug 2006 16:38:21 +0100
Received: by nf-out-0910.google.com with SMTP id q29so312961nfc
        for <linux-mips@linux-mips.org>; Tue, 01 Aug 2006 08:38:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=sqfI4jGfmo6rqLPjAE9yv0pBuQqJWNwCsT1sZfnZ1H13gujjUnEvKcmXtkXLbJpaHl5CCKqfouDMO0s7aedUQ5d3EztheKC6Cm3gqgvBvsDrytWElNTkQiWNWg3SAQFADTC1XVEmEs727A6FAgIiaCjvJP0C1LCJunmEt8/fQXk=
Received: by 10.49.8.4 with SMTP id l4mr921209nfi;
        Tue, 01 Aug 2006 08:38:14 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id r33sm471316nfc.2006.08.01.08.38.13;
        Tue, 01 Aug 2006 08:38:14 -0700 (PDT)
Message-ID: <44CF7506.70106@innova-card.com>
Date:	Tue, 01 Aug 2006 17:36:38 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 6/7] Fix dump_stack()
References: <11544244373398-git-send-email-vagabon.xyz@gmail.com>	<1154424439852-git-send-email-vagabon.xyz@gmail.com> <20060802.000837.37531064.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060802.000837.37531064.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Tue,  1 Aug 2006 11:27:16 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>> When CONFIG_KALLSYMS is not set stack local is not initialized. Therefore
>> show_trace() won't display anything useful. This patch uses
>> prepare_frametrace() to setup the stack pointer before calling
>> show_trace().
> 
> It's not a bug.  The original show_trace() needs an address on stack
> and dump_stack() surely give it by taking an address of local
> variable.
> 

sorry, was drunk when writing the commit message...

> Eliminating the #ifdef itself looks good, but if you cleared contents
> of the "regs" before prepare_frametrace, you will get less false
> entries in the output.
> 

well I don't see why...show_trace() is going to only use regs[29] which
is setup by prepare_frametrace()...

One other thing, why did you mark prepare_frametrace() as noinline ?
I would mark it as always_inline to get one less false entry in the
output.

		Franck
