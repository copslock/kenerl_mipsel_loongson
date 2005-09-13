Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2005 02:47:58 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:31267
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225319AbVIMBrl>; Tue, 13 Sep 2005 02:47:41 +0100
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 13 Sep 2005 01:49:14 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id CEAAA1F63F
	for <linux-mips@linux-mips.org>; Tue, 13 Sep 2005 10:49:11 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id C308A1F63C
	for <linux-mips@linux-mips.org>; Tue, 13 Sep 2005 10:49:11 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j8D1nBoj047382
	for <linux-mips@linux-mips.org>; Tue, 13 Sep 2005 10:49:11 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 13 Sep 2005 10:49:11 +0900 (JST)
Message-Id: <20050913.104911.75185617.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Subject: potential problem in au1000_generic.c
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 8917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

I found a potential probelm in au1x00_pcmcia_socket_probe().

This function roughly looks like:

int au1x00_pcmcia_socket_probe(struct device *dev, struct pcmcia_low_level *ops, int first, int nr)
{
...
	for (i = 0; i < nr; i++) {
		struct au1000_pcmcia_socket *skt = PCMCIA_SOCKET(i);
...
		ret = pcmcia_register_socket(&skt->socket);
		if (ret)
			goto out_err;
...
	}
...
	return 0;

	do {
		struct au1000_pcmcia_socket *skt = PCMCIA_SOCKET(i);
...
out_err:
...
		ops->hw_shutdown(skt);
		i--;
	} while (i > 0);
...
}

The 'out_err' path seems broken since 'skt' in for-loop and
do-while-loop are another variable.  The local variable 'skt' should
be declared outside those loop.

---
Atsushi Nemoto
