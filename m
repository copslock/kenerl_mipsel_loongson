Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2003 21:19:36 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:65038
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225376AbTIWUTe>; Tue, 23 Sep 2003 21:19:34 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1A1tce-0003lC-00; Tue, 23 Sep 2003 22:18:56 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1A1tcd-0007Tf-00; Tue, 23 Sep 2003 22:18:55 +0200
Date: Tue, 23 Sep 2003 22:18:55 +0200
To: Zack Weinberg <zack@codesourcery.com>
Cc: Eric Christopher <echristo@redhat.com>,
	Alexandre Oliva <aoliva@redhat.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: recent binutils and mips64-linux
Message-ID: <20030923201855.GF18698@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030919164119.GH13578@rembrandt.csv.ica.uni-stuttgart.de> <ord6ds346n.fsf@free.redhat.lsd.ic.unicamp.br> <20030922233952.GR13578@rembrandt.csv.ica.uni-stuttgart.de> <1064280106.21720.0.camel@ghostwheel.sfbay.redhat.com> <20030923081447.GS13578@rembrandt.csv.ica.uni-stuttgart.de> <1064340070.21720.14.camel@ghostwheel.sfbay.redhat.com> <20030923181659.GA30037@nevyn.them.org> <87eky7b867.fsf@codesourcery.com> <20030923200337.GE18698@rembrandt.csv.ica.uni-stuttgart.de> <87ad8vb784.fsf@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ad8vb784.fsf@codesourcery.com>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Zack Weinberg wrote:
[snip]
> Gcc can at least pass the setting along to the assembler (which would
> have to grow such an option as well, either as a command line switch
> or (preferred) a .directive).

Hand-coded assembly will need the command line switch, as the same
file should work for both models if possible.


Thiemo
