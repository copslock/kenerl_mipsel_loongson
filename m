Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2003 21:09:35 +0100 (BST)
Received: from voldemort.codesourcery.com ([IPv6:::ffff:65.73.237.138]:60135
	"EHLO mail.codesourcery.com") by linux-mips.org with ESMTP
	id <S8225376AbTIWUJ1>; Tue, 23 Sep 2003 21:09:27 +0100
Received: (qmail 22380 invoked from network); 23 Sep 2003 20:02:31 -0000
Received: from dhcp119.icir.org (HELO taltos.codesourcery.com) (zack@192.150.187.119)
  by mail.codesourcery.com with DES-CBC3-SHA encrypted SMTP; 23 Sep 2003 20:02:31 -0000
Received: by taltos.codesourcery.com (sSMTP sendmail emulation); Tue, 23 Sep 2003 13:06:03 -0700
From: "Zack Weinberg" <zack@codesourcery.com>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Eric Christopher <echristo@redhat.com>,
	Alexandre Oliva <aoliva@redhat.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: recent binutils and mips64-linux
References: <Pine.GSO.3.96.1030919144141.9134C-100000@delta.ds2.pg.gda.pl>
	<1063988420.2537.5.camel@ghostwheel.sfbay.redhat.com>
	<20030919164119.GH13578@rembrandt.csv.ica.uni-stuttgart.de>
	<ord6ds346n.fsf@free.redhat.lsd.ic.unicamp.br>
	<20030922233952.GR13578@rembrandt.csv.ica.uni-stuttgart.de>
	<1064280106.21720.0.camel@ghostwheel.sfbay.redhat.com>
	<20030923081447.GS13578@rembrandt.csv.ica.uni-stuttgart.de>
	<1064340070.21720.14.camel@ghostwheel.sfbay.redhat.com>
	<20030923181659.GA30037@nevyn.them.org>
	<87eky7b867.fsf@codesourcery.com>
	<20030923200337.GE18698@rembrandt.csv.ica.uni-stuttgart.de>
Date: Tue, 23 Sep 2003 13:06:03 -0700
In-Reply-To: <20030923200337.GE18698@rembrandt.csv.ica.uni-stuttgart.de> (Thiemo
 Seufer's message of "Tue, 23 Sep 2003 22:03:37 +0200")
Message-ID: <87ad8vb784.fsf@codesourcery.com>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <zack@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zack@codesourcery.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de> writes:

> Zack Weinberg wrote:
>> 
>> Maybe what you really want is an -mdata-model=kernel switch (or some
>> such spelling)
>
> Well, an ELF64 kernel loaded in the 64bit address space is also legal,
> and desireable on some (bigger) hardware. Btw, it would have to be
> -mtext-model=kernel, the data is the same. :-)

Well, you wouldn't compile such a kernel with that switch.  Maybe
spelling it -mtext-model=kseg0 would be more descriptive.

>> that tells gcc to do the right thing in the first place?
>
> Gcc still generates MIPS assembler macros, so such a switch would
> do nothing yet. Gcc should be changed to do the expansion itself
> (and improve code quality by that), but that's a much larger task.

Gcc can at least pass the setting along to the assembler (which would
have to grow such an option as well, either as a command line switch
or (preferred) a .directive).

zw
