Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2008 10:27:58 +0000 (GMT)
Received: from winston.telenet-ops.be ([195.130.137.75]:54757 "EHLO
	winston.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S23813098AbYKUK1w (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Nov 2008 10:27:52 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by winston.telenet-ops.be (Postfix) with SMTP id 408E0A006E;
	Fri, 21 Nov 2008 11:27:51 +0100 (CET)
Received: from anakin.of.borg (d54C15368.access.telenet.be [84.193.83.104])
	by winston.telenet-ops.be (Postfix) with ESMTP id ADECBA008B;
	Fri, 21 Nov 2008 11:27:50 +0100 (CET)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.3/8.14.3/Debian-5) with ESMTP id mALARodH028748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 21 Nov 2008 11:27:50 +0100
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.3/8.14.3/Submit) with ESMTP id mALARnlC028737;
	Fri, 21 Nov 2008 11:27:49 +0100
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Fri, 21 Nov 2008 11:27:48 +0100 (CET)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
cc:	David Daney <ddaney@caviumnetworks.com>,
	linux-mips <linux-mips@linux-mips.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Make BUG() __noreturn.
In-Reply-To: <20081121100035.3f5a640b@lxorguk.ukuu.org.uk>
Message-ID: <Pine.LNX.4.64.0811211126420.26004@anakin>
References: <49260E4C.8080500@caviumnetworks.com> <20081121100035.3f5a640b@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 21 Nov 2008, Alan Cox wrote:
> On Thu, 20 Nov 2008 17:26:36 -0800
> David Daney <ddaney@caviumnetworks.com> wrote:
> 
> > MIPS: Make BUG() __noreturn.
> > 
> > Often we do things like put BUG() in the default clause of a case
> > statement.  Since it was not declared __noreturn, this could sometimes
> > lead to bogus compiler warnings that variables were used
> > uninitialized.
> > 
> > There is a small problem in that we have to put a magic while(1); loop to
> > fool GCC into really thinking it is noreturn.  
> 
> That sounds like your __noreturn macro is wrong.
> 
> Try using __attribute__ ((__noreturn__))
> 
> if that works then fix up the __noreturn definitions for the MIPS and gcc
> you have.

Nope, gcc is too smart:

$ cat a.c

int f(void) __attribute__((__noreturn__));

int f(void)
{
}

$ gcc -c -Wall a.c
a.c: In function f:
a.c:6: warning: `noreturn' function does return
$ 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
