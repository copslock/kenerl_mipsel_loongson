Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Feb 2006 18:12:55 +0000 (GMT)
Received: from networks.syneticon.net ([213.239.212.131]:60305 "EHLO
	mail2.syneticon.net") by ftp.linux-mips.org with ESMTP
	id S8133444AbWBLSMq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 12 Feb 2006 18:12:46 +0000
Received: from localhost (localhost [127.0.0.1])
	by mail2.syneticon.net (Postfix) with ESMTP id 7C2F83D875
	for <linux-mips@linux-mips.org>; Sun, 12 Feb 2006 19:18:53 +0100 (CET)
Received: from mail2.syneticon.net ([127.0.0.1])
 by localhost (linux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02483-14 for <linux-mips@linux-mips.org>;
 Sun, 12 Feb 2006 19:18:48 +0100 (CET)
Received: from [84.44.217.177] (xdsl-84-44-217-177.netcologne.de [84.44.217.177])
	by mail2.syneticon.net (Postfix) with ESMTP
	for <linux-mips@linux-mips.org>; Sun, 12 Feb 2006 19:18:48 +0100 (CET)
Message-ID: <43EF7C06.3080006@wpkg.org>
Date:	Sun, 12 Feb 2006 19:18:46 +0100
From:	Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Mail/News 1.5 (X11/20060210)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: native gcc for mipsel / uClibc (building or binaries)?
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: amavisd-new at syneticon.de
Return-Path: <mangoo@wpkg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mangoo@wpkg.org
Precedence: bulk
X-list: linux-mips

I'm trying to cross-compile gcc to work on mipsel / uClibc, to run there 
natively (that is, I want to compile on this mipsel / uClibc machine).

So far I have a cross compiler that builds binaries for mipsel/uClibc on 
a x86 machine.


According to crosstool HOWTO, "to do a Canadian Cross build with 
crosstool, you have to run it three times:

    1. once to build a toolchain that runs on the build system and 
generates code for the host system
    2. once to build a toolchain that runs on the build system and 
generates code for the target system
    3. once to build a toolchain that runs on the host system and 
generates code for the target system".

So I guess the first step is behind me, but I'm not sure how to do steps 
2 and 3.

Anyone knows how to do it?
Or perhaps, there are already gcc binaries available for mipsel / uClibc?

-- 
Tomasz Chmielewski
Software deployment with Samba
http://wpkg.org
