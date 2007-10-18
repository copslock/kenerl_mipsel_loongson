Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Oct 2007 08:17:24 +0100 (BST)
Received: from fk-out-0910.google.com ([209.85.128.185]:25289 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20025806AbXJRHRP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Oct 2007 08:17:15 +0100
Received: by fk-out-0910.google.com with SMTP id f40so74206fka
        for <linux-mips@linux-mips.org>; Thu, 18 Oct 2007 00:12:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=OKzzsChmEgpQjbrNFghdkFXLV3oCogB4kjccVzc7MSw=;
        b=dLT02G2I95Rv23/jWnTm8jiK1TS8Le6F6cv48TfR/FeuyPlTJWmMxJy+D1IHiIZfbYMrWFcS5jwbxeWDloCZUmnmHGFgTQKwHv7P13Ww3MDGjeN+Fo02BwUE85Gbqh9Zkk+ELQz0Di36NL73sKPfphKBnviWwaCoD1Os6GyelPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=GVabKL48VMQK4lEJswfGLVJlqx2gJqo5M/ocGsNw0p+9vbNR9i20LfSNY9FNu2xR5kNLCoBMrSmqoxS48+T+6+4pQGT8SRyzlPyByzmfYoUvZwYU5LI+kpkBkURjbMpzfY3eXXZuEiAVVFyLcWLvqsyUY21+qorsJ5NgpC1iZ/I=
Received: by 10.82.182.1 with SMTP id e1mr395260buf.1192691548934;
        Thu, 18 Oct 2007 00:12:28 -0700 (PDT)
Received: from localhost ( [82.235.205.153])
        by mx.google.com with ESMTPS id e9sm1099026muf.2007.10.18.00.12.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Oct 2007 00:12:27 -0700 (PDT)
From:	Franck Bui-Huu <fbuihuu@gmail.com>
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ths@networkno.de, linux-mips@linux-mips.org
Subject: [PATCH 0/4] tlbex.c: trivial cleanup [take #2]
Date:	Thu, 18 Oct 2007 09:11:13 +0200
Message-Id: <1192691477-4675-1-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.3.4
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fbuihuu@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf,

I'm resending this patchset because this version fixes the
section mismatch warning noticed by Atsushi.

Moreover, Thiemo doesn't seem to be happy with the patch that
clean up the debug code. So it is now the last one of
the serie therfore you can easily drop it if you want to.

Thanks
		Franck

---

 arch/mips/mm/tlbex.c |  199 ++++++++++++++++++++------------------------------
 1 files changed, 78 insertions(+), 121 deletions(-)
