Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2003 20:49:03 +0100 (BST)
Received: from voldemort.codesourcery.com ([IPv6:::ffff:65.73.237.138]:36582
	"EHLO mail.codesourcery.com") by linux-mips.org with ESMTP
	id <S8225376AbTIWTtB>; Tue, 23 Sep 2003 20:49:01 +0100
Received: (qmail 21400 invoked from network); 23 Sep 2003 19:42:03 -0000
Received: from dhcp119.icir.org (HELO taltos.codesourcery.com) (zack@192.150.187.119)
  by mail.codesourcery.com with DES-CBC3-SHA encrypted SMTP; 23 Sep 2003 19:42:03 -0000
Received: by taltos.codesourcery.com (sSMTP sendmail emulation); Tue, 23 Sep 2003 12:45:36 -0700
From: "Zack Weinberg" <zack@codesourcery.com>
To: Eric Christopher <echristo@redhat.com>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
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
Date: Tue, 23 Sep 2003 12:45:36 -0700
In-Reply-To: <20030923181659.GA30037@nevyn.them.org> (Daniel Jacobowitz's
 message of "Tue, 23 Sep 2003 14:16:59 -0400")
Message-ID: <87eky7b867.fsf@codesourcery.com>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <zack@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zack@codesourcery.com
Precedence: bulk
X-list: linux-mips

Daniel Jacobowitz <dan@debian.org> writes:

> On Tue, Sep 23, 2003 at 11:01:11AM -0700, Eric Christopher wrote:
>> 
>> I'm still trying to figure out why you are going through such weird
>> contortions at all. I understand not having an elf64 loader. That's what
>> the objcopy comment was for, everything else I don't understand. Why not
>> compile for the abi you want?
>
> Compare the optimal way to load an address into a register when you
> have a full 64-bit address space and when you know that addresses are
> sign extended.  I'm told it saves over 100K of code.

Maybe what you really want is an -mdata-model=kernel switch (or some
such spelling) that tells gcc to do the right thing in the first
place?

zw
