Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Mar 2005 00:41:14 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:57860
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225073AbVCVAk7>; Tue, 22 Mar 2005 00:40:59 +0000
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 22 Mar 2005 00:40:58 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 581E91EF7D;
	Tue, 22 Mar 2005 09:40:54 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 4443A18E4E;
	Tue, 22 Mar 2005 09:40:54 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j2M0er9c068761;
	Tue, 22 Mar 2005 09:40:53 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 22 Mar 2005 09:40:53 +0900 (JST)
Message-Id: <20050322.094053.108307511.nemoto@toshiba-tops.co.jp>
To:	maillist@jg555.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: Current Build Warning Message
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <423F25AD.6030705@jg555.com>
References: <423EF440.9090902@jg555.com>
	<423EF764.1070305@jg555.com>
	<423F25AD.6030705@jg555.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 21 Mar 2005 11:51:09 -0800, Jim Gifford <maillist@jg555.com> said:
Jim>     Here are the warnings with ksym working.
...
Jim> epc   : 802849b0 preempt_schedule_irq+0xcc/0xd8     Not tainted
Jim> ra    : 80081338 ret_from_fork+0x0/0x8

Already fixed in CVS.

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-cvs-patches&i=aad20843b7b1d6b691c1401c495959a1%40NO-ID-FOUND.mhonarc.org
