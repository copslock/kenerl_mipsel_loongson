Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2003 08:14:25 +0000 (GMT)
Received: from [IPv6:::ffff:133.36.48.43] ([IPv6:::ffff:133.36.48.43]:64936
	"EHLO cat.os-omicron.org") by linux-mips.org with ESMTP
	id <S8225251AbTCDIOY>; Tue, 4 Mar 2003 08:14:24 +0000
Received: from wl04.sys.cs.tuat.ac.jp (pisces.sys.cs.tuat.ac.jp [165.93.162.82])
	by cat.os-omicron.org (Postfix) with SMTP id EBDECA4E7
	for <linux-mips@linux-mips.org>; Tue,  4 Mar 2003 17:16:16 +0900 (JST)
Date: Tue, 4 Mar 2003 17:13:40 +0900
From: TAKANO Ryousei <takano@os-omicron.org>
To: linux-mips@linux-mips.org
Subject: Re: JVM under Linux on MIPS
Message-Id: <20030304171340.1a9af44d.takano@os-omicron.org>
In-Reply-To: <20030304011459.457.qmail@web13302.mail.yahoo.com>
References: <20030302121820.A30790@linux-mips.org>
	<20030304011459.457.qmail@web13302.mail.yahoo.com>
Organization: OS/omicron Project
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-vine-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <takano@os-omicron.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: takano@os-omicron.org
Precedence: bulk
X-list: linux-mips

Hi,

On Mon, 3 Mar 2003 17:14:59 -0800 (PST)
Rajesh Palani <rpalani2@yahoo.com> wrote:
>    Has anyone had any success running any open source JVMs (other than Cobalt machines running Transvirtual's Kaffe) under Linux/MIPS.
>

I have succeeded in running Kaffe 1.0.7 with --with-engine=jit3
on a TANBAC TB0193 board (VR4181/66MHz).
However, it was very poor performance. A hello world execution,
for example, takes about 30 seconds.
I think that a JIT initialization has taken a lot of time.

Thanks,
TAKANO Ryousei
