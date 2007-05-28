Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2007 11:22:19 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:29379 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20025481AbXEaKUN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 31 May 2007 11:20:13 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l4VAJms0022195;
	Thu, 31 May 2007 11:20:01 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l4SDH3DV010483;
	Mon, 28 May 2007 14:17:03 +0100
Date:	Mon, 28 May 2007 14:17:03 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Fuxin Zhang <fxzhang@ict.ac.cn>
Cc:	guanzb@lemote.com, Martin Michlmayr <tbm@cyrius.com>,
	debian-mips@lists.debian.org,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Several packages whose page size is 4k.
Message-ID: <20070528131703.GA10298@linux-mips.org>
References: <464A7C53.3010309@lemote.com> <464A805C.5020606@ict.ac.cn> <20070516081555.GA22169@networkno.de> <464AC466.4000907@lemote.com> <20070516085737.GD22169@networkno.de> <20070516094617.GJ19816@deprecation.cyrius.com> <464ADF9B.6050602@lemote.com> <464AE59E.2070004@ict.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <464AE59E.2070004@ict.ac.cn>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 16, 2007 at 07:06:06PM +0800, Fuxin Zhang wrote:

> Zhibin.Guan 写道:
> >  We have already commit kernel patches to linux-mips.
> > but, it seems that they have no reaction and response to that.
> To be fair, Ralf do response, I remembered that the last question he
> asked was related to alsa patches, but we have nobody to handle that.
> 
> Maybe that part can be ignored presently and let us make the necessary
> parts in first.
> 
> What is your opinion, Ralf?

(My personal email setup had a hickup and so about 9MB of email from
around the week of the 16/5 were stuck in a temp file.  If there is
anything that you're still waiting for an answer, please let me know.)

The ALSA patch solves a generic ALSA/MIPS issue, so independent of the
rest.  So I suggest we tackle the rest of the Fulong patchset separately.
Just resend the Fulong patchset once the issues I raised have been resolved.

  Ralf
