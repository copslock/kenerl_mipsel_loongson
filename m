Received:  by oss.sgi.com id <S553728AbRAUB5w>;
	Sat, 20 Jan 2001 17:57:52 -0800
Received: from [12.44.186.158] ([12.44.186.158]:45052 "EHLO hermes.mvista.com")
	by oss.sgi.com with ESMTP id <S553719AbRAUB5b>;
	Sat, 20 Jan 2001 17:57:31 -0800
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f0L1sXI13030
	for <linux-mips@oss.sgi.com>; Sat, 20 Jan 2001 17:54:33 -0800
Message-ID: <3A6A422B.C0EDABD5@mvista.com>
Date:   Sat, 20 Jan 2001 17:58:03 -0800
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: bg, en
MIME-Version: 1.0
To:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: test9 problems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


I've got a 5231-based board running a test9-ish kernel. The board is
quite stable and I don't have any problems using the serial console,
running Bonnie, etc.  However, when I enable a virtual terminal and ps2
keyboard, I have problems running commands at the virt terminal.  I
traced it to the init task seg faulting and getting killed by the
kernel, which in turn kills my system. One of the easiest way to
reproduce this problem is to try filename completion, such as "ls
/etc/nss <tab>" -- hangs just about all the time.  Has anyone else
experienced similar problems with any other mips workstation/board?

Pete
