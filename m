Received:  by oss.sgi.com id <S305156AbPKXWN2>;
	Wed, 24 Nov 1999 14:13:28 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:9020 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbPKXWNJ>;
	Wed, 24 Nov 1999 14:13:09 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA08512
	for <linuxmips@oss.sgi.com>; Wed, 24 Nov 1999 14:15:19 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA28969
	for linux-list;
	Wed, 24 Nov 1999 13:57:12 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [150.166.40.92])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA21148
	for <linux@relay.engr.sgi.com>;
	Wed, 24 Nov 1999 13:57:00 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id NAA03159
	for linux@engr.sgi.com; Wed, 24 Nov 1999 13:57:00 -0800
Date:   Wed, 24 Nov 1999 13:57:00 -0800
Message-Id: <199911242157.NAA03159@liveoak.engr.sgi.com>
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From:   Ralf Baechle <ralf@uni-koblenz.de>
To:     "Gleb O. Raiko" <raiko@niisi.msk.ru>
Cc:     "Bradley D. LaRonde" <brad@ltc.com>, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Re: Location of init_task_union
In-Reply-To: <383BAC57.C6DF1504@niisi.msk.ru>
References: <007801bf3500$90edf810$b8119526@ltc.com> <19991123230824.E16508@uni-koblenz.de> <01f101bf3601$0cf42fa0$b8119526@ltc.com> <19991123232110.H16508@uni-koblenz.de> <021f01bf3602$97f7b0d0$b8119526@ltc.com> <19991123235314.I16508@uni-koblenz.de> <023301bf3606$338ee650$b8119526@ltc.com> <383BAC57.C6DF1504@niisi.msk.ru>
X-Mailer: Mutt 1.0pre3us
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Nov 24, 1999 at 12:13:59PM +0300, Gleb O. Raiko wrote:

> "Bradley D. LaRonde" wrote:
> > So when do we get this for mips32?  :-)
> 
> The patch that moves cpu detection to plain C already exists and it's
> easy to port other stuff from mips64. The only problem I didn't apply
> the patch yet is I have to make pci operable again and I am busy in that
> direction.

I plan to commit 2.3.21 into CVS this evening.  I do this mostly in order
to keep the 32-bit tree upto sync with Linus.  This will also contain a
pile of 64-bit stuff, just not all of it nor be complete.  I hope that
some people will take this as inspiration and fold some of the cleanups
back into the 32-bit tree while I continue to fight in the endless [1]
64-bit address space ...

  Ralf

[1] Where endless is defined as 1TB.
