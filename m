Received:  by oss.sgi.com id <S42240AbQGIWHC>;
	Sun, 9 Jul 2000 15:07:02 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:17201 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42185AbQGIWGh>;
	Sun, 9 Jul 2000 15:06:37 -0700
Received: from thor ([207.246.91.243]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id PAA22498; Sun, 9 Jul 2000 15:01:41 -0700 (PDT)
	mail_from (jsk@tetracon-eng.net)
Received: from localhost (localhost [127.0.0.1]) by thor (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id RAA11739; Sun, 9 Jul 2000 17:59:37 -0300
Date:   Sun, 9 Jul 2000 17:59:37 -0300
From:   "J. Scott Kasten" <jsk@tetracon-eng.net>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: Kernel boot tips.
In-Reply-To: <20000709062927.A5609@bacchus.dhis.org>
Message-ID: <Pine.SGI.4.10.10007091756110.11737-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing



On Sun, 9 Jul 2000, Ralf Baechle wrote:

> I've finally commited my rewrite of dvhtool into the CVS archive on
> oss.  It's not yet complete but hackers may be interested in taking a
> look at it.
> 
> One of my next projects will be a standalone libc which can be used to
> write reasonably portable standalone tools like a sash equivalent.

Cool.  We need those things.  The tips I gave are only a work around until
we have a regular boot loader/miniroot.  The one thing that does not
work well with my methods is getting command line args to the booting
kernel such as "root=/dev/sda3" etc...  You can do that, but have to stop
the auto boot and enter the prom command tool to do it.
