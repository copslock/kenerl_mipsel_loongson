Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2007 11:22:06 +0000 (GMT)
Received: from smtp113.plus.mail.re1.yahoo.com ([69.147.102.76]:22950 "HELO
	smtp113.plus.mail.re1.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20023980AbXJ3LV5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 30 Oct 2007 11:21:57 +0000
Received: (qmail 88266 invoked from network); 30 Oct 2007 11:20:51 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:X-YMail-OSG:Date:From:X-X-Sender:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
  b=ux8m7yI/OGzIVVSI7PP6xJWnXjpE8QW9JcqRYvV9n2SokDvprzHAMtAAgDlCDa7q32+EoDyAz66GX3R4CO/1Fkdn4Ua+cXGKUE8xBEaFcGesFNWTAC7j6rZFKJPKQD/9CtmtANGUCS21EH8ZiJhX2H2nugwu40sBGGaTB3bAHH0=  ;
Received: from unknown (HELO zeus.tetracon-eng.net) (jscottkasten@72.185.69.24 with login)
  by smtp113.plus.mail.re1.yahoo.com with SMTP; 30 Oct 2007 11:20:50 -0000
X-YMail-OSG: oYiRbMUVM1l3LNdrOAKJM9GCKx1yqFoUIz.ZZXSG34KcdYdtaCQfbIDoe9SIFaT4eu.ottyIId8h6Ht0NXkNxOeUoUlXMcnCJn0YeK0KGpcHZpVA8r2qOAeotW9e
Date:	Tue, 30 Oct 2007 07:20:44 -0400
From:	"J. Scott Kasten" <jscottkasten@yahoo.com>
X-X-Sender: jsk@zeus.tetracon-eng.net
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: 2.4.24-rc1 does not boot on SGI
In-Reply-To: <1193733706.7731.15.camel@scarafaggio>
Message-ID: <Pine.SGI.4.60.0710300717080.2654@zeus.tetracon-eng.net>
References: <1193468825.7474.6.camel@scarafaggio>  <20071030083106.GA16763@deprecation.cyrius.com>
 <1193733706.7731.15.camel@scarafaggio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-Path: <jscottkasten@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jscottkasten@yahoo.com
Precedence: bulk
X-list: linux-mips



On Tue, 30 Oct 2007, Giuseppe Sacco wrote:

> my config file for 2.6.23.1 from kernel.org is
> http://eppesuigoccas.homedns.org/~giuseppe/debian/sgi-mips-config-2.6.23.1-gs2.bz2
>
> currently open points:
>
> 1. serial line does not work
>

You say the serial line does not work.  I'm running debian's 2.6.18 kernel 
on my daily use box.  I had an urgent need to communicate with a serial 
device and tried using my O2.  No dice.  I finally dug the laptop out of 
the closet and took care of it that way.  It sounds like the generic 
serial stuff was broken a ways back.

-S-
