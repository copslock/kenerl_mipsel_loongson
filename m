Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jan 2005 07:56:39 +0000 (GMT)
Received: from imfep01.dion.ne.jp ([IPv6:::ffff:210.174.120.145]:21306 "EHLO
	imfep01.dion.ne.jp") by linux-mips.org with ESMTP
	id <S8224925AbVAEH4e>; Wed, 5 Jan 2005 07:56:34 +0000
Received: from webmail.dion.ne.jp ([210.196.2.172]) by imfep01.dion.ne.jp
          (InterMail vM.4.01.03.31 201-229-121-131-20020322) with SMTP
          id <20050105075620.MGUD1125.imfep01.dion.ne.jp@webmail.dion.ne.jp>;
          Wed, 5 Jan 2005 16:56:20 +0900
From: ichinoh@mb.neweb.ne.jp
To: linux-mips@linux-mips.org
Date: Wed, 05 Jan 2005 16:56:20 +0900
Message-Id: <1104911780.5055@157.120.127.3.DIONWebMail>
Subject: problem of cross compile 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
X-Mailer: DION Web mail version 1.03
X-Originating-IP: 157.120.127.3(*)
Return-Path: <ichinoh@mb.neweb.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ichinoh@mb.neweb.ne.jp
Precedence: bulk
X-list: linux-mips

Hi!

I have a question about cross compile(MIPS on REDHAT9).

The following message appeared when executing it after the program was crossing compiled. 

"bash: ./test cannot execute binary file"

Moreover, it becomes the following display in the file command. 

"test:ELF 32-bit LSB executable, no machine, version 1(SYSV), for GNU/Linux 2.4.17, dynamically linked (uses shared libs), stripped"

Have anyone encountered the same phenomenon?

Regards,
Nyauyama.
