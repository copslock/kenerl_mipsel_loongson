Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2008 17:31:24 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:36872 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20030855AbYELQbV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 May 2008 17:31:21 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id D354ED8E7; Mon, 12 May 2008 16:31:16 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id C2C33372609; Mon, 12 May 2008 18:31:07 +0200 (CEST)
Date:	Mon, 12 May 2008 18:31:07 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: Malta build errors with 2.6.26-rc1
Message-ID: <20080512163107.GA19052@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Some Malta build errors:

cc1: warnings being treated as errors
arch/mips/mips-boards/malta/malta_int.c: In function ‘gcmp_probe’:
arch/mips/mips-boards/malta/malta_int.c:408: warning: cast to pointer from integer of different size
arch/mips/mips-boards/malta/malta_int.c: In function ‘arch_init_irq’:
arch/mips/mips-boards/malta/malta_int.c:437: warning: cast to pointer from integer of different size
arch/mips/mips-boards/malta/malta_int.c:441: warning: cast to pointer from integer of different size
arch/mips/mips-boards/malta/malta_int.c: In function ‘malta_be_handler’:
arch/mips/mips-boards/malta/malta_int.c:656: warning: cast to pointer from integer of different size
arch/mips/mips-boards/malta/malta_int.c:657: warning: cast to pointer from integer of different size
arch/mips/mips-boards/malta/malta_int.c:658: warning: cast to pointer from integer of different size
arch/mips/mips-boards/malta/malta_int.c:704: warning: cast to pointer from integer of different size
make[5]: *** [arch/mips/mips-boards/malta/malta_int.o] Error 1

and:

arch/mips/mips-boards/generic/amon.c: In function ‘amon_cpu_avail’:
arch/mips/mips-boards/generic/amon.c:31: error: implicit declaration of function ‘KSEG0ADDR’
cc1: warnings being treated as errors
arch/mips/mips-boards/generic/amon.c:31: warning: cast to pointer from integer of different size
arch/mips/mips-boards/generic/amon.c: In function ‘amon_cpu_start’:
arch/mips/mips-boards/generic/amon.c:56: warning: cast to pointer from integer of different size
make[4]: *** [arch/mips/mips-boards/malta] Error 2

-- 
Martin Michlmayr
http://www.cyrius.com/
