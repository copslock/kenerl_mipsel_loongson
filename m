Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 19:17:22 +0100 (CET)
Received: from mail-fx0-f211.google.com ([209.85.220.211]:62628 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493034AbZKFSRP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Nov 2009 19:17:15 +0100
Received: by fxm3 with SMTP id 3so318243fxm.24
        for <multiple recipients>; Fri, 06 Nov 2009 10:17:07 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UrGGPXvfj1VoUReiRUmI0d9UwPg4CtpLhS1nIEf3W1Q=;
        b=T/bGzqVgPxAOIPjIGdzg+fbi/6uBFmUjHR+zJKMzVF6xbAZwknwfqEyoIA2d+5uMpY
         XPyRXUbcSbvWxP9maLRZZ6VU2gcJhiz+ZZgUBwWETRDpzSH68S60qHwi9+go6BLrd4R0
         NelTz1WjjFqwWHQzyIBB/h3p/71dfemCKmBYU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k1Ca4EoiZ067mK/swQfdKjjBTxpxRDcJdOhg31MltEgqGFNNEKzYL1KVY4Divl1kEC
         7x9TnOdfLh4wigJz3C8QznU5bk9HAPJoH2PO263ZBAkFp4blL39gCDT+bxRf/cZ1MZuF
         EA1ls+5BKpu7qprc9hQR+xUum4YzbOSMdDQcw=
MIME-Version: 1.0
Received: by 10.223.21.3 with SMTP id h3mr677594fab.39.1257531427029; Fri, 06 
	Nov 2009 10:17:07 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0911061726150.9725@eddie.linux-mips.org>
References: <20091107.010839.246840249.anemo@mba.ocn.ne.jp>
	 <90edad820911060822g40233a8ft28001d68186b989e@mail.gmail.com>
	 <90edad820911060834t5c14aa30t847c3b75bf7e36e@mail.gmail.com>
	 <4AF4526B.3020502@caviumnetworks.com>
	 <90edad820911060907j4a605167xfe1ebdf0dcf7b635@mail.gmail.com>
	 <alpine.LFD.2.00.0911061710160.9725@eddie.linux-mips.org>
	 <90edad820911060923w6cd59c5dh57d123b6bc9d4219@mail.gmail.com>
	 <alpine.LFD.2.00.0911061726150.9725@eddie.linux-mips.org>
Date:	Fri, 6 Nov 2009 20:17:06 +0200
Message-ID: <90edad820911061017y373cf1ale5f10b742d633b7d@mail.gmail.com>
Subject: Re: COMMAND_LINE_SIZE and CONFIG_FRAME_WARN
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, Nov 6, 2009 at 7:30 PM, Maciej W. Rozycki <macro@linux-mips.org> wrote:
> On Fri, 6 Nov 2009, Dmitri Vorobiev wrote:
>
>> >  KSEG space is not paged, so who cares about the page size?  You're not
>> > making additional stack page allocations, although you can overflow the
>> > space available at some point (but that's avoided if you know a priori
>> > your backtrace is not going to be deep).  Static allocation has its
>> > drawbacks, for example it takes storage space (if it's initialised data)
>> > or memory space (if it's BSS) indefinitely.
>>
>> Thanks for the explanation. Then a variable-size array, I guess.
>
>  Note that MIPS is at an advantage here and other architectures may have
> to page the kernel space, so the observation is valid for our platform
> code only -- for generic code (anything that goes outside arch/mips) you
> may have to change the assumptions.

I believe that Atsushi-san was talking about the MIPS code only.
Indeed, he mentioned CL_SIZE, which used to be a MIPS-specific alias
to COMMAND_LINE_SIZE.

Dmitri

>
>  Maciej
>
