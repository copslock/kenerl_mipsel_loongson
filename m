Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2003 12:16:35 +0000 (GMT)
Received: from p508B7DCA.dip.t-dialin.net ([IPv6:::ffff:80.139.125.202]:37811
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225261AbTCDMQe>; Tue, 4 Mar 2003 12:16:34 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h24CGVS08332
	for linux-mips@linux-mips.org; Tue, 4 Mar 2003 13:16:31 +0100
Resent-Message-Id: <200303041216.h24CGVS08332@dea.linux-mips.net>
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h24C7ml08053;
	Tue, 4 Mar 2003 13:07:48 +0100
Date: Tue, 4 Mar 2003 13:07:48 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [patch] simulate_ll and simulate_sc(resend)
Message-ID: <20030304130748.B18143@linux-mips.org>
References: <20030303192137.34d21352.yoichi_yuasa@montavista.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030303192137.34d21352.yoichi_yuasa@montavista.co.jp>; from yoichi_yuasa@montavista.co.jp on Mon, Mar 03, 2003 at 07:21:37PM +0900
Resent-From: ralf@linux-mips.org
Resent-Date: Tue, 4 Mar 2003 13:16:31 +0100
Resent-To: linux-mips@linux-mips.org
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 03, 2003 at 07:21:37PM +0900, Yoichi Yuasa wrote:

>  sig:
> +	compute_return_epc(regs);
>  	send_sig(signal, current, 1);

In the error case you can't advance the epc ..

It's an old bug already but the signal should be sent with force_sig,
not send_sig.

  Ralf
