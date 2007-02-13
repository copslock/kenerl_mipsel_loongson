Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2007 16:18:04 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:28362 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039278AbXBMQSC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Feb 2007 16:18:02 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1DGI1Yh009951;
	Tue, 13 Feb 2007 16:18:01 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1DGI101009950;
	Tue, 13 Feb 2007 16:18:01 GMT
Date:	Tue, 13 Feb 2007 16:18:01 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org, anemo@mba.ocn.ne.jp,
	macro@linux-mips.org
Subject: Re: [PATCH 2/3] Automatically set CONFIG_BUILD_ELF64
Message-ID: <20070213161801.GA9700@linux-mips.org>
References: <1171358289786-git-send-email-fbuihuu@gmail.com> <11713582901742-git-send-email-fbuihuu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11713582901742-git-send-email-fbuihuu@gmail.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 13, 2007 at 10:18:08AM +0100, Franck Bui-Huu wrote:

> +    cflags-y += -DCONFIG_BUILD_ELF64
                   ^^^^^^^^^^^^^^^^^^^^

Preprocessor symbol names starting CONFIG_ are reserved for Kbuild.

  Ralf
