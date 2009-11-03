Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2009 16:33:55 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:49232 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493388AbZKCPdw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Nov 2009 16:33:52 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA3FZIbX008911;
	Tue, 3 Nov 2009 16:35:18 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA3FZIId008909;
	Tue, 3 Nov 2009 16:35:18 +0100
Date:	Tue, 3 Nov 2009 16:35:18 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	alsa-devel@alsa-project.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH 2/3] MIPS: Alchemy: DB1200 AC97+I2S audio support.
Message-ID: <20091103153518.GA5999@linux-mips.org>
References: <1257193305-29996-1-git-send-email-manuel.lauss@gmail.com> <1257193305-29996-2-git-send-email-manuel.lauss@gmail.com> <20091103153040.GC1742@linux-mips.org> <f861ec6f0911030730k53b2b921kddc8c67266846af2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f861ec6f0911030730k53b2b921kddc8c67266846af2@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 03, 2009 at 04:30:26PM +0100, Manuel Lauss wrote:

> 
> On Tue, Nov 3, 2009 at 4:30 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> > On Mon, Nov 02, 2009 at 09:21:44PM +0100, Manuel Lauss wrote:
> >
> >> Machine driver for DB1200 AC97 and I2S audio systems, intended as a
> >> proper reference asoc machine for Alchemy-based systems.
> >> AC97/I2S can be selected at boot time by setting switch S6.7
> >>
> >> Cc: alsa-devel@alsa-project.org
> >> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> >> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> >> ---
> >> Depends on patch "ASoC: au1x: convert to platform drivers" in
> >> Mark Brown's asoc tree to actually work.
> >
> > Queued for 2.6.33.  I've not seen the dependency but I hope there is no
> > harm in getting things merged out of order?
> 
> You just won't get any sound if the other patch isnt applied first,
> no build failures of oopses.

With Mark's approval I'd not mind merging the other patch through the MIPS
tree as well then.

  Ralf
