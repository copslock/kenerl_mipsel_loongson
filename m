Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Mar 2007 00:04:01 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:35279 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20022504AbXCXAD7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 Mar 2007 00:03:59 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 8CA3C29A8A5;
	Sat, 24 Mar 2007 00:03:22 +0000 (GMT)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Sat, 24 Mar 2007 00:03:22 +0000 (GMT)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 23 Mar 2007 17:03:21 -0700
Message-ID: <46046AC9.5070306@avtrex.com>
Date:	Fri, 23 Mar 2007 17:03:21 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Ravi Pratap <Ravi.Pratap@hillcrestlabs.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, miklos@szeredi.hu,
	linux-mips@linux-mips.org
Subject: Re: flush_anon_page for MIPS
References: <20070323190617.GA26884@linux-mips.org> <36E4692623C5974BA6661C0B18EE8EDF6CD3C5@MAILSERV.hcrest.com> <20070323233639.GA517@linux-mips.org>
In-Reply-To: <20070323233639.GA517@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Mar 2007 00:03:21.0899 (UTC) FILETIME=[D5E6D7B0:01C76DA7]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Fri, Mar 23, 2007 at 06:17:25PM -0400, Ravi Pratap wrote:
> 
>>> Yes, that's perfectly reproducable here (running a VSMP 
>>> kernel on a 34K).
>>> So the fix I posted earlier was good but I did a few tweaks 
>>> to it anyway.
>>> Will commit to all 2.6 -stable branch and master later.
>>
>> Thanks so much! Will this go into 2.6.15 by any chance?
> 
> I don't recall that there every has been such a kernel release ;-)
> 
> But seriously, 2.6.15 is as dead as Tutankhamun.

Some chip vendors only support that version, so I am assuming that that 
was the reason for the question.

It is a classic case of what happens when people do ports that are not 
merged.  They say it is good enough as is and then never move forward or 
fix bugs.

The good news I guess is that we have the source, so we could forward 
port it if we were really motivated.

David Daney
