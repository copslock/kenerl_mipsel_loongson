Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Sep 2002 18:17:44 +0200 (CEST)
Received: from mail2.sonytel.be ([195.0.45.172]:38536 "EHLO mail.sonytel.be")
	by linux-mips.org with ESMTP id <S1122978AbSITQRn>;
	Fri, 20 Sep 2002 18:17:43 +0200
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id SAA07301;
	Fri, 20 Sep 2002 18:17:31 +0200 (MET DST)
Date: Fri, 20 Sep 2002 18:17:32 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: CVS server moved
In-Reply-To: <20020920180651.A32600@linux-mips.org>
Message-ID: <Pine.GSO.4.21.0209201816130.16358-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 20 Sep 2002, Ralf Baechle wrote:
> I moved the cvs archive to ftp.linux-mips.org two days ago.  If you already
> have a checked out copy, here is how to avoid having to checkout again:
> 
>   cvs -d :pserver:cvs@ftp.linux-mips.org:/home/cvs login
> 
> The password for anonymous cvs is cvs.
> 
>    cd <your-checked-out-copy>
>    find . -name Root | while read n; do
>        echo ftp.linux-mips.org:/home/cvs > $n
>    done

People who use anonymous CVS want to prepend `:pserver:cvs@', i.e.

|  cd <your-checked-out-copy>
|  find . -name Root | while read n; do
|      echo :pserver:cvs@ftp.linux-mips.org:/home/cvs > $n
|  done

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
