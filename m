Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jul 2005 20:26:25 +0100 (BST)
Received: from rproxy.gmail.com ([IPv6:::ffff:64.233.170.203]:8546 "EHLO
	rproxy.gmail.com") by linux-mips.org with ESMTP id <S8225750AbVGZT0K> convert rfc822-to-8bit;
	Tue, 26 Jul 2005 20:26:10 +0100
Received: by rproxy.gmail.com with SMTP id c16so23957rne
        for <linux-mips@linux-mips.org>; Tue, 26 Jul 2005 12:28:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nh2TBhs49c58NNKiHDh6+Yu17jLXllVkR/lqJh37k4Zm6PTz27wchwNWkB8DOMSKxB6kaIgL8IT/kueJRuuCqECNwAnRkwxqBqdIoCBIagw4B5GpjAe/iShgCqwLCAfOyfoiUNatkWeJF5Q+uURmMS8MEFsKNe6xnbqWGUluT0c=
Received: by 10.38.9.1 with SMTP id 1mr61911rni;
        Tue, 26 Jul 2005 12:28:35 -0700 (PDT)
Received: by 10.39.1.62 with HTTP; Tue, 26 Jul 2005 12:28:35 -0700 (PDT)
Message-ID: <dbce930205072612285bd70e1b@mail.gmail.com>
Date:	Tue, 26 Jul 2005 15:28:35 -0400
From:	David Cummings <real.psyence@gmail.com>
Reply-To: David Cummings <real.psyence@gmail.com>
To:	linux-mips@linux-mips.org
Subject: o32 glibc-2.3.5
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <real.psyence@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: real.psyence@gmail.com
Precedence: bulk
X-list: linux-mips

hi, 
  Trying to compile glibc-2.3.5 for o32 patched with syscall, I get an
error for socket.S, socket/recv.o. This is the exact same error
mentioned on this list last month. In that thread there was reference
to a patch by Richard sandiford. This is with gcc-3.4.4. If anyone
knows where I can find said patch, and if that'll fix my problem, I'd
greatly appreciate it. I've been looking in glibc's bugzilla but can't
find the right bug. Thanks!
-Dave
-- 
The way that can be named is not the Way.
