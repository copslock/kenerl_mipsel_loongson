Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3IDPX8d026969
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 18 Apr 2002 06:25:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3IDPXCc026968
	for linux-mips-outgoing; Thu, 18 Apr 2002 06:25:33 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3IDP68d026945
	for <linux-mips@oss.sgi.com>; Thu, 18 Apr 2002 06:25:06 -0700
Received: from localhost.localdomain ([127.0.0.1] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 16yBvF-0006QE-00; Thu, 18 Apr 2002 08:26:01 -0500
Message-ID: <3CBEC961.2E319218@cotw.com>
Date: Thu, 18 Apr 2002 08:25:53 -0500
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: libc-alpha@sources.redhat.com, linux-mips@oss.sgi.com, uclibc@uclibc.org
Subject: MIPS uClibc dynamic linker/loader progress and help?!
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Greetings.

I'm still "really close" to getting the MIPS uClibc dynamic linker working. I
finally took some time to collect register dumps and values to see if someone
can see something that I'm not.

I took the resolver assembly code for MIPS verbatim from GLIBC and
massaged it a bit for the uClibc framework. The file looks like this:

----------------------------------------------------------------------------
    .text
    .align  2
    .globl  _dl_linux_resolve
    .type   _dl_linux_resolve,@function
    .ent    _dl_linux_resolve
    _dl_linux_resolve:
        .frame  $29, 40, $31
        .set noreorder
        move    $3, $28         # Save GP
        addu    $25, 8          # t9 ($25) now points at .cpload instruction
        .cpload $25             # Compute GP
        .set reorder
        move    $2, $31         # Save slot call pc
        subu    $29, 40         # Save arguments and sp value in stack
        .cprestore 32
        sw      $15, 36($29)
        sw      $4, 16($29)
        sw      $5, 20($29)
        sw      $6, 24($29)
        sw      $7, 28($29)
        move    $4, $24
        move    $5, $15
        move    $6, $3
        move    $7, $2
        jal     _dl_linux_resolver
        lw      $31, 36($29)
        lw      $4, 16($29)
        lw      $5, 20($29)
        lw      $6, 24($29)
        lw      $7, 28($29)
        addu    $29, 40
        move    $25, $2
        jr      $25
    .size _dl_linux_resolve,.-_dl_linux_resolve
    .end _dl_linux_resolve
----------------------------------------------------------------------------

The function, _dl_linux_resolver, looks like this:

----------------------------------------------------------------------------
    void _dl_linux_resolver(void)
    {
        unsigned long foo;

        __asm__("\tmove %0, $7\t\n":"=r"(foo));
        SEND_ADDRESS_STDERR(foo,1);
        __asm__("\tmove %0, $15\t\n":"=r"(foo));
        SEND_ADDRESS_STDERR(foo,1);
        __asm__("\tmove %0, $24\t\n":"=r"(foo));
        SEND_ADDRESS_STDERR(foo,1);
        __asm__("\tmove %0, $25\t\n":"=r"(foo));
        SEND_ADDRESS_STDERR(foo,1);
        __asm__("\tmove %0, $28\t\n":"=r"(foo));
        SEND_ADDRESS_STDERR(foo,1);
        __asm__("\tmove %0, $29\t\n":"=r"(foo));
        SEND_ADDRESS_STDERR(foo,1);
        __asm__("\tmove %0, $31\t\n":"=r"(foo));
        SEND_ADDRESS_STDERR(foo,1);
        __asm__("\tlw %0, 0($25)\t\n":"=r"(foo));
        SEND_ADDRESS_STDERR(foo,1);
        __asm__("\tlw %0, 0($29)\t\n":"=r"(foo));
        SEND_ADDRESS_STDERR(foo,1);
    
        while(1);
    }
----------------------------------------------------------------------------

The output looks like this:

    ELF header=0x2aaa8000
    First Dynamic section entry=0x2aaa80cc
    About to do library loader relocations.
    Done relocating library loader, so we can now
            use globals and make function calls!
    GOT found at 0x2aaaf000
    Lib Loader: (0x2aaa8000) /usr/mipsel-linux-uclibc/lib/ld-uClibc.so.0
    searching for library: 'libc.so.0'
    searching in ldso dir: /usr/mipsel-linux-uclibc/lib
    Loading:    (0x2aaef000) /usr/mipsel-linux-uclibc/lib/libc.so.0
    Beginning relocation fixups
    Beginning copy fixups
    Calling init/fini for shared libraries
    Calling application main()
    0x0         <--  $7
    0x7         <--  $15
    0x0         <--  $24
    0x7fff7a30  <--  $25
    0x4d954     <--  $28
    0x7fff7a28  <--  $29
    0x2aaa8a6c  <--  $31
    0xa         <--  0($25)
    0x4d954     <--  0($29)

According to 'readelf' and a 'objdump -d':

                   GOT = 0x000463d0
     _dl_linux_resolve = 0x00000990
    _dl_linux_resolver = 0x00000a6c

Ignore for the minute that we are passing four arguments when in fact
we won't even use them. Now let us look at the values in the different
registers:

     $7 - according the assembly code above, it should contain the old value
          of $31, but instead it's zero...that doesn't seem right

-- 
    $15 - according to the comments in the 'dl-machine.h' file from GLIBC,
          this value should be the return address to the caller of the
          function, but it's value is 7, that doesn't seem right either

    $24 - accrding to the comments in the 'dl-machine.h' file from GLIBC,
          this value should be the index for this function symbol in .dynsym,
          which probably isn't right

    $25 - this should be the address of the function called, but the value
          gets overwritten right after the function prologue as you can see,
          and it's value is 0xa for whatever reason

               00000a6c <_dl_linux_resolver>:
                    a6c:       3c1c0005        lui     gp,0x5
                    a70:       279cd954        addiu   gp,gp,-9900
                    a74:       0399e021        addu    gp,gp,t9
                    a78:       27bdff18        addiu   sp,sp,-232
                    a7c:       afbc0000        sw      gp,0(sp)
                    a80:       27b90008        addiu   t9,sp,8
                    a84:       afbc00e0        sw      gp,224(sp)

    $28 - this should be pointing to the GOT, let's see if that's right. Using 
          the disassembly above the first two instructions give us
          gp = 0x0005000 - 0x000026ac which is 0x0004d954 and that matches
          the value printed above. I'm going to ignore the third assembly
          instruction, so:

             0x00007ff0 - (0x0004d954 - 0x000463d0) = 0x00000a6c

          which is indeed the address of '_dl_linux_resolver', but that means
          that t9/$25 was zero when we entered the function which should
          not be

    $29 - this is the stack pointer and if we dereference that we get the
          value of the $28 register, is that correct?

    $31 - this is the return address and that return address turns out to
          be '_dl_linux_resolver' which should be '_dl_linux_resolve' I
          thought even though after we fix up the GOT entry, we will jump
          to that location

So, what is the problem you say? If I attempt to make a function call or
access a global variable outside of the '_dl_linux_resolver' like calling
'dl_dprintf' or attempt an instruction like:

    __asm__("\tla %0, _dl_linux_resolve\t\n":"r="(foo));

the linker SEFAULTs which means that the GP value is incorrect, even though
it appears to be correct from the above? Any insight on what is going on?
Or perhaps I don't have a complete understanding of PIC code yet. Clearly,
the resolver stub is being called and the resolver function is being
entered. I am unable to see how the stack and registers could be getting
trashed. I have also placed the dynamic linker ELF binary on my FTP site
along with this post at (ftp://ftp.cotw.com/MIPS/uclibc). Insight
appreciated. Thanks.

-Steve

 Steven J. Hill - Embedded SW Engineer
