Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Mar 2004 14:27:01 +0000 (GMT)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:14812 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225562AbUCBO1A>;
	Tue, 2 Mar 2004 14:27:00 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id XAA06681;
	Tue, 2 Mar 2004 23:26:56 +0900 (JST)
Received: 4UMDO00 id i22EQtT02909; Tue, 2 Mar 2004 23:26:55 +0900 (JST)
Received: 4UMRO01 id i22EQsf15828; Tue, 2 Mar 2004 23:26:55 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Tue, 2 Mar 2004 23:26:53 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: Re: [PATCH][2.6] Fixed ISA configuration
Message-Id: <20040302232653.1199e242.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20040302125034.GA13504@linux-mips.org>
References: <20040302195028.3addcdf7.yuasa@hh.iij4u.or.jp>
	<20040302125034.GA13504@linux-mips.org>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

On Tue, 2 Mar 2004 13:50:34 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Tue, Mar 02, 2004 at 07:50:28PM +0900, Yoichi Yuasa wrote:
> 
> > This patch solves the problem which cannot choose ISA support about CASIO E55, IBM WorkPad, and others.
> > Please apply this patch to v2.6.
> 
> I've choosen to fix this a different way.  I don't think it's a good idea
> to require users to know if they need to enable CONFIG_ISA or not because
> the question isn't equivalent to having ISA slots or not, so there's
> potencial for missconfiguration.  So my alternative patch which I checked
> now uses reverse dependencies to eleminate the long depends line of the
> config ISA block and only enable ISA where really necessary.

Ok, I don't have a problem about it.

Thanks,

Yoichi
