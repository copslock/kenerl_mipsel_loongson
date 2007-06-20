Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2007 14:56:16 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:61572 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024693AbXFTNzJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 Jun 2007 14:55:09 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5KDlRYg030654;
	Wed, 20 Jun 2007 14:47:33 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5K8Fkcm025245;
	Wed, 20 Jun 2007 09:15:46 +0100
Date:	Wed, 20 Jun 2007 09:15:46 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH 5/5] Implement clockevents for R4000-style cp0 timer
Message-ID: <20070620081546.GE24818@linux-mips.org>
References: <11818164011355-git-send-email-fbuihuu@gmail.com> <11818164024053-git-send-email-fbuihuu@gmail.com> <20070614.212913.82089068.nemoto@toshiba-tops.co.jp> <20070617000448.GA30807@linux-mips.org> <cda58cb80706180722n18e79a49vfa61450526e6af76@mail.gmail.com> <20070618153718.GA13597@linux-mips.org> <46780BA6.3080604@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46780BA6.3080604@ru.mvista.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 19, 2007 at 09:00:22PM +0400, Sergei Shtylyov wrote:

> >Btw, you missed emma2rh_defconfig which builds GEN_RTC as a module.  Silly
> >because it doesn't initialize rtc_mips_get_time or rtc_mips_set_time so
> >hasn't possible a chance to work as anything but a dummy rtc.
> 
>    EMMA2RH bpard doesn't seem to have an RTC.

I guess then having it fail rather then pretending it has has functinality
which isn't there seems to be the better thing.

  Ralf
