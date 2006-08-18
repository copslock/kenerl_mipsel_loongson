Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2006 15:14:07 +0100 (BST)
Received: from nz-out-0102.google.com ([64.233.162.193]:41504 "EHLO
	nz-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S20037786AbWHROOF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 Aug 2006 15:14:05 +0100
Received: by nz-out-0102.google.com with SMTP id s1so521523nze
        for <linux-mips@linux-mips.org>; Fri, 18 Aug 2006 07:14:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=G0oGfrgHekeRsz73/rV1YPg814aqM2yNF/eHJuY7wlI2AMmroPGIgOihX396p+5VZCMfcsLMI4rYoDtFjvH7zxAqaZ2AOqHwZwKVhHWLSSkN04J/hpvzqO03mYpwbMs0UYWNj/swo8hDWP4umemXCcyfWKAeg97Yph1OZ3DKx00=
Received: by 10.64.149.15 with SMTP id w15mr658831qbd;
        Fri, 18 Aug 2006 07:14:03 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id e18sm362062qbe.2006.08.18.07.14.01;
        Fri, 18 Aug 2006 07:14:02 -0700 (PDT)
Message-ID: <44E5CB11.9090002@innova-card.com>
Date:	Fri, 18 Aug 2006 16:13:37 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Remove mfinfo[64] used by get_wchan()
References: <44E57F39.2020009@innova-card.com>	<20060818.181136.85412687.nemoto@toshiba-tops.co.jp>	<44E5AFD9.1050101@innova-card.com> <20060818.230403.25910276.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060818.230403.25910276.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Fri, 18 Aug 2006 14:17:29 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>>> Why get_frame_info() will be called with info->func_size != 0 ?  The
>>> offset of a _first_ instruction is 0, so "ofs" of this line in
>>> unwind_stack() will be 0.
>>>
>>> 	info.func_size = ofs;	/* analyze from start to ofs */
>>>
>> because in unwind_stack(), before the line you showed, we do:
>>
>> 	if (!kallsyms_lookup(pc, &size, &ofs, &modname, namebuf))
>> 		return 0;
>> 	if (ofs == 0)
>> 		return 0;
> 
> Oh I missed it.
> 
>> Maybe we should do instead:
>>
>> 	if (!kallsyms_lookup(pc, &size, &ofs, &modname, namebuf))
>> 		return 0;
>> 	/* return ra if an exception occured at the first instruction */
>> 	if (ofs == 0)
>> 		return ra;
> 
> Sure.  I should be a right fix.  This part must be fixed anyway.
> 
>> And in any cases, if we pass info->func_size = 0 to get_frame_info(),
>> then it will consider the function size as unknown.
> 
> I see.  You're right.
> 

ok, I'm going to send a new patchset. Thanks for your feedbacks.

		Franck
