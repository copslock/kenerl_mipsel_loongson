Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3K5AxW09642
	for linux-mips-outgoing; Thu, 19 Apr 2001 22:10:59 -0700
Received: from mcp.csh.rit.edu (mcp.csh.rit.edu [129.21.60.9])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3K5AwM09639
	for <linux-mips@oss.sgi.com>; Thu, 19 Apr 2001 22:10:58 -0700
Received: from csh.rit.edu (anna.csh.rit.edu [129.21.60.133])
	by mcp.csh.rit.edu (Postfix) with ESMTP id 37134107E
	for <linux-mips@oss.sgi.com>; Fri, 20 Apr 2001 01:10:57 -0400 (EDT)
Message-ID: <3ADFC5C9.6060906@csh.rit.edu>
Date: Fri, 20 Apr 2001 01:14:49 -0400
From: "George Gensure,,," <werkt@csh.rit.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4-pre3 i686; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: glibc build
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I get the following error while trying to cross-build glibc for mips on 
an i686.  Can anyone give any insight?

../sysdeps/mips/setjmp.S: Assembler messages:
../sysdeps/mips/setjmp.S:43: Error: Can not represent 
BFD_RELOC_16_PCREL_S2 relocation in this object file format
make[2]: *** [/usr/local/crossbuild/glibc-build/setjmp/setjmp.o] Error 1
make[2]: Leaving directory `/usr/local/crossbuild/glibc-2.2/setjmp'
make[1]: *** [setjmp/subdir_lib] Error 2
make[1]: Leaving directory `/usr/local/crossbuild/glibc-2.2'
make: *** [install] Error 2

George
werkt@csh.rit.edu
