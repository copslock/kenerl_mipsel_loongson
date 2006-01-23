Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 16:10:34 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:33550 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S3465582AbWAWQJa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jan 2006 16:09:30 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id CA3BC64D3D; Mon, 23 Jan 2006 16:13:38 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 0DA6586BB; Mon, 23 Jan 2006 16:13:29 +0000 (GMT)
Date:	Mon, 23 Jan 2006 16:13:29 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	MIPS Linux List <linux-mips@linux-mips.org>,
	Stuart Anderson <anderson@netsweng.com>,
	David Daney <ddaney@avtrex.com>
Subject: Re: Fixes for uaccess.h with gcc >= 4.0.1
Message-ID: <20060123161329.GC10742@deprecation.cyrius.com>
References: <20060123150507.GA18665@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060123150507.GA18665@linux-mips.org>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Ralf Baechle <ralf@linux-mips.org> [2006-01-23 15:05]:
> I'd appreciate if somebody with gcc 4.0.1 could test this kernel patch
> below.

I get the following warning that I didn't get with Stuart's patch but
apart from that it compiles and boots (Cobalt 64-bit kernel, 32-bit
userland).


  CC      arch/mips/kernel/linux32.o
arch/mips/kernel/linux32.c: In function ‘sysn32_rt_sigtimedwait’:
arch/mips/kernel/linux32.c:1464: warning: initialization discards qualifiers from pointer target type
arch/mips/kernel/linux32.c:1465: warning: initialization discards qualifiers from pointer target type
  CC      arch/mips/kernel/signal32.o

-- 
Martin Michlmayr
http://www.cyrius.com/
