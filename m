Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 May 2007 07:12:17 +0100 (BST)
Received: from europa.telenet-ops.be ([195.130.137.75]:16030 "EHLO
	europa.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20021458AbXEWGMP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 May 2007 07:12:15 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by europa.telenet-ops.be (Postfix) with SMTP id 7AFB3416C;
	Wed, 23 May 2007 08:12:15 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by europa.telenet-ops.be (Postfix) with ESMTP id 490A14174;
	Wed, 23 May 2007 08:12:14 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.13.8/8.13.8/Debian-3) with ESMTP id l4N6CEAn022551
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 May 2007 08:12:14 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.13.8/8.13.8/Submit) with ESMTP id l4N6CDtW022548;
	Wed, 23 May 2007 08:12:14 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Wed, 23 May 2007 08:12:13 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	sknauert@wesleyan.edu
Cc:	linux-mips@linux-mips.org
Subject: Re: Cross-Compile difficulties
In-Reply-To: <51450.129.133.92.31.1179873846.squirrel@webmail.wesleyan.edu>
Message-ID: <Pine.LNX.4.64.0705230811500.19474@anakin>
References: <20070516151939.GH19816@deprecation.cyrius.com>
 <20070516160313.GA3409@bongo.bofh.it> <50621.192.168.2.50.1179383217.squirrel@eppesuigoccas.homedns.org>
 <20070517151636.GJ3586@deprecation.cyrius.com> <20070521154726.GE5943@linux-mips.org>
 <20070522110956.GB29118@linux-mips.org> <1179834093.7896.23.camel@scarafaggio>
 <34888.129.133.92.31.1179835313.squirrel@webmail.wesleyan.edu>
 <20070522122808.GD32557@linux-mips.org> <36324.129.133.92.31.1179840724.squirrel@webmail.wesleyan.edu>
 <20070522151848.GB19833@networkno.de> <33252.129.133.92.31.1179852417.squirrel@webmail.wesleyan.edu>
 <Pine.LNX.4.64.0705221931380.11196@anakin> <51450.129.133.92.31.1179873846.squirrel@webmail.wesleyan.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 22 May 2007, sknauert@wesleyan.edu wrote:
> I also tried rsyncing the Debian sources over to my Core Duo 2 Debian
> machine for cross-compiling. I was unable to get past the .config step.
> Debian's patches must hinder cross-compiling in some manner. For example,
> make menuconfig seems to refuse to display MIPS as the architecture
> anymore.

You did add `ARCH=mips' to the make command line?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
