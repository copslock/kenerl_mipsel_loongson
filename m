Received:  by oss.sgi.com id <S553983AbRAYSCs>;
	Thu, 25 Jan 2001 10:02:48 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:28412 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553978AbRAYSCa>;
	Thu, 25 Jan 2001 10:02:30 -0800
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f0PHwfI15589;
	Thu, 25 Jan 2001 09:58:41 -0800
Message-ID: <3A706A22.6B760617@mvista.com>
Date:   Thu, 25 Jan 2001 10:02:10 -0800
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: bg, en
MIME-Version: 1.0
To:     Steve Johnson <stevej@ridgerun.com>
CC:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: floating point on Nevada cpu
References: <3A6F8F66.6258801@mvista.com> <0101241833281Q.00834@plugh.sibyte.com> <3A6F9814.3E39027@mvista.com> <0101241917341S.00834@plugh.sibyte.com> <3A703E3C.360FB4FF@ridgerun.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Steve,

Steve Johnson wrote:
> 
> Pete,
> 
>     We had a problem in user-space apps all showing 0 for floating-point
> results because we hadn't set the ST0_FR bit to 0, and we had a mis-match
> between user libraries (MIPS3k-compatible) and the floating point registers.
> We noticed the problem when we couldn't run "ps" or "rm" correctly and tracked
> it down from some old postings by Ralf and friends.  Maybe this is your
> problem, too?
> 
>     I added this to our setup call:
> 
>     set_cp0_status(ST0_FR, 0);

Problem solved before I finished my first cup of coffee. Thanks!

I bet this problem will show up here and there depending on how the boot
code sets cp0.  Seems like adding the above line in a mips generic init
routine would be a good thing.

Pete
