Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jan 2003 23:51:57 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:8904 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225989AbTACXv4>;
	Fri, 3 Jan 2003 23:51:56 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 9BA97D657; Sat,  4 Jan 2003 00:59:22 +0100 (CET)
To: Chien-Lung Wu <cwu@deltartp.com>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: glibc-2.2.5  configuration error (cross-compiler)
References: <A4E787A2467EF849B00585F14C9005590689BF@dprn03.deltartp.com>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <A4E787A2467EF849B00585F14C9005590689BF@dprn03.deltartp.com>
Date: 04 Jan 2003 00:59:22 +0100
Message-ID: <m27kdlbx9h.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "chien-lung" == Chien-Lung Wu <cwu@deltartp.com> writes:

Hi

chien-lung> As i compiled and install cross-compiler, I use the option
chien-lung> --prfix=/usr/xmips-1-3, that means I will
              ^^^^^
I guess prefix :)

chien-lung> install the cross-compiler in the directory /usr/xmips-1-3. And I also check
chien-lung> tools and mips-linux-gcc are on my cross-compiler directory
chien-lung> /usr/xmips-1-3/bin.

chien-lung> My question is why I got the message:
chien-lung> checking for mips-linux-gcc... no
chien-lung> checking for mips-linux-cc... no
chien-lung> And how can I set up path such that this configure can find them.

Are you sure that /usr/xmips-1-3/bin is in your path?

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
