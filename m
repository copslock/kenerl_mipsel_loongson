Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f860bJd03578
	for linux-mips-outgoing; Wed, 5 Sep 2001 17:37:19 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f860bFd03575;
	Wed, 5 Sep 2001 17:37:15 -0700
Received: from pacbell.net (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f860fBA09834;
	Wed, 5 Sep 2001 17:41:11 -0700
Message-ID: <3B96C5A7.2020604@pacbell.net>
Date: Wed, 05 Sep 2001 17:39:03 -0700
From: Pete Popov <ppopov@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Phil Thompson <Phil.Thompson@pace.co.uk>,
   "'Atsushi Nemoto'" <nemoto@toshiba-tops.co.jp>, linux-mips@oss.sgi.com
Subject: Re: Signal 11 on Process Termination - Update
References: <54045BFDAD47D5118A850002A5095CC30AC577@exchange1.cam.pace.co.uk> <20010906022449.A18605@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> On Wed, Sep 05, 2001 at 11:07:58AM +0100, Phil Thompson wrote:
> 
> 
>>This fixed the problem - many thanks.
>>
>>Ralf - is this patch going to be applied (the current CVS seems unusable
>>without it)?
>>
> 
> I've applied a different patch to CVS.
> 
> I've got other different problems with the current CVS; the 32-bit kernel
> is very unreliable for me on 32-bit machines.

That's my experience as well, just FYI.

Pete
