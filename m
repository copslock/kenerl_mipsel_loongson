Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Sep 2003 14:40:51 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:30683 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225358AbTIINks>; Tue, 9 Sep 2003 14:40:48 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA18431;
	Tue, 9 Sep 2003 15:40:45 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 9 Sep 2003 15:40:44 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: ralf@linux-mips.org
cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux 
In-Reply-To: <20030909113150Z8225348-1272+5180@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030909153721.18373A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 9 Sep 2003 ralf@linux-mips.org wrote:

> 	Avoid conflict with glibc on bigendian platforms when -O or higher
> 	is specified.  It's already in 2.6, and I'm not sure why it hasn't
> 	been seen in 2.4.  The symptom is that this program will not compile
> 	with -O2:
> 	
> 	#include <asm/byteorder.h>
> 	#include <netinet/in.h>
> 	int main () { }

 Is <asm/byteorder.h> ever included by glibc headers?  I hope not and user
programs *must* not include kernel headers.  Your program is buggy.
