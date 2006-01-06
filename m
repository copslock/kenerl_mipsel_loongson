Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2006 08:54:03 +0000 (GMT)
Received: from smtp-out.hotpop.com ([38.113.3.61]:61839 "EHLO
	smtp-out.hotpop.com") by ftp.linux-mips.org with ESMTP
	id S8133528AbWAFIxe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Jan 2006 08:53:34 +0000
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.105])
	by smtp-out.hotpop.com (Postfix) with SMTP id 91A062222269
	for <linux-mips@linux-mips.org>; Fri,  6 Jan 2006 08:56:02 +0000 (UTC)
Received: from [10.8.64.42] (unknown [62.253.252.7])
	by smtp-2.hotpop.com (Postfix) with ESMTP
	id 48AF622221A0; Fri,  6 Jan 2006 08:56:00 +0000 (UTC)
Subject: Re: sometimes get "crc error" while uncompressed ramdisk
From:	jp <jaypee@hotpop.com>
To:	zhuzhenhua <zzh.hust@gmail.com>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <50c9a2250601052240n5696e353teb2b798ecbf802f0@mail.gmail.com>
References: <50c9a2250601052240n5696e353teb2b798ecbf802f0@mail.gmail.com>
Content-Type: text/plain
Date:	Fri, 06 Jan 2006 08:56:53 +0000
Message-Id: <1136537813.5239.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Return-Path: <jaypee@hotpop.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaypee@hotpop.com
Precedence: bulk
X-list: linux-mips

On Fri, 2006-01-06 at 14:40 +0800, zhuzhenhua wrote:
> i make a ramdisk by myself, and sometimes the kernel boot the ramdisk
> correctly but sometimes it printk "crc error" while uncompressed
> ramdisk, did someone meet this situation?
> thanks for any hints
> 

Assuming your build and everything else is as it should be it may be a
RAM fault. Are you using a custom board?

I had some prototype boards here with some really long tracks to RAM.
(and some really short ones too!)

Memory tests such walking ones worked fine but the decompress of the
ramdisk works RAM pretty hard and it showed up intermittent faults like
you describe. Tended to be worse when the board was warm. I'd spray some
Freezit on and it would go back to working OK.

You could also try running the RAM slower and see if the fault
disappears.


JP
