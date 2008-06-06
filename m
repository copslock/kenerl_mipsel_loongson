Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jun 2008 07:57:52 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:9649 "HELO smtp.movial.fi")
	by ftp.linux-mips.org with SMTP id S20037413AbYFFG5t (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Jun 2008 07:57:49 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 1F588C803F;
	Fri,  6 Jun 2008 09:57:43 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id PL4QcO-BG5Tq; Fri,  6 Jun 2008 09:57:43 +0300 (EEST)
Received: from [172.17.49.48] (sd048.hel.movial.fi [172.17.49.48])
	by smtp.movial.fi (Postfix) with ESMTP id F3D2FC801D;
	Fri,  6 Jun 2008 09:57:42 +0300 (EEST)
Message-ID: <4848DFEC.1010800@movial.fi>
Date:	Fri, 06 Jun 2008 09:57:48 +0300
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Organization: Movial Creative Technologies
User-Agent: Icedove 1.5.0.14eol (X11/20080509)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	Theodore Tso <tytso@MIT.EDU>, Martin Michlmayr <tbm@cyrius.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>,
	linux-mips@linux-mips.org, linux-ext4@vger.kernel.org
Subject: Re: ext4dev build failure on mips: "empty_zero_page" undefined
References: <20080512130604.GA15008@deprecation.cyrius.com> <90edad820805120654n50f7a00cm3c7b4a4f9346d5ea@mail.gmail.com> <20080512143426.GB7029@mit.edu> <90edad820805120746l61e67362vbd177d63e8b05dc8@mail.gmail.com> <20080513045028.GC22226@linux-mips.org> <20080528070637.GA10393@deprecation.cyrius.com> <20080605111148.GA4483@deprecation.cyrius.com> <1212664977.4840.6.camel@sd048.hel.movial.fi> <20080605183854.GN25477@mit.edu> <38408.84.249.59.97.1212701650.squirrel@webmail.movial.fi> <20080605215152.GB15504@networkno.de>
In-Reply-To: <20080605215152.GB15504@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <dmitri.vorobiev@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Vorobiev Dmitri wrote:
>> Theodore Tso wrote:
>>> If you really insist I suppose we could have a MIPS specific patch
>>> where we allocate a 4k page and zero it, so we can use it from our
>>> kernel code because you don't want to export and make available the
>>> ZERO_PAGE that gets used by the rest of the kernel, but that seems
>>> awfully silly, and would be a waste of 4k of memory.....  Someone from
>>> MIPS land would have to test it, as well, as I dont think any of the
>>> ext4 developers have access to a MIPS platform.
>> Ted, Ralf seems to be unwilling to accept the ZERO_PAGE() export. If you
>> send the MIPS-specific patch, I can do the testing for you as I have a
>> MIPS Malta board at my disposal.
> 
> AFAIU the problematic case are systems with R4000/R4400 SC/MC CPUs
> since they use 8 zero pages of different color. Have a look at
> arch/mips/mm/init.c:setup_zero_pages.

OK, thanks for the info. However, I won't be able to tackle into the
issue during this and the next week as I'm having a business trip.
Therefore, if the issue is urgent, I'd be grateful if someone could take
over.

Thanks,
Dmitri
