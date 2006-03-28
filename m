Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Mar 2006 21:28:47 +0100 (BST)
Received: from baldrick.bootc.net ([83.142.228.48]:22492 "EHLO
	baldrick.bootc.net") by ftp.linux-mips.org with ESMTP
	id S8133559AbWC1U2h (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Mar 2006 21:28:37 +0100
Received: from [192.168.1.3] (cpc3-hudd6-0-0-cust471.hudd.cable.ntl.com [86.3.1.216])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by baldrick.bootc.net (Postfix) with ESMTP id 930821400BE9
	for <linux-mips@linux-mips.org>; Tue, 28 Mar 2006 21:39:03 +0100 (BST)
Message-ID: <44299EE6.7010309@bootc.net>
Date:	Tue, 28 Mar 2006 21:39:02 +0100
From:	Chris Boot <bootc@bootc.net>
User-Agent: Thunderbird 1.5 (X11/20060309)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Emulating MIPS -- please help!
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at bootc.plus.com
Return-Path: <bootc@bootc.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bootc@bootc.net
Precedence: bulk
X-list: linux-mips

Hi all,

I'm desperately trying to get a MIPS emulator running Linux, and while 
I've managed to get gxemul and (I think) qemu running, I can't for the 
life of me get them to (1) output anything or (2) use an initrd.

Can anyone post some instructions and, perhaps, a .config for 2.6.16 so 
I can get some output like kernel boot messages and a login screen?

I've got gxemul emulating code and running a kernel, which I can test by 
stopping emulation and stepping the code. Qemu seems to boot my 
qemu-specific kernel but I get no output and qemu appears to hang (won't 
take keyboard input). I can't seem to get either emulator to load my 
initrd, but that doesn't really matter at this stage since I can't see 
anything anyway (I have no idea how to using gxemul, and qemu refuses to 
load the image).

Something that could emulate a NEC VR41xx chip would be icing on the 
cake, but I'll take anything I can get at this stage.

Many thanks in advance,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
