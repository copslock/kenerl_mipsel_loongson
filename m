Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA06027; Thu, 29 May 1997 08:30:09 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA01348 for linux-list; Thu, 29 May 1997 08:29:22 -0700
Received: from heaven.newport.sgi.com (heaven.newport.sgi.com [169.238.102.134]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA01334 for <linux@engr.sgi.com>; Thu, 29 May 1997 08:29:19 -0700
Received: by heaven.newport.sgi.com (940816.SGI.8.6.9/940406.SGI)
	for linux@engr id IAA20852; Thu, 29 May 1997 08:29:18 -0700
From: "Christopher W. Carlson" <carlson@heaven.newport.sgi.com>
Message-Id: <9705290829.ZM20850@heaven.newport.sgi.com>
Date: Thu, 29 May 1997 08:29:18 -0700
In-Reply-To: Miguel de Icaza <miguel@nuclecu.unam.mx>
        "Linux ext2fs goes multi-device :-)" (May 29, 12:48am)
References: <199705290548.AAA03659@athena.nuclecu.unam.mx>
X-Mailer: Z-Mail-SGI (3.2S.2 10apr95 MediaMail)
To: linux@cthulhu.engr.sgi.com
Subject: Re: Linux ext2fs goes multi-device :-)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On May 29, 12:48am, Miguel de Icaza wrote:
> Subject: Linux ext2fs goes multi-device :-)
>
> I was impressed by the extensive XFS feature list (from some comments
> I read from this mailing list archives, and later from the Usenix
> paper), so during the past days I coded a little extension to ext2fs
> that allows a file system to be extended at runtime.
>
> Say, you are running out of space in /home, you type:
>
> 	e2extend /home /dev/sdb1
>
> (where /dev/sdb1 is a fresh disk ready to be used as an extension to
> /home).  And poof!  instant extra space in /home.
>
> This is from my limited understanding of the IRIX man pages describind
> xlv and xfs.
>
> Tonight this code just passed a lot of testing, I will clean it up and
> post to linux-kernel soonish.
>
> Cheers,
> Miguel.
>-- End of excerpt from Miguel de Icaza


That sounds super cool!  Good work!

-- 

		Chris Carlson

	+------------------------------------------------------+
	| Also, carlson@sgi.com                                |
	|   Work:       (714) 756-5976     SGI vmail: 678-4530 |
	|   FAX:        (714) 833-9503                         |
	|                                                      |
	| Trivia fact: an electroencephalogram shows that a    |
	| human brain and a bowl of quivering lime Jell-O have |
	| the same waves.  [Time Magazine, Mar 17, 1997]       |
	+------------------------------------------------------+
