Received:  by oss.sgi.com id <S553829AbQJ0RYm>;
	Fri, 27 Oct 2000 10:24:42 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:17653 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553824AbQJ0RYe>;
	Fri, 27 Oct 2000 10:24:34 -0700
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e9RHMu311465
	for <linux-mips@oss.sgi.com>; Fri, 27 Oct 2000 10:22:56 -0700
Message-ID: <39F9B924.97AF7A4@mvista.com>
Date:   Fri, 27 Oct 2000 10:19:32 -0700
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: FATAL: cannot determine library version
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


I've got a big endian kernel running for a new embedded board, and it
mounts the root fs over nfs.  I'm using the simple-0.2b packages as the
root fs.  At some point after /bin/sh is loaded, I get the following
error:

FATAL: cannot determine library version

The same root file system is fine on my Indigo2.

Any clues?

Thanks,

Pete
