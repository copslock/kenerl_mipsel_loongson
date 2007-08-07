Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2007 16:44:09 +0100 (BST)
Received: from ananke.telenet-ops.be ([195.130.137.78]:39323 "EHLO
	ananke.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20022931AbXHGPoA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Aug 2007 16:44:00 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by ananke.telenet-ops.be (Postfix) with SMTP id 344CE3923E5;
	Tue,  7 Aug 2007 17:43:50 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by ananke.telenet-ops.be (Postfix) with ESMTP id 231C43923D7;
	Tue,  7 Aug 2007 17:43:50 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-8) with ESMTP id l77Fhn0L003865
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 7 Aug 2007 17:43:49 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id l77FhnIg003862;
	Tue, 7 Aug 2007 17:43:49 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Tue, 7 Aug 2007 17:43:49 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Mohamed Bamakhrama <bamakhrama@gmail.com>
cc:	linux-mips@linux-mips.org
Subject: Re: ELF to S-Record convertor
In-Reply-To: <40378e40708070832g1aa613fcg7e486d0d778bb84f@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0708071743380.29955@anakin>
References: <40378e40708070832g1aa613fcg7e486d0d778bb84f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 7 Aug 2007, Mohamed Bamakhrama wrote:
> Does anyone know of any open source tool for converting ELF images to
> S-Record images?

objcopy from binutils?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
