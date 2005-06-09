Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2005 14:00:50 +0100 (BST)
Received: from zproxy.gmail.com ([IPv6:::ffff:64.233.162.205]:21885 "EHLO
	zproxy.gmail.com") by linux-mips.org with ESMTP id <S8225609AbVFINAf> convert rfc822-to-8bit;
	Thu, 9 Jun 2005 14:00:35 +0100
Received: by zproxy.gmail.com with SMTP id 13so145381nzp
        for <linux-mips@linux-mips.org>; Thu, 09 Jun 2005 06:00:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EZEf6e5Bm4UrkVqKx+Sz67xDOshjrMN5Opm24C4ecjwQfW4YK9+LDouJF0Juv/lTiengeQgcafUnC6tXuOT65TeJlJeOJ9GJGVe2PFPIGyyc4iz7S7HXyxynlK2s2vDXwjxR4CCLgxvFAbbPtP0kX82htPPYtBHrG13Q3lFDQyg=
Received: by 10.36.222.24 with SMTP id u24mr411396nzg;
        Thu, 09 Jun 2005 06:00:22 -0700 (PDT)
Received: by 10.36.68.6 with HTTP; Thu, 9 Jun 2005 06:00:22 -0700 (PDT)
Message-ID: <6097c4905060906003ca15ec@mail.gmail.com>
Date:	Thu, 9 Jun 2005 17:00:22 +0400
From:	Maxim Osipov <maxim.osipov@gmail.com>
Reply-To: maxim@mox.ru
To:	linux-mips@linux-mips.org
Subject: gdb problem
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <maxim.osipov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maxim.osipov@gmail.com
Precedence: bulk
X-list: linux-mips

Hello,

Probably a little off-topic here, but do anyone have a recipe to get
remote debugging with gdb + gdbserver working?

I have gdb-6.3 build for mips64-linux-gnu and when I try to connect
the following error appears:

/home/maxim # ./gdbserver 192.168.0.2:5339 /bin/busybox
Process /bin/busybox created; pid = 34
Listening on port 5339
Remote debugging from host 192.168.0.2
readchar: Got EOF
Remote side has terminated connection.  GDBserver will reopen the connection.
Listening on port 5339

(gdb) target remote 192.168.0.10:5339
Remote debugging using 192.168.0.10:5339
Couldn't establish connection to remote target
Reply contains invalid hex digit 59

Googling for similar problem shows, what some people also faced it,
but no solution.

Thank you,
Maxim
