Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2007 16:16:53 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:13561 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023471AbXILPQo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 12 Sep 2007 16:16:44 +0100
Received: from localhost (p8044-ipad303funabasi.chiba.ocn.ne.jp [123.217.154.44])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D846BD7D7; Thu, 13 Sep 2007 00:16:38 +0900 (JST)
Date:	Thu, 13 Sep 2007 00:18:09 +0900 (JST)
Message-Id: <20070913.001809.106261283.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [MIPS] SMTC: Fix crash on bootup with idebus= command line
 argument.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64N.0709111509140.30365@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0709111431240.30365@blysk.ds.pg.gda.pl>
	<20070911.230712.39152979.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64N.0709111509140.30365@blysk.ds.pg.gda.pl>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 11 Sep 2007 15:28:04 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
>  Not quite so.  The test for the PCI-(E)ISA bridge is there so that they 
> are handled.  Now I gather the use of no_pci_devices() in 
> ide_probe_legacy() effectively disables the test entirely (thus making it 
> a candidate for removal).  Or am I missing something?

Well, I missed your point...  please elaborate?

---
Atsushi Nemoto
