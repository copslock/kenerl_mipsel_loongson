Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id IAA996531 for <linux-archive@neteng.engr.sgi.com>; Wed, 1 Oct 1997 08:56:57 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA10344 for linux-list; Wed, 1 Oct 1997 08:56:38 -0700
Received: from heaven.newport.sgi.com (heaven.newport.sgi.com [169.238.102.134]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA10338 for <linux@cthulhu.engr.sgi.com>; Wed, 1 Oct 1997 08:56:35 -0700
Received: (from carlson@localhost) by heaven.newport.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id IAA13078 for linux@cthulhu.engr.sgi.com; Wed, 1 Oct 1997 08:56:30 -0700
From: "Christopher W. Carlson" <carlson@heaven.newport.sgi.com>
Message-Id: <9710010856.ZM13076@heaven.newport.sgi.com>
Date: Wed, 1 Oct 1997 08:56:30 -0700
In-Reply-To: "William J. Earl" <wje@fir.engr.sgi.com>
        "Re: IRIX ELF docs" (Sep 30,  4:42pm)
References: <199709302336.QAA22417@dns.cobaltmicro.com> 
	<199709302342.QAA14355@fir.engr.sgi.com>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: linux@cthulhu.engr.sgi.com
Subject: Re: IRIX ELF docs
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sep 30,  4:42pm, William J. Earl wrote:
> Subject: Re: IRIX ELF docs
> Ralf Baechle writes:
>  > Hi all,
>  >
>  > our current linker is producing IRIX flavored ELF binaries, not MIPS
>  > ABI.  We still seem to have some bugs in the dynamic linker and these
>  > are now pretty close to the top on my to do list.  However I've got
>  > not documentation about the IRIX binary format, so I'm pretty much
>  > relying on reverse engineering for fixing them.  Does anybody have
>  > a pointer to documentation or documentation about IRIX ELF flavoured
>  > o32 bit object file format?
>
>       IRIX ELF O32 (dynamic) object files are MIPS ABI object files.
> There are optional extra sections, to support features such as "quickstart"
> (which allows RLD to skip some of the fixups at startup time), but the
> required parts are as defined by the MIPS ABI.
>-- End of excerpt from William J. Earl


I recently went to the local technical bookstore and found that AT&T
no longer publishes the ABI books (the blue covered books describing
the ELF format).  The bookstore was, thus, unable to even order them
for me.

Does anybody know where to buy these books?

-- 

		Chris Carlson

	+------------------------------------------------------+
	| Also, carlson@sgi.com                                |
	|   Work:   (714) 224-4530                             |
	|   Vnet:       6-678-4530     FAX:    (714) 833-9503  |
	|                                                      |
	| Trivia fact: an electroencephalogram shows that a    |
	| human brain and a bowl of quivering lime Jell-O have |
	| the same waves.  [Time Magazine, Mar 17, 1997]       |
	+------------------------------------------------------+
