Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Dec 2003 18:08:36 +0000 (GMT)
Received: from purplechoc.demon.co.uk ([IPv6:::ffff:80.176.224.106]:3968 "EHLO
	skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225432AbTLMSIf>; Sat, 13 Dec 2003 18:08:35 +0000
Received: from pdh by skeleton-jack.localnet with local (Exim 3.35 #1 (Debian))
	id 1AVEBo-0001IO-00; Sat, 13 Dec 2003 18:08:28 +0000
Date: Sat, 13 Dec 2003 18:08:28 +0000
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Peter Horton <pdh@colonel-panic.org>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: Possible shared mapping bug in 2.4.23 (at least MIPS/Sparc)
Message-ID: <20031213180828.GA480@skeleton-jack>
References: <20031213114134.GA9896@skeleton-jack> <20031213160536.GA13271@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031213160536.GA13271@linux-mips.org>
User-Agent: Mutt/1.3.28i
From: Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

On Sat, Dec 13, 2003 at 05:05:36PM +0100, Ralf Baechle wrote:
> On Sat, Dec 13, 2003 at 11:41:34AM +0000, Peter Horton wrote:
> 
> > The current MIPS 2.4 kernel (from CVS) currently allows fixed shared
> > mappings to violate D-cache aliasing constraints.
> > 
> > The check for illegal fixed mappings is done in
> > arch_get_unmapped_area(), but these mappings are granted in
> > get_unmapped_area() and arch_get_unmapped_area() is never called.
> > 
> > A quick look at sparc and sparc64 seem to show the same problem.
> 
> Ehh...  <asm/pgtable.h> defines HAVE_ARCH_UNMAPPED_AREA therefore
> get_unmapped_area calls the arch's version of arch_get_unmapped_area
> instead of the generic version in mm/mmap.c
> 

arch_get_unmapped_area() never get called because get_unmapped_area()
notices the MAP_FIXED flag and returns success.

In the example below the second mmap() should fail because it violates
the shm_align_mask.

P.

pdh@qube2:~$ uname -a
Linux qube2 2.4.23 #2 Sat Dec 13 18:03:10 GMT 2003 mips unknown
pdh@qube2:~$ ./shared
0xdeadbeef 0
pdh@qube2:~$ cat shared.c
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/user.h>

int main(int argc, char *argv[])
{
        static char zero;
        void *p1, *p2;
        int fd;

        fd = open("/tmp/test.shared", O_CREAT|O_RDWR|O_TRUNC, 0664);
        if(fd == -1)
                return 1;
        unlink("/tmp/test.shared");

        lseek(fd, PAGE_SIZE - 1, SEEK_SET);
        if(write(fd, &zero, 1) != 1)
                return 1;

        p1 = mmap(NULL, PAGE_SIZE, PROT_READ, MAP_SHARED, fd, 0);
        if(p1 == MAP_FAILED)
                return 1;

        p2 = mmap(p1 + PAGE_SIZE, PAGE_SIZE, PROT_WRITE, MAP_SHARED|MAP_FIXED, fd, 0);
        if(p2 == MAP_FAILED || p2 - p1 != PAGE_SIZE)
                return 1;

        *(int *) p2 = 0xdeadbeef;

        printf("%#x %#x\n", *(int *) p2, *(int *) p1);

        return 0;
}
pdh@qube2:~$
