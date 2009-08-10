Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Aug 2009 17:25:38 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52613 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492874AbZHJPZa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Aug 2009 17:25:30 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n7AFQAEd003260;
	Mon, 10 Aug 2009 16:26:11 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n7AFQA4C003258;
	Mon, 10 Aug 2009 16:26:10 +0100
Date:	Mon, 10 Aug 2009 16:26:10 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Ithamar R. Adema" <ithamar.adema@team-embedded.nl>
Cc:	Alexander Clouter <alex@digriz.org.uk>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: add support for gzip/bzip2/lzma compressed
	kernel images
Message-ID: <20090810152610.GA608@linux-mips.org>
References: <1249757707-8876-1-git-send-email-wuzhangjin@gmail.com> <e4s3l6-dou.ln1@chipmunk.wormnet.eu> <20090810135521.GA27737@linux-mips.org> <4A803455.5010304@team-embedded.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A803455.5010304@team-embedded.nl>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 10, 2009 at 04:53:09PM +0200, Ithamar R. Adema wrote:

> Ralf Baechle wrote:
>> Printing is hardware specific; the debug code will need to be changed for
>> practically every MIPS platform on the planet, so I'm not too fond of the
>> idea unless somebody comes up with a cleaner infrastructure to do so.
>> Unfortunately we're not setup very well to do configuration detection etc.
>> in that debug code without adding tons of baggage.
>>   
> Would mimicing the uncompress.h header as used in the ARM architecture  
> be an idea? Maybe have one that does nothing in mach-generic and let the  
> machines that want debug output define their own that actually does IO.
>
> Just a header, defining putc()-ish functions, most architectures already  
> have code for that, so it should be trivial for them to implement it, if  
> wanted...
>
> Just an idea...

Oh, I wasn't trying to kill the debug code entirely but pointing out some
difficulties.  For some platforms the code would be a little larger and
more complex.  It could be as bad as dynamically detecting a console and
running PPP to talk to it.  Or having to carry fonts along and render
output into a complex graphics card.  but we can still deciede if the
feature is useful enough on a per platform base.

An implementation would probably look something like you pointed out
though I haven't seen the ARM header you mentioned.  Ideally code could
be shared with early printk.

  Ralf
