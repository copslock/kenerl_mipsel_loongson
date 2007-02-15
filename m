Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2007 01:47:51 +0000 (GMT)
Received: from py-out-1112.google.com ([64.233.166.177]:58980 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20039612AbXBOBrq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Feb 2007 01:47:46 +0000
Received: by py-out-1112.google.com with SMTP id u52so177306pyb
        for <linux-mips@linux-mips.org>; Wed, 14 Feb 2007 17:46:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:thread-index:x-mimeole;
        b=N7aZu8iMrN1fslamiPTY7/9y33Z2aERkQlmFxqNq8UVjKgZU9HQHhzgijv8tGh/tJQdX3o+Yr/4CsKTiLdCu2ij9O6fHPF1QlpzKjL+4enrV6BUx2Ri1ZjVqc6xx/va9WJqsruZz9XK0c6NqG0Mv2h6mgB0mCK9oVxJzift5coI=
Received: by 10.35.96.11 with SMTP id y11mr2183451pyl.1171504004210;
        Wed, 14 Feb 2007 17:46:44 -0800 (PST)
Received: from barrioswindows ( [210.94.41.89])
        by mx.google.com with ESMTP id v15sm1982342pyh.2007.02.14.17.46.42;
        Wed, 14 Feb 2007 17:46:43 -0800 (PST)
From:	=?ks_c_5601-1987?B?sei5zsL5?= <barrioskmc@gmail.com>
To:	<linux-mips@linux-mips.org>
Subject: Who know latest Linux/MIPS ABI ?
Date:	Thu, 15 Feb 2007 10:46:39 +0900
Message-ID: <000701c750a3$24ecf9b0$8aab580a@swcenter.sec.samsung.co.kr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcdNh6W+t9WKjDKCRnu/wrGp7uYg0QCZh/TwAC1SM/A=
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Return-Path: <barrioskmc@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: barrioskmc@gmail.com
Precedence: bulk
X-list: linux-mips


I want to know ELF format well in MIPS architecture. 
But in case of elf spec document on net, it had explained about i386. so I
can't find specific sections about MIPS ELF. For example, Sections
(.MIPS.stubs, .jcr, .pdr ) and so on.

There is a MIPS ABI document in linux-mips.org. But it is very obsolete. As
I know, any vendor don't use obsolete system V ABI. Currently, Is any ABI
using o32 or n32 and so on. 

I hope I get a latest MIPS ABI and ELF Spec on Linux/MIPS. 
Who know where I get it?

Thanks in advance.
