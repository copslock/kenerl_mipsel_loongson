Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jul 2006 10:16:58 +0100 (BST)
Received: from wr-out-0506.google.com ([64.233.184.235]:8064 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S8133487AbWGaJQt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 31 Jul 2006 10:16:49 +0100
Received: by wr-out-0506.google.com with SMTP id i31so359291wra
        for <linux-mips@linux-mips.org>; Mon, 31 Jul 2006 02:16:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=W3VDaNnNEyqPGCUyYY3ku0ori+WV5QjZCd2mQgyYMa0alxnZ6JfXAKEN1UVB4FxmiMnRR+eznCZzyCVrjyttBMdgRzE1tkhvWvKk2QrkgK9d6bS1w/y0j4OC8aMzzoZ1DaG1FxWobXrFtsq7etZWbaXmD/OXUt1+rqwXAppHLyE=
Received: by 10.54.109.3 with SMTP id h3mr2210919wrc;
        Mon, 31 Jul 2006 02:16:47 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id 8sm3209276wrl.2006.07.31.02.16.45;
        Mon, 31 Jul 2006 02:16:47 -0700 (PDT)
Message-ID: <44CDCA46.3030707@innova-card.com>
Date:	Mon, 31 Jul 2006 11:15:50 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] dump_stack() based on prologue code analysis
References: <20060726.232231.59465336.anemo@mba.ocn.ne.jp>	<44C8CEA4.20000@innova-card.com>	<cda58cb80607271203u70b26e23o65b71d3d0c900f94@mail.gmail.com> <20060729.010137.36922349.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060729.010137.36922349.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Thu, 27 Jul 2006 21:03:07 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
>>>> +     info.func = (void *)(pc - ofs);
>>>> +     info.func_size = ofs;   /* analyze from start to ofs */
>> in get_frame_info(), there is the following condition to stop the
>> prologue analysis
>>
>> 		if (info->func_size && i >= info->func_size / 4)
>> 			break;
>>
>> Setting info.func_size = ofs may trigger this stop condition very
>> early, specially if "ofs" is small...I would simply remove this
>> condition since it's very empirical and IMHO not very usefull.
> 
> Yes, that is what I wanted.  Imagine if a exception happened on first
> place on non-leaf function.  In this case, we must assume the function
> is leaf since RA is not saved to the stack.
> 

The only case I can imagine is when sp is corrupted which is unlikely.
However an exception can occure just after a prologue of a nested
function which is more likely. In that case you will assume wrongly
that the function was a leaf one.

I don't think we gain more than we loose with this test. Maybe we can
just leave

 		if (i >= info->func_size)
 			break;

for safety purpose.

		Franck
