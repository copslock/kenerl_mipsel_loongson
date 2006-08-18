Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2006 13:17:59 +0100 (BST)
Received: from nz-out-0102.google.com ([64.233.162.200]:36984 "EHLO
	nz-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S20037771AbWHRMRz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 Aug 2006 13:17:55 +0100
Received: by nz-out-0102.google.com with SMTP id s1so495499nze
        for <linux-mips@linux-mips.org>; Fri, 18 Aug 2006 05:17:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=jTDSFxNY/3aCam8F0JKxzjgzh4cxwznoSMvK6URqKuArkf9Tll34opK0jkPngE2hgVJmQ1GGhD5t6/XCOaqhLXfRWnq6dbic7Etg2nDpkmdSoQejG+Gy32rNswlLiiUCxeD/tlrvLqA5Ciwk95OV8NOhLK6Yjm9MPHERHtm7GcA=
Received: by 10.65.219.4 with SMTP id w4mr3562924qbq;
        Fri, 18 Aug 2006 05:17:54 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id 6sm122176wrh.2006.08.18.05.17.52;
        Fri, 18 Aug 2006 05:17:54 -0700 (PDT)
Message-ID: <44E5AFD9.1050101@innova-card.com>
Date:	Fri, 18 Aug 2006 14:17:29 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Remove mfinfo[64] used by get_wchan()
References: <44E57161.5060104@innova-card.com>	<20060818.171558.89065994.nemoto@toshiba-tops.co.jp>	<44E57F39.2020009@innova-card.com> <20060818.181136.85412687.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20060818.181136.85412687.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Fri, 18 Aug 2006 10:50:01 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>> Does something like this seem correct ? If an exception occured on a first
>> instruction of a function, show_backtrace() will call get_frame_info()
>> with info->func_size != 0 but very small. In this case it returns 1.
> 
> Why get_frame_info() will be called with info->func_size != 0 ?  The
> offset of a _first_ instruction is 0, so "ofs" of this line in
> unwind_stack() will be 0.
> 
> 	info.func_size = ofs;	/* analyze from start to ofs */
> 

because in unwind_stack(), before the line you showed, we do:

	if (!kallsyms_lookup(pc, &size, &ofs, &modname, namebuf))
		return 0;
	if (ofs == 0)
		return 0;

Maybe we should do instead:

	if (!kallsyms_lookup(pc, &size, &ofs, &modname, namebuf))
		return 0;
	/* return ra if an exception occured at the first instruction */
	if (ofs == 0)
		return ra;

And in any cases, if we pass info->func_size = 0 to get_frame_info(),
then it will consider the function size as unknown.

		Franck
