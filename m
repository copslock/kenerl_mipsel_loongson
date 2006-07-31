Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jul 2006 15:34:03 +0100 (BST)
Received: from wr-out-0506.google.com ([64.233.184.239]:57782 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S8126923AbWGaOdx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 31 Jul 2006 15:33:53 +0100
Received: by wr-out-0506.google.com with SMTP id i31so505558wra
        for <linux-mips@linux-mips.org>; Mon, 31 Jul 2006 07:33:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=pdV3PF9u7xgH8hajhChmgndSGjjU29y9Dg5f9gg7gAHOKcDekvwmDmFCs2KmVRVpohTP1gb39wEojRl+ffGZvMNNZsrS1u9xwy5KsHhljNev39zN6cbJWaBmS57cLhBo5HQw8RriVsum6GhCoDilza0B7E3xCE/ew4gD2EJZL3k=
Received: by 10.54.62.16 with SMTP id k16mr2515652wra;
        Mon, 31 Jul 2006 07:33:50 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id 29sm147864wrl.2006.07.31.07.33.48;
        Mon, 31 Jul 2006 07:33:49 -0700 (PDT)
Message-ID: <44CE1494.4080801@innova-card.com>
Date:	Mon, 31 Jul 2006 16:32:52 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] dump_stack() based on prologue code analysis
References: <cda58cb80607271203u70b26e23o65b71d3d0c900f94@mail.gmail.com>	<20060729.010137.36922349.anemo@mba.ocn.ne.jp>	<44CDCA46.3030707@innova-card.com> <20060731.223923.115609520.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060731.223923.115609520.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Mon, 31 Jul 2006 11:15:50 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>>> Yes, that is what I wanted.  Imagine if a exception happened on first
>>> place on non-leaf function.  In this case, we must assume the function
>>> is leaf since RA is not saved to the stack.
>> The only case I can imagine is when sp is corrupted which is unlikely.
> 
> Modern gcc somtimes do amazing optimization ;-)
> 
>> However an exception can occure just after a prologue of a nested
>> function which is more likely. In that case you will assume wrongly
>> that the function was a leaf one.
> 
> Why?  get_frame_info() should detect frame_size and pc_offset for that
> case.
> 
> Is your objection against "info->func_size / 4" part?  the "4" comes
> from size of a instruction.
>

OK. I missed that, sorry.

> Well, using "4" instead of "sizeof(union mips_instruction)" or
> "sizeof(*ip)" was my old fault...

Well could we use "sizeof(union mips_instruction)" so nobody won't
make the same mistake ?

 		if (i >= info->func_size / sizeof(union mips_instruction))
 			break;

BTW I omit the first condition "info->func_size != 0" because
normally a func has a no null size. If it has we should stop
right now.

We should also test this condition _before_ testing that "*ip" is
a jal instruction, shouldn't we ?

		Franck
