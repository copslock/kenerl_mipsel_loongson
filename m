Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Feb 2007 20:53:30 +0000 (GMT)
Received: from jg555.com ([216.66.227.242]:16565 "EHLO jg555.com")
	by ftp.linux-mips.org with ESMTP id S28576257AbXBXUx2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 24 Feb 2007 20:53:28 +0000
Received: from [192.168.55.157] ([::ffff:192.168.55.157])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Sat, 24 Feb 2007 12:52:26 -0800
  id 002DC567.45E0A58A.00006125
Message-ID: <45E0A57F.4020304@jg555.com>
Date:	Sat, 24 Feb 2007 12:52:15 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Building 2.6.20.1 from source
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

    Trying to build the current 2.6.20.1 on my cobalt. I get this error. 
I have disabled epoll in the config, but still not compiling. Any 
suggestions.

arch/mips/lib-64/dump_tlb.c: In function 'msk2str':
arch/mips/lib-64/dump_tlb.c:34: warning: control reaches end of non-void 
function
  LD      arch/mips/lib-64/built-in.o
  AS      arch/mips/lib-64/memset.o
  AS      arch/mips/lib-64/watch.o
  AR      arch/mips/lib-64/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/mips/kernel/built-in.o: In function `sys_call_table':
arch/mips/kernel/scall64-64.S:(.text+0x9ef8): undefined reference to 
`compat_sys_epoll_pwait'
make: *** [.tmp_vmlinux1] Error 1
