Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jul 2003 19:20:09 +0100 (BST)
Received: from janus.foobazco.org ([IPv6:::ffff:198.144.194.226]:46468 "EHLO
	mail.foobazco.org") by linux-mips.org with ESMTP
	id <S8225221AbTGUSUG>; Mon, 21 Jul 2003 19:20:06 +0100
Received: by mail.foobazco.org (Postfix, from userid 1014)
	id AA4F6FA38; Mon, 21 Jul 2003 11:20:02 -0700 (PDT)
Date: Mon, 21 Jul 2003 11:20:02 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Kevin D. Kissell" <kevink@mips.com>, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20030721182002.GA28587@foobazco.org>
References: <02a701c34f81$4f32ca50$10eca8c0@grendel> <Pine.GSO.3.96.1030721172805.13489C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030721172805.13489C-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.4i
Return-Path: <wesolows@foobazco.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wesolows@foobazco.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 21, 2003 at 05:50:08PM +0200, Maciej W. Rozycki wrote:

>  Well, duplication is certainly undesireable, but is it the result of
> separate arch/mips and arch/mips64 trees or is it a side effect only? 
> These separate trees have an advantage of a clear distinction between
> these architectures.  And arch/sparc vs arch/sparc64 were the first case
> of such a split and they seem to feel quite well. 

sparc32 and sparc64 processors and systems are significantly
different.  For example, the SRMMU present in v8 CPUs is 100% replaced
with a totally different MMU (indeed, totally different instructions,
access methods, etc) in v9.  Accordingly there is very little code in
common between the two ports, and most of that is in device handling;
code that is in drivers/sbus and thus shared anyway.

Something that made sense for sparc might not make sense for mips.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"May Buddha bless all stubborn people!"
				-- Uliassutai Karakorum Blake
