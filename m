Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2003 01:27:06 +0100 (BST)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:47849 "HELO
	idealab.com") by linux-mips.org with SMTP id <S8225206AbTEOA1D>;
	Thu, 15 May 2003 01:27:03 +0100
Received: (qmail 16398 invoked by uid 6180); 15 May 2003 00:27:01 -0000
Date: Wed, 14 May 2003 17:27:01 -0700
From: Jeff Baitis <baitisj@evolution.com>
To: Pete Popov <ppopov@mvista.com>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: Power On Self Test and testing memory
Message-ID: <20030514172701.B5897@luca.pas.lab>
Reply-To: baitisj@evolution.com
References: <20030514152643.A5897@luca.pas.lab> <1052951641.788.225.camel@zeus.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1052951641.788.225.camel@zeus.mvista.com>; from ppopov@mvista.com on Wed, May 14, 2003 at 03:34:01PM -0700
Return-Path: <baitisj@idealab.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

Hi Pete:

I forgot that I'm overwriting the RAM-based exception vectors. Earlier I had
disabled interrupts in the CP0 status register bit 0, but Linux actually needs
them enabled... :)

So, I changed my test to start at base address 0x80001000, but I still get the
same failure at the same RAM location.

Also important to mention is that my bootloader is executing from flash ROM,
and my initialization is very similar to the YAMON initialization file that
comes with the DbAu1500 eval board.

Here's what my code is like:

// in __main

failures = (int)loader_memcheck((UINT32)0xA0001000, (UINT32)0xA4000000, 0xAAAAAAAA);
failures = (int)loader_memcheck((UINT32)0xA0001000, (UINT32)0xA4000000, 0x55555555);
failures = (int)loader_memcheck((UINT32)0x80001000, (UINT32)0x84000000, 0xAAAAAAAA);
// Try to invalidate cache and go again
failures = (int)loader_memcheck((UINT32)0x80001000, (UINT32)0x84000000, 0xAAAAAAAA);

....


static unsigned int loader_memcheck( UINT32 base_addr, UINT32 max_addr, UINT32 test_data)
{   
    for (i = base_addr; i < max_addr; i=i+4)
    {
        *((unsigned int *)i) = test_data;
    }
    
    failures = 0;
    first_failure = 0xffffffff;
    for (i = base_addr; i < max_addr; i=i+4)
    {
        if (*((unsigned int *)i) != test_data)
        {
            if ((unsigned int)i < (unsigned int)first_failure)
            {
                first_failure = i;
            }
    
            ++failures;
        }
    }
    // if failures !=0 print_hex(first_failure)
    return failures;
}

So, after I execute this code, I pull up the EJTAG debugger, and
poke around.

I notice that even though the C code says that the first failure is at 0x8000fe50,
but when I poke around, I find:

    ...
    (gdb) p/x *(0x8000fe04)
    $27 = 0xaaaaaaaa

    (gdb) p/x *(0x8000fe08)
    $28 = 0x10fe0080

    (gdb) p/x *(0x8000fe10)
    $29 = 0x38000000
    ...

It seems like I'm having some cache coherency issues, since the results while
executing code are quite differenet.

Thanks for your help, Pete!

-Jeff

On Wed, May 14, 2003 at 03:34:01PM -0700, Pete Popov wrote:
> On Wed, 2003-05-14 at 15:26, Jeff Baitis wrote:
> > Hi all:
> > 
> > I implemented memory tests in my bootloader code for the AU1500. I'm trying
> > to figure out why Linux boots when loaded into cached KSEG0 (0x 80c0 0000),
> > but my memory test FAILS for this same region.
> > 
> > (pretty backwards huh? get linux booting, then write memory tests!)
> > 
> > 
> > I start by writing 0x5555 5555 to all of uncached memory, reading it back, and
> > I write 0xAAAA AAAA to all of uncached memory and read it back.
> > 
> > This works great.
> > 
> > Next, I try to write 0x5555 5555 to cached KSEG0 memory, and it fails at addr
> > 0x8000FE50. But Linux boots!
> 
> You're not overwriting any of the boot exception vectors, right?  What's
> the failure exactly and how does the test work?
> 
> Pete
> 
> > I'm not issuing SYNC commands when writing to cached memory; could this be
> > the problem?
> > 
> > We've exhaustively verified the memory burst parameters, etc. They look good.
> > 
> > Thank you in advance for your ideas!
> > 
> > Regards,
> > Jeff
> 

-- 
         Jeffrey Baitis - Associate Software Engineer

                    Evolution Robotics, Inc.
                     130 West Union Street
                       Pasadena CA 91103

 tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
