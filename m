Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fACIpOE03169
	for linux-mips-outgoing; Mon, 12 Nov 2001 10:51:24 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fACIpL003166
	for <linux-mips@oss.sgi.com>; Mon, 12 Nov 2001 10:51:21 -0800
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fACIqcB12961;
	Mon, 12 Nov 2001 10:52:38 -0800
Subject: compiler problem
From: Pete Popov <ppopov@mvista.com>
To: linux-mips <linux-mips@oss.sgi.com>,
   sforge
	 <linux-mips-kernel@lists.sourceforge.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.07.16.47 (Preview Release)
Date: 12 Nov 2001 10:53:36 -0800
Message-Id: <1005591216.470.20.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I'm running into this problem when using the oss.sgi.com toolchain:

mips-linux-gcc -D__ASSEMBLY__ -D__KERNEL__
-I/home/ppopov/workdir/master/sforge/linux-dev/include -G 0
-mno-abicalls -fno-pic -mcpu=r5000 -mips2 -Wa,--trap -pipe -c entry.S -o
entry.o
entry.S: Assembler messages:
entry.S:180: Error: .previous without corresponding .section; ignored
make[1]: *** [entry.o] Error 1
make[1]: Leaving directory
`/home/ppopov/workdir/master/sforge/linux-dev/arch/mips/kernel'
make: *** [_dir_arch/mips/kernel] Error 2
[ppopov@zeus linux-dev]$ 


What's the recommended oss binutils version?

Pete
