Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2005 18:04:35 +0100 (BST)
Received: from 64-30-195-78.dsl.linkline.com ([IPv6:::ffff:64.30.195.78]:24978
	"EHLO jg555.com") by linux-mips.org with ESMTP id <S8226126AbVDKRET>;
	Mon, 11 Apr 2005 18:04:19 +0100
Received: from [172.16.0.55] ([::ffff:172.16.0.55])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Mon, 11 Apr 2005 10:04:15 -0700
  id 001E0181.425AAE0F.0000412E
Message-ID: <425AAE00.9080406@jg555.com>
Date:	Mon, 11 Apr 2005 10:04:00 -0700
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Daniel Laird <danieljlaird@hotmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Building Glibc-2.3.4 for mipsel
References: <BAY101-F34FE6C8FFEB4555FB1EE0BDC320@phx.gbl>
In-Reply-To: <BAY101-F34FE6C8FFEB4555FB1EE0BDC320@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Daniel,
   I have gotten this to work, using my build method from LFS. There are 
a few patches needed, here is my information about the patches location.

http://documents.jg555.com/lfs-raq2
http://documents.jg555.com/lfs-raq2/chapter03/patches.html

The patches in particular are

http://www.linuxfromscratch.org/patches/downloads/linux-libc-headers/linux-libc-headers-2.6.11.2-mips_fix-1.patch 

This fixes a compile issue with sysklogd

http://www.linuxfromscratch.org/patches/downloads/glibc/glibc-2.3.4-mips_syscall-2.patch
Fixes various syscall issues


-- 
----
Jim Gifford
maillist@jg555.com
