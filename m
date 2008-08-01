Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2008 19:21:23 +0100 (BST)
Received: from web51901.mail.re2.yahoo.com ([206.190.48.64]:37516 "HELO
	web51901.mail.re2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S28574679AbYHASVR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Aug 2008 19:21:17 +0100
Received: (qmail 45448 invoked by uid 60001); 1 Aug 2008 18:21:07 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=RLDDWiX32FQcLjOLX4yhW9u8OG/2ELeHXlDKcrVak+iWMDn69iPw+Wpi0SN89k3OePvhyvBb93BcwFQ16mHDwta8sji8rsjM0pnc1YerAg8J7lvxdYKxGzCQCJhWXIVSmrvBkrhIEg5P92KJGaYaR4QpQqG3273bPVwCdrJFedc=;
Received: from [155.104.37.17] by web51901.mail.re2.yahoo.com via HTTP; Fri, 01 Aug 2008 11:21:07 PDT
X-Mailer: YahooMailWebService/0.7.218
Date:	Fri, 1 Aug 2008 11:21:07 -0700 (PDT)
From:	Sean Parker <supinlick@yahoo.com>
Reply-To: supinlick@yahoo.com
Subject: Reading DDR DCR's within Linux init process
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <806819.43646.qm@web51901.mail.re2.yahoo.com>
Return-Path: <supinlick@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: supinlick@yahoo.com
Precedence: bulk
X-list: linux-mips


Hello-

  We're using the PMC-Sierra MSP85XX Sequoia processor... (RM9000 family) The BSP has PMON2000 and Linux 2.6.18 port.

  In configuring/fixing the PMON to properly recognize single- and double-sided RAM modules (no - the BSP did not come from PMC with 'fully' working code in it!) I became familiar with the DDR DCR config process via RAM's I2C access.

  The problem is we want to be able to dynamically read the DDR DCR's (>0xFF000000) setup by PMON, and use the results of that (physical RAM size, i.e. 2G) to call "add_memory_region" in place of the hard-coded 256M "add_memory_region" already called inside the msp85XX-specific "plat_mem_setup" (arch/mips/pmc-sierra/msp85xx/setup.c)

  start_kernel
    ...
    printk(linux_banner)
    setup_arch
      ...
      arch_mem_init
        ...
        plat_mem_setup
          (assign MSP85XX-specific function pointer used later 
                as "late_time_init" below, and assign others)
          add_memory_region( 0x0, 0x10000000, ...) <-- hardcoded 256M
        parse_cmdline_early
          // normal "mem=" interpretation
          add_memory_region  

        // how can I get pointer to 0xFF000000+ DDR DCR here
        // in the process? (before mem_init)

    mem_init
    kmem_cache_init
    setup_per_cpu_pageset
    numa_policy_init
    late_time_init = &py_map_ocd <-- this is where lots of
                                     DCR's are accessed using 
                                     pointers provided by
                                     ioremap - TOO LATE TO CALL
                                     add_memory_region I suppose???
    calibrate_delay
    pidmap_init 
    ...
  <done start_kernel>


  Using command-line parameters (used inside "parse_cmdline_early") is not an option due to our system, and we don't want size-based linux images either.

  I have successfully been able to read the DDR DCRs inside "late_time_init" obtaining a pointer via ioremap call, but that is not a valid call earlier within the context of the setup_arch sequence - is this true? (I get exceptions when I do that) However in late_time_init is too late to call "add_memory_region".

  Does anyone have any ideas? Comments? What other call/procedure  analogous to ioremap can I make earlier to access the DDR DCR insite setup_arch process?

God Bless 
    Sean Parker 




      
