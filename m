Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g46ChQwJ016140
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 6 May 2002 05:43:26 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g46ChQ7L016139
	for linux-mips-outgoing; Mon, 6 May 2002 05:43:26 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from coplin19.mips.com ([80.63.7.130])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g46ChLwJ016136
	for <linux-mips@oss.sgi.com>; Mon, 6 May 2002 05:43:22 -0700
Received: from localhost (kjelde@localhost)
	by coplin19.mips.com (8.11.6/8.11.6) with ESMTP id g46CiXw21717
	for <linux-mips@oss.sgi.com>; Mon, 6 May 2002 14:44:33 +0200
X-Authentication-Warning: coplin19.mips.com: kjelde owned process doing -bs
Date: Mon, 6 May 2002 14:44:33 +0200 (CEST)
From: Kjeld Borch Egevang <kjelde@mips.com>
To: linux-mips mailing list <linux-mips@oss.sgi.com>
Subject: zsh on console
Message-ID: <Pine.LNX.4.44.0205061440210.21711-100000@coplin19.mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

When I run zsh on the console (serial interface) the process hangs. I can 
login with /bin/bash, but when I start /bin/zsh it waits forever. I can 
interrupt the process and regain control.

It's only related to the console. If I login with telnet it works just 
fine.

Any idea, what could be wrong?


/Kjeld

-- 
_    _ ____  ___                       Mailto:kjelde@mips.com
|\  /|||___)(___    MIPS Denmark       Direct: +45 44 86 55 85
| \/ |||    ____)   Lautrupvang 4 B    Switch: +45 44 86 55 55
  TECHNOLOGIES      DK-2750 Ballerup   Fax...: +45 44 86 55 56
                    Denmark            http://www.mips.com/
