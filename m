Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jan 2007 17:43:52 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.187]:3897 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S28574360AbXAHRmt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Jan 2007 17:42:49 +0000
Received: by nf-out-0910.google.com with SMTP id l24so8744174nfc
        for <linux-mips@linux-mips.org>; Mon, 08 Jan 2007 09:42:49 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:date:message-id:x-mailer:from;
        b=hecV1tXDhT1/GmTMKWLVJcZs0yN9klVD22hrdTAiHkJRsvinANm1vypNTGOfHG1kVimE/5QsZCBFQDBMm3naHqTrtBn5LSxroL5ibX+CZrC5YEuWOTn1/otQq2lb7K0o1gQO6bHijKze44KqK7HUQ8fETUz7Yk1wzLBLsG7L1tg=
Received: by 10.49.107.8 with SMTP id j8mr17910946nfm.1168278166576;
        Mon, 08 Jan 2007 09:42:46 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id k23sm107815220nfc.2007.01.08.09.42.45;
        Mon, 08 Jan 2007 09:42:46 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 806C723F76A; Mon,  8 Jan 2007 18:44:52 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 0/2] FLATMEM: allow memory to start at pfn != 0
Date:	Mon,  8 Jan 2007 18:44:50 +0100
Message-Id: <11682782923799-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf,

I'm resending this patchset with almost no change. The only one
made is in patch #1 in paging_init() when CONFIG_ISA is set.

I know that you encountered some issues when using malta config. It
seems that this platform uses HIGHMEM but no ISA config. So this new
patchset shouldn't fix anything for you, but I need more info to
debug it.

Could you give a try to patch #1 _only_ and give me the console
output ? That would be really nice.

Thanks
		Franck
