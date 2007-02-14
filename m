Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Feb 2007 11:42:59 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:35333 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20037594AbXBNLmy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Feb 2007 11:42:54 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 27A2FE1CAA;
	Wed, 14 Feb 2007 12:42:15 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KdZbWgbpgpYw; Wed, 14 Feb 2007 12:42:14 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id C6E12E1C61;
	Wed, 14 Feb 2007 12:42:14 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l1EBgMjc016131;
	Wed, 14 Feb 2007 12:42:23 +0100
Date:	Wed, 14 Feb 2007 11:42:19 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	vagabon.xyz@gmail.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] Automatically set CONFIG_BUILD_ELF64
In-Reply-To: <20070214.102801.41198530.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.LNX.4.64N.0702141141560.16061@blysk.ds.pg.gda.pl>
References: <11713582901742-git-send-email-fbuihuu@gmail.com>
 <20070213161801.GA9700@linux-mips.org> <cda58cb80702130909u2c0cbe8fg6929fc78ca8d3cb8@mail.gmail.com>
 <20070214.102801.41198530.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.7/2565/Wed Feb 14 08:36:47 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 14 Feb 2007, Atsushi Nemoto wrote:

> How about simple BUILD_SYM32?  And replase BUILD_ELF32 with
> BUILD_SYM32 too?

 It sounds reasonable to me.

  Maciej
