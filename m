Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2N4k4204938
	for linux-mips-outgoing; Fri, 22 Mar 2002 20:46:04 -0800
Received: from paul.rutgers.edu (paul.rutgers.edu [128.6.5.53])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2N4jtq04935
	for <linux-mips@oss.sgi.com>; Fri, 22 Mar 2002 20:45:55 -0800
Received: (from muthur@localhost)
	by paul.rutgers.edu (8.10.2+Sun/8.8.8) id g2N4mIg06476;
	Fri, 22 Mar 2002 23:48:18 -0500 (EST)
Date: Fri, 22 Mar 2002 23:48:18 -0500 (EST)
From: Muthukumar Ratty <muthur@paul.rutgers.edu>
To: linux-mips@oss.sgi.com
Subject: Lost when execve-ing the init.
Message-ID: <Pine.SOL.4.10.10203212243150.12256-100000@paul.rutgers.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi,
I was trying a kernel I made and found that I got lost after it goes to
execve("/sbin/init") in init/main.c. I can ping the board which means the
board is alive. I tried to trace it down but got stuck with the following
code in "include/asm-mips/unistd.h" [ I believe it implements 
the execve function since in the same file I have .....
static inline _syscall3(int,execve,const char *,file,char **,argv,char
**,envp)] 

------------------------------------------------------------------------------

#define _syscall3(type,name,atype,a,btype,b,ctype,c) \
type name (atype a, btype b, ctype c) \
{ \
long __res, __err; \
__asm__ volatile ("move\t$4,%3\n\t" \
                  "move\t$5,%4\n\t" \
                  "move\t$6,%5\n\t" \
                  "li\t$2,%2\n\t" \
                  "syscall\n\t" \
                  "move\t%0, $2\n\t" \
                  "move\t%1, $7" \
                  : "=r" (__res), "=r" (__err) \
                  : "i" (__NR_##name),"r" ((long)(a)), \
                                      "r" ((long)(b)), \
                                      "r" ((long)(c)) \
                  : "$2","$4","$5","$6","$7","$8","$9","$10","$11","$12",
\
                    "$13","$14","$15","$24"); \
if (__err == 0) \
        return (type) __res; \
errno = __res; \
return -1; \
}
---------------------------------------------------------------------------

I guess...
After setting up the arguments its referencing (#defined ???) syscall. I
couldnt find the definition for "syscall". Could someone point me to the 
right place (and help me get some sleep please ;). Also any idea about how
to debug this. (Can I set breakpoint in syscall3??). (Any idea why its not
going.. error in my irq setup??...)

Thanks a lot,
Muthu.

PS : what does this funny thing mean???

   : "=r" (__res), "=r" (__err) \
                  : "i" (__NR_##name),"r" ((long)(a)), \
                                      "r" ((long)(b)), \
                                      "r" ((long)(c)) \
                  : "$2","$4","$5","$6","$7","$8","$9","$10","$11","$12",
\
                    "$13","$14","$15","$24"); \
if (__err == 0) \
 
