Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Nov 2007 13:02:34 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:63755 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20032878AbXKYNC0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 25 Nov 2007 13:02:26 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 5EA1CD8E5; Sun, 25 Nov 2007 13:01:49 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 32A69544F2; Sun, 25 Nov 2007 14:01:35 +0100 (CET)
Date:	Sun, 25 Nov 2007 14:01:35 +0100
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Cc:	manoj.ekbote@broadcom.com, mark.e.mason@broadcom.com
Subject: Re: BigSur: oops loading ramdisk
Message-ID: <20071125130135.GM20922@deprecation.cyrius.com>
References: <20071125125229.GJ20922@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071125125229.GJ20922@deprecation.cyrius.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Martin Michlmayr <tbm@cyrius.com> [2007-11-25 13:52]:
> With a 32 bit kernel (current git) on BigSur, I get an oops while
> trying to load the ramdisk:

With a 64 bit kernel I get:

RAMDISK: Compressed image found at block 0
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 144k freed
Warning: unable to open an initial console.
Error -3 while decompressing!
ffffffff804f2028(7120)->a800000000516000(4096)
Error -3 while decompressing!
ffffffff804f1280(7026)->a800000000515000(4096)
request_module: runaway loop modprobe binfmt-0000
request_module: runaway loop modprobe binfmt-0000
request_module: runaway loop modprobe binfmt-0000
request_module: runaway loop modprobe binfmt-0000
request_module: runaway loop modprobe binfmt-0000

I have the following in my .config:

CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
CONFIG_MIPS32_COMPAT=y
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_MIPS32_O32=y
CONFIG_MIPS32_N32=y
CONFIG_BINFMT_ELF32=y

With 2.6.22 (64 bit) I get:

Linux version 2.6.22-3-sb1a-bcm91480b (Debian 2.6.22-6) (maks@debian.org) (gcc version 4.1.3 20071019 (prerelease) (Debian 4.1.2-17)) #1 SMP Thu Nov 15 10:51:13 UTC 2007
...
RAMDISK: Compressed image found at block 0
VFS: Mounted root (cramfs filesystem) readonly.
[ delay of a few seconds here -- tbm ]
[DL2?]
[DL2D]
[DC ?]
[DC D]
[HELO]
[L1CI]
[L2CI]
[CPU3]
[cpu3]
[CPU2]
[cpu2]
...

-- 
Martin Michlmayr
http://www.cyrius.com/
