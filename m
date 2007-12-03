Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Dec 2007 13:35:58 +0000 (GMT)
Received: from mo31.po.2iij.NET ([210.128.50.54]:33099 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20024469AbXLCNfu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 3 Dec 2007 13:35:50 +0000
Received: by mo.po.2iij.net (mo31) id lB3DYLFh055260; Mon, 3 Dec 2007 22:34:21 +0900 (JST)
Received: from delta (95.26.30.125.dy.iij4u.or.jp [125.30.26.95])
	by mbox.po.2iij.net (po-mbox303) id lB3DYJCt013684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 3 Dec 2007 22:34:19 +0900
Date:	Mon, 3 Dec 2007 22:34:18 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org,
	Richard Purdie <rpurdie@rpsys.net>
Subject: Re: CONFIG_LEDS_COBALT_RAQ not as module
Message-Id: <20071203223418.2fec44a9.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20071130163258.GA10006@deprecation.cyrius.com>
References: <20071130163258.GA10006@deprecation.cyrius.com>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Fri, 30 Nov 2007 17:32:58 +0100
Martin Michlmayr <tbm@cyrius.com> wrote:

> Hi Yoichi,
> 
> Is there are good reason why LEDS_COBALT_QUBE is a tristate while
> LEDS_COBALT_RAQ is a bool?  I don't see why the RAQ LED driver
> couldn't be modular.

RAQ LED driver support power off trigger.
Power off trigger is generated at the end of all.

This is the reason why RAQ LED driver doesn't have module_exit function.
Moreover, this is the reason why it is bool.

Yoichi
