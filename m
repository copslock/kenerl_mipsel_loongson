Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Nov 2007 06:16:35 +0000 (GMT)
Received: from smtp2.linux-foundation.org ([207.189.120.14]:20615 "EHLO
	smtp2.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S20025582AbXK1GQZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Nov 2007 06:16:25 +0000
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAS6GEuk005723
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 27 Nov 2007 22:16:17 -0800
Received: from box (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id lAS6GDIP019123;
	Tue, 27 Nov 2007 22:16:14 -0800
Date:	Tue, 27 Nov 2007 22:16:13 -0800
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: mips build breakage in current mainline
Message-Id: <20071127221613.79038e51.akpm@linux-foundation.org>
X-Mailer: Sylpheed 2.4.1 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips


allmodconfig...

arch/mips/kernel/csrc-r4k.c:9: error: syntax error before "c0_hpt_read"
arch/mips/kernel/csrc-r4k.c:10: warning: return type defaults to `int'
arch/mips/kernel/csrc-r4k.c: In function `c0_hpt_read':
arch/mips/kernel/csrc-r4k.c:11: error: implicit declaration of function `read_c0_count'
arch/mips/kernel/csrc-r4k.c: At top level:
arch/mips/kernel/csrc-r4k.c:14: error: variable `clocksource_mips' has initializer but incomplete type
arch/mips/kernel/csrc-r4k.c:15: error: unknown field `name' specified in initializer
arch/mips/kernel/csrc-r4k.c:15: warning: excess elements in struct initializer
arch/mips/kernel/csrc-r4k.c:15: warning: (near initialization for `clocksource_mips')
arch/mips/kernel/csrc-r4k.c:16: error: unknown field `read' specified in initializer
arch/mips/kernel/csrc-r4k.c:16: warning: excess elements in struct initializer
arch/mips/kernel/csrc-r4k.c:16: warning: (near initialization for `clocksource_mips')
arch/mips/kernel/csrc-r4k.c:17: error: unknown field `mask' specified in initializer
arch/mips/kernel/csrc-r4k.c:17: error: implicit declaration of function `CLOCKSOURCE_MASK'
arch/mips/kernel/csrc-r4k.c:17: warning: excess elements in struct initializer
arch/mips/kernel/csrc-r4k.c:17: warning: (near initialization for `clocksource_mips')
arch/mips/kernel/csrc-r4k.c:18: error: unknown field `flags' specified in initializer
arch/mips/kernel/csrc-r4k.c:18: error: `CLOCK_SOURCE_IS_CONTINUOUS' undeclared here (not in a function)
arch/mips/kernel/csrc-r4k.c:18: warning: excess elements in struct initializer
arch/mips/kernel/csrc-r4k.c:18: warning: (near initialization for `clocksource_mips')
arch/mips/kernel/csrc-r4k.c:21: error: syntax error before "init_mips_clocksource"
arch/mips/kernel/csrc-r4k.c:22: warning: return type defaults to `int'
arch/mips/kernel/csrc-r4k.c: In function `init_mips_clocksource':
arch/mips/kernel/csrc-r4k.c:24: error: invalid use of undefined type `struct clocksource'
arch/mips/kernel/csrc-r4k.c:24: error: `mips_hpt_frequency' undeclared (first use in this function)
arch/mips/kernel/csrc-r4k.c:24: error: (Each undeclared identifier is reported only once
arch/mips/kernel/csrc-r4k.c:24: error: for each function it appears in.)
arch/mips/kernel/csrc-r4k.c:26: error: implicit declaration of function `clocksource_set_clock'
arch/mips/kernel/csrc-r4k.c:28: error: implicit declaration of function `clocksource_register'
arch/mips/kernel/csrc-r4k.c: At top level:
arch/mips/kernel/csrc-r4k.c:14: error: storage size of `clocksource_mips' isn't known
make[1]: *** [arch/mips/kernel/csrc-r4k.o] Error 1
make: *** [arch/mips/kernel/csrc-r4k.o] Error 2
