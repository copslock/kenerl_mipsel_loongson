Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 15:49:02 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:53234 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021903AbXCSPs5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Mar 2007 15:48:57 +0000
Received: from localhost (p3228-ipad01funabasi.chiba.ocn.ne.jp [61.207.77.228])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 0AD1FAAA0; Tue, 20 Mar 2007 00:47:37 +0900 (JST)
Date:	Tue, 20 Mar 2007 00:47:36 +0900 (JST)
Message-Id: <20070320.004736.10544260.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org
Subject: Re: ZONE_DMA on MIPS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <45FEAD11.7070503@ru.mvista.com>
References: <20070320.000947.88474417.anemo@mba.ocn.ne.jp>
	<45FEAD11.7070503@ru.mvista.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 19 Mar 2007 18:32:33 +0300, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > Are there any other platforms requires special DMA zone?
> 
>     Erm, RBHMA4[24]00 have 8259 on the backplane... And the NEC boards with 
> the Rockhopper backplane as well...

Having 8259 does not mean it uses ISA DMA.  IIRC FPCIB0 backplane does
not have real ISA slot, and no on-board device uses ISA DMA.  Does
Rockhopper backplace have ISA slot?

---
Atsushi Nemoto
