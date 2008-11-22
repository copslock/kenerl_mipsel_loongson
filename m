Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Nov 2008 10:13:48 +0000 (GMT)
Received: from edna.telenet-ops.be ([195.130.132.58]:35270 "EHLO
	edna.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S23830381AbYKVKNi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 22 Nov 2008 10:13:38 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by edna.telenet-ops.be (Postfix) with SMTP id 654A8E403A;
	Sat, 22 Nov 2008 11:13:37 +0100 (CET)
Received: from anakin.of.borg (d54C15368.access.telenet.be [84.193.83.104])
	by edna.telenet-ops.be (Postfix) with ESMTP id 26A78E4018;
	Sat, 22 Nov 2008 11:13:37 +0100 (CET)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.3/8.14.3/Debian-5) with ESMTP id mAMADZOS005354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 22 Nov 2008 11:13:36 +0100
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.3/8.14.3/Submit) with ESMTP id mAMADXL3005334;
	Sat, 22 Nov 2008 11:13:34 +0100
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Sat, 22 Nov 2008 11:13:31 +0100 (CET)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	"Kevin D. Kissell" <kevink@paralogos.com>
cc:	Chad Reese <kreese@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: Re: Is there no way to shared code with Linux and other OSes?
In-Reply-To: <4927D6E0.4020009@paralogos.com>
Message-ID: <Pine.LNX.4.64.0811221109330.29539@anakin>
References: <4927C34F.4000201@caviumnetworks.com> <4927D6E0.4020009@paralogos.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Sat, 22 Nov 2008, Kevin D. Kissell wrote:
> [This should be good for some useless weekend flaming.]

Yeah! ;-)

> Chad Reese wrote:
> to move away from such arbitrary dogmatism.  The argument given for banning
> typedefs altogether is that nested typedefs are confusing to programmers.  I

I thought the main reason was that you can't have forward declarations of
typedefs, while you can have for structs.

Hence

    typedef struct {
	...
	b_t *p;
    } a_t;

    typedef struct {
	...
	a_t *p;
    } b_t;

won't fly.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
