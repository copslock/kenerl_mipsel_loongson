Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7G8wLRw013658
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 16 Aug 2002 01:58:21 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7G8wK9R013657
	for linux-mips-outgoing; Fri, 16 Aug 2002 01:58:20 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7G8wBRw013638
	for <linux-mips@oss.sgi.com>; Fri, 16 Aug 2002 01:58:11 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g7G90eXb018654
	for <linux-mips@oss.sgi.com>; Fri, 16 Aug 2002 02:00:40 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id CAA12088
	for <linux-mips@oss.sgi.com>; Fri, 16 Aug 2002 02:00:43 -0700 (PDT)
Received: from coplin19.mips.com (IDENT:root@coplin19 [192.168.205.89])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g7G90hb00902
	for <linux-mips@oss.sgi.com>; Fri, 16 Aug 2002 11:00:43 +0200 (MEST)
Received: from localhost (kjelde@localhost)
	by coplin19.mips.com (8.11.6/8.11.6) with ESMTP id g7G90ht08462
	for <linux-mips@oss.sgi.com>; Fri, 16 Aug 2002 11:00:43 +0200
X-Authentication-Warning: coplin19.mips.com: kjelde owned process doing -bs
Date: Fri, 16 Aug 2002 11:00:43 +0200 (MEST)
From: Kjeld Borch Egevang <kjelde@mips.com>
To: linux-mips mailing list <linux-mips@oss.sgi.com>
Subject: Re: N32 support in 64-bit MIPS Linux
In-Reply-To: <20020815181952.B10199@linux-mips.org>
Message-ID: <Pine.LNX.4.44.0208161029590.8380-100000@coplin19.mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 15 Aug 2002, Ralf Baechle wrote:

> On Thu, Aug 15, 2002 at 12:06:31PM +0200, Kjeld Borch Egevang wrote:
> 
> > I would like to hear your opinion on this.
> > 
> > Currently we have the N64 interface which is the basic interface to the
> > kernel. Then we have the O32 interface which is implemented as a separate
> > set of syscalls in unistd.h and proper conversion in the kernel.
> > 
> > Now, how can we support N32? Many syscalls will work if N32 is treated the
> > same way as O32. This will of course mean, that O32 must be compiled in in
> > order to support N32. But e.g. a syscall like:
> > 
> > int _llseek(unsigned int fd, unsigned long offset_high, unsigned long 
> > offset_low, loff_t *result, unsigned int whence);
> > 
> > needs special treatment since loff_t is a long long (passed in a single
> > register for N32) and there are 6 arguments (all passed in registers for
> > N32, passed in registers and on the stack for O32).
> > 
> > Should we simply add 235 new syscall numbers to unistd.h named 
> > __NR_LinuxN32...?
> 
> o32 currently has 240 syscalls.  Of these a good number is simply
> junk.  No syscall(2), oldstat(2), oldfstat(2), no experimental
> UNIX Version 7 bs like mpx(2) for new ABIs; away with stupid multiplexor
> calls like socketcall(2) and funny intelisms like vm86(2).  That's
> the first cleanup I'm planning.
> 
> For what will be left over, N32 and N64 use the same subroutine calling
> interface we'll be able to share most if not all syscalls between the two.
> llseek(2) is just one example.

Some syscalls will definitely not work for N32 with the N64 calling 
interface:

int execve(const char *filename, char *const argv [], char *const envp[]);

- where argv and envp points to arrays of pointers (4 bytes in N32, 8
  bytes in N64)

int fstat(int filedes, struct stat *buf);
int utime(const char *filename, struct utimbuf *buf);
clock_t times(struct tms *buf);
int ioctl(int d, int request, ...);
int fcntl(int fd, int cmd, struct flock * lock);

- struct contains long (4 bytes in N32, 8 bytes in N64)

So my point is, that we will need some of the O32 conversion stuff for N32 
as well.


/Kjeld


-- 
_    _ ____  ___                       Mailto:kjelde@mips.com
|\  /|||___)(___    MIPS Denmark       Direct: +45 44 86 55 85
| \/ |||    ____)   Lautrupvang 4 B    Switch: +45 44 86 55 55
  TECHNOLOGIES      DK-2750 Ballerup   Fax...: +45 44 86 55 56
                    Denmark            http://www.mips.com/
