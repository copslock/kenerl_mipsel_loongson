Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1I8xwM12794
	for linux-mips-outgoing; Mon, 18 Feb 2002 00:59:58 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1I8xr912786
	for <linux-mips@oss.sgi.com>; Mon, 18 Feb 2002 00:59:53 -0800
Message-Id: <200202180859.g1I8xr912786@oss.sgi.com>
Received: (qmail 4574 invoked from network); 18 Feb 2002 08:02:33 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 18 Feb 2002 08:02:33 -0000
Date: Mon, 18 Feb 2002 15:57:4 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
CC: "libc-alpha@sources.redhat.com" <libc-alpha@sources.redhat.com>,
   "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>
Subject: math broken on mips
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,
   There are so many problems on math handling for linux-mips,including:
1. SNaN & QNan handling(both gcc & glibc)
2. gcc2.96 generates wrong code with -O2,at least 
     one will lead to exception handling problem(reported by me)
     one will lead to some 'long long' type mishandling(reported by Atsushi Nemoto)

   (gcc3.1 seems a lot better,but it has problem to compile glibc.I can't even compile
 current glibc cvs code(with dl-conflict.c etc patched) with it. The best result is
 a segment fault when using ld.so.1:
      ../elf/ld.so.1 --library-path ..:../math:../elf:../dlfcn:../nss:../nis:../rt:../resolv:
  ../crypt:../linuxthreads ./rpcgen -Y ../scripts -c rpcsvc/bootparam_prot.x -o 
  xbootparam_prot.T
  make[1]: *** [xbootparam_prot.stmp] Segmentation fault
  )     
3. problems with math-emu
4. other problems to be investigated for its cause,including this one,
  
       pow(2,7) = 128.0 when rounding = TONEAREST or UPWARD
                = 64.1547.. when rounding = DOWNWARD or TOWARDZERO

 when today i find out the above problem I was feeling almost despaired:(

 I want to fix these problems,if i could.But it concerns so many things that i am not
 expert on and no time to dig:(. So any help will be highly appreciated.

 


Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
