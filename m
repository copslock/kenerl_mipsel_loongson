Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Aug 2009 21:14:10 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:35917 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493354AbZHCTOC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Aug 2009 21:14:02 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n73JEFrQ023240;
	Mon, 3 Aug 2009 20:14:16 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n73JEEEu023238;
	Mon, 3 Aug 2009 20:14:14 +0100
Date:	Mon, 3 Aug 2009 20:14:14 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	David VomLehn <dvomlehn@cisco.com>,
	GCC Help Mailing List <gcc-help@gcc.gnu.org>,
	Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Relocation problem with MIPS kernel modules
Message-ID: <20090803191413.GA22543@linux-mips.org>
References: <20090730184923.GA27030@cuplxvomd02.corp.sa.net> <20090803092030.GB30431@linux-mips.org> <20090803181958.GA7009@cuplxvomd02.corp.sa.net> <4A773026.3030002@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A773026.3030002@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 03, 2009 at 11:44:54AM -0700, David Daney wrote:

>>> R_MIPS_HI16 relocations to be followed by a R_MIPS_LO16 symbol.  All
>>> relocations of this sequence must use the same symbol, of course.  This is
>>> a very old extension; I think it predates the Linux/MIPS port.
>>
>> Perhaps a foolish question, but is this documented anywhere?
>
> What more documentation do you need?  It's obvious if you read  
> bfd/elf{32,64,xx}-mips.c :-).

David ist (unforutunately ...) right.  I don't think this is documented
anywhere.  I also only learned it from reading the binutils sources.

  Ralf
