Received:  by oss.sgi.com id <S42272AbQILEvZ>;
	Mon, 11 Sep 2000 21:51:25 -0700
Received: from kayak.mcgary.org ([63.227.80.137]:57870 "EHLO kayak.mcgary.org")
	by oss.sgi.com with ESMTP id <S42268AbQILEvF>;
	Mon, 11 Sep 2000 21:51:05 -0700
Received: (from gkm@localhost)
	by kayak.mcgary.org (8.9.3/8.9.3) id VAA32409;
	Mon, 11 Sep 2000 21:50:54 -0700
X-Authentication-Warning: kayak.mcgary.org: gkm set sender to greg using -f
To:     linux-mips@oss.sgi.com
Subject: Re: do_page_fault crash on Indigo2
References: <200009120107.SAA31731@kayak.mcgary.org>
From:   Greg McGary <greg@mcgary.org>
Date:   11 Sep 2000 21:50:54 -0700
In-Reply-To: Greg McGary's message of "Mon, 11 Sep 2000 18:07:17 -0700"
Message-ID: <msk8ci1adt.fsf@mcgary.org>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Greg McGary <greg@mcgary.org> writes:

> Oops in fault.c:do_page_fault, line 158:

I'll send cross-ksymoops output when I it running.

> Clues?

As a fallback, can someone give me a date, or better yet a CVS tag,
for which an indigo2 kernel is known to work.

Thanks,
Greg
