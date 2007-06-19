Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2007 17:58:42 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:61078 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20023650AbXFSQ6k (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2007 17:58:40 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id DE66C3EC9; Tue, 19 Jun 2007 09:58:37 -0700 (PDT)
Message-ID: <46780BA6.3080604@ru.mvista.com>
Date:	Tue, 19 Jun 2007 21:00:22 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH 5/5] Implement clockevents for R4000-style cp0 timer
References: <11818164011355-git-send-email-fbuihuu@gmail.com> <11818164024053-git-send-email-fbuihuu@gmail.com> <20070614.212913.82089068.nemoto@toshiba-tops.co.jp> <20070617000448.GA30807@linux-mips.org> <cda58cb80706180722n18e79a49vfa61450526e6af76@mail.gmail.com> <20070618153718.GA13597@linux-mips.org>
In-Reply-To: <20070618153718.GA13597@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ralf Baechle wrote:

>>Since very few boards are using GEN_RTC:

>>	$ git grep -l "GEN_RTC=y" arch/mips/configs/
>>	arch/mips/configs/bigsur_defconfig
>>	arch/mips/configs/yosemite_defconfig

> Btw, you missed emma2rh_defconfig which builds GEN_RTC as a module.  Silly
> because it doesn't initialize rtc_mips_get_time or rtc_mips_set_time so
> hasn't possible a chance to work as anything but a dummy rtc.

    EMMA2RH bpard doesn't seem to have an RTC.

>   Ralf

WBR, Sergei
