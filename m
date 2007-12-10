Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Dec 2007 15:14:30 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:30643 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024606AbXLJPO2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Dec 2007 15:14:28 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lBAFE5dt019185;
	Mon, 10 Dec 2007 15:14:05 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lBAFE4XD019184;
	Mon, 10 Dec 2007 15:14:04 GMT
Date:	Mon, 10 Dec 2007 15:14:04 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	zhuzhenhua <zzh.hust@gmail.com>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: is there a standard high res timer patch for mips?
Message-ID: <20071210151404.GA8595@linux-mips.org>
References: <50c9a2250712091718l75455353v1b86851a011eb4fe@mail.gmail.com> <475D2B86.603@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <475D2B86.603@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 10, 2007 at 03:05:26PM +0300, Sergei Shtylyov wrote:

>>            i want to add the high res timer support for my kernel(version
>> 2.6.14),and i found there are some patches:
>>  high-res-timers at sourceforge.net/projects/high-res-timers/high-res-timers
>> Jun Sun's patch at
>> http://linux.junsun.net/patches/oss.sgi.com/experimental/<http://linux.junsun.net/patches/oss.sgi.com/experimental/040419.a-cpu-timer.patch>
>> Thomas Gleixner's patch at http://www.tglx.de/projects/hrtimers/
>>      is there a standard high res timer patch for mips now?
>>      thanks for any hints
>
>    Yes, Tohmas' patch is now included into the kernel.

And the upcoming 2.6.24 kernel will be the first to support it.

  Ralf
