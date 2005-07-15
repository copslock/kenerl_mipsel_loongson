Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jul 2005 01:12:38 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.204]:7695 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226701AbVGOAMT> convert rfc822-to-8bit;
	Fri, 15 Jul 2005 01:12:19 +0100
Received: by wproxy.gmail.com with SMTP id i28so535761wra
        for <linux-mips@linux-mips.org>; Thu, 14 Jul 2005 17:13:30 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X0dT8E0K9DjW6Sj349p+wvfAfvc/iGxZN2CtO1kksKh7okaZK3Duci5gVv7xcwV0B1x8ipKXVkMIyt/kfpA7Y3GO2HnUoGwSxGNnVt7ydLTvBKy+IBBguTHgvIQjeWyVYUmRyAtYYWpWvGN7uL+JvsiZxGpSSIqB4F+C8uOlg2A=
Received: by 10.54.98.8 with SMTP id v8mr847978wrb;
        Thu, 14 Jul 2005 17:13:29 -0700 (PDT)
Received: by 10.54.41.29 with HTTP; Thu, 14 Jul 2005 17:13:29 -0700 (PDT)
Message-ID: <ecb4efd1050714171318ce81aa@mail.gmail.com>
Date:	Thu, 14 Jul 2005 20:13:29 -0400
From:	Clem Taylor <clem.taylor@gmail.com>
Reply-To: Clem Taylor <clem.taylor@gmail.com>
To:	"jaypee@hotpop.com" <jaypee@hotpop.com>
Subject: Re: Au1550 ethernet throughput low
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <1121354144l.5178l.2l@cavan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <1121270402l.7656l.3l@cavan>
	 <1121353347.10582.3.camel@orionlinux.starfleet.com>
	 <1121354144l.5178l.2l@cavan>
Return-Path: <clem.taylor@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clem.taylor@gmail.com
Precedence: bulk
X-list: linux-mips

On 7/14/05, jaypee@hotpop.com <jaypee@hotpop.com> wrote:
> Clem you said were using 2.6.11 was that a kernel.org kernel or one
> from linux-mips.org?

The source I'm using originated from http://www.linux-mips.org/. It
was checked out from the head of
':pserver:cvs@ftp.linux-mips.org:/home/cvs' on 2005.03.18. At the time
of checkout, the linux-mips tree was missing a 2.6.11 tag. The closest
tag was linux_2_6_11_rc5, but the code is 2.6.11.

I'm thinking about switching to 2.6.12 next week so I can get PCI
shutdown support.

> Clem sent me the output of a test. In which he is getting 11MBs
> I'm assuming the B is bytes in which case that is as near line rate as dammit.

Yeah, UDP is running at near line rate, but it does consume a bunch of
CPU. I'm running our 1550s at 492MHz, but I have to run the memory at
123MHz (DDR). I just ran the test again, here's what ttcp said:

udp recv on au1550
ttcp -u -r -s -n 16384 -l 32768 -A 32768 -v -b 262144 -f M
ttcp-r: buflen=32768, nbuf=16384, align=32768/0, port=5001,
sockbufsize=262144  udp
ttcp-r: 536608768 bytes in 44.72 real seconds = 11.44 MB/sec +++
ttcp-r: 536608768 bytes in 17.41 CPU seconds = 29.39 MB/cpu sec
ttcp-r: 16378 I/O calls, msec/call = 2.80, calls/sec = 366.21
ttcp-r: 0.1user 17.2sys 0:44real 38% 0i+0d 0maxrss 0+7pf 16344+13csw

udp xmit on au1550
ttcp -u -t -n 16384 -s -l 32768 -A 32768 -v -b 262144 -f M  gort
ttcp-t: buflen=32768, nbuf=16384, align=32768/0, port=5001,
sockbufsize=262144  udp
ttcp-t: 536870912 bytes in 44.76 real seconds = 11.44 MB/sec +++
ttcp-t: 536870912 bytes in 15.26 CPU seconds = 33.56 MB/cpu sec
ttcp-t: 16390 I/O calls, msec/call = 2.80, calls/sec = 366.14
ttcp-t: 0.1user 15.1sys 0:44real 34% 0i+0d 0maxrss 0+8pf 3272+10csw
