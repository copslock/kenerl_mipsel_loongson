Received:  by oss.sgi.com id <S554001AbQLASQV>;
	Fri, 1 Dec 2000 10:16:21 -0800
Received: from [206.207.108.63] ([206.207.108.63]:12661 "HELO
        ridgerun-lx.ridgerun.cxm") by oss.sgi.com with SMTP
	id <S553995AbQLASQB>; Fri, 1 Dec 2000 10:16:01 -0800
Received: (qmail 21981 invoked from network); 1 Dec 2000 11:15:50 -0700
Received: from gmcnutt-lx.ridgerun.cxm (HELO ridgerun.com) (gmcnutt@192.168.1.17)
  by ridgerun-lx.ridgerun.cxm with SMTP; 1 Dec 2000 11:15:50 -0700
Message-ID: <3A27EAD6.83E03DFB@ridgerun.com>
Date:   Fri, 01 Dec 2000 11:15:50 -0700
From:   Gordon McNutt <gmcnutt@ridgerun.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     linux-mips@oss.sgi.com
Subject: console knowledge
References: <001901c05b67$8c88ab60$0deca8c0@Ulysses> <XFMail.001201163348.Harald.Koerfgen@home.ivm.de> <20001201185321.A3211@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a little off-topic, so if people complain I can take it offline. But
since this doesn't seem to be (very) common knowledge maybe others would like to
see it, as well.

Ralf Baechle wrote:

> /dev/console (as chardev 5/1) differs from another device in some important
> ways:
>
>  - When opened by a process without controlling tty it will not become a
>    CTTY even if the NOCTTY flag is not set.

What do you mean by "controlling tty"? And why is the distinction noted above
important? I assume it has something to do with keyboard input/screen output, but
perhaps you can clarify.

Thanks,

--Gordon
