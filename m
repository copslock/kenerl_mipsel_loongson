Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2007 07:40:34 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.190]:57099 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20023095AbXJLGk0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 12 Oct 2007 07:40:26 +0100
Received: by nf-out-0910.google.com with SMTP id c10so686947nfd
        for <linux-mips@linux-mips.org>; Thu, 11 Oct 2007 23:40:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        bh=Z7bI7llkjSd6l7KuKOiqUJCbfP553u8g+BtxxwvLXbs=;
        b=MJr1jLmalY8f+pfxEO/5GDSlfenCzLiZp4mQoGTNfJSlzEAtfLwjFMAH4r8Mazfy403pDbKc2hU/WRAt9rfw+aGkb5yv4i08TGLghG0Ew3yMvOWZlL3kEK4grOpuPINkR1UrceMG+WbNPW81vNoi0u4FoYOHDIzLWpNG/Ges5yk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=qSF721DJK/dcXKeVPZ5uXFIqSiQlGg1QJlD8pfg4nZ8QYfbo4IJQLSUsmY3a5LTk2EWAOfkW77TxzsZDgno2zPJbz1Y5FiSYKTGc000OL3fHmNLzRbKpGnuopM73Y4gjH7ou7hmRsHluQssLnJ9w6gwgf/yC8XO5Xla/yIWtO3E=
Received: by 10.86.89.4 with SMTP id m4mr2130610fgb.1192171225774;
        Thu, 11 Oct 2007 23:40:25 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id p9sm605317fkb.2007.10.11.23.40.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Oct 2007 23:40:25 -0700 (PDT)
Message-ID: <470F16B9.7030406@gmail.com>
Date:	Fri, 12 Oct 2007 08:39:53 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 0/4] Cleanup tlbex.c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf,

This patchset does some trivial clean up in tlbex.c only. It doesn't
optimize the code size, that should be done later after sorting out
the .init.bss stuff.

Please consider,

		Franck
---

 arch/mips/mm/tlbex.c |  197 ++++++++++++++++++++------------------------------
 1 files changed, 77 insertions(+), 120 deletions(-)
