Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 03:07:39 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45204 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491785Ab1FFBHg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Jun 2011 03:07:36 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5617sgp019571;
        Mon, 6 Jun 2011 02:07:55 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5617rhA019567;
        Mon, 6 Jun 2011 02:07:53 +0100
Date:   Mon, 6 Jun 2011 02:07:53 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Cc:     Grant Likely <grant.likely@secretlab.ca>,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        Dezhong Diao <dediao@cisco.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Converting MIPS to Device Tree
Message-ID: <20110606010753.GA16202@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3736

Over the past few days I've started to convert arch/mips to use DT.  So
far none of the platforms (except maybe PowerTV?) seems to have a
firmware that is passing a DT nor is there any 2nd stage bootloader that
could do so.

So as the 2nd best thing I've been working on .dts files to be compiled
into the images.

I've put a git tree of my current working tree online.  It's absolutely
work in progress so expect to encounter bugs.

  http://git.linux-mips.org/?p=linux-dt.git;a=summary (Gitweb)
  git://git.linux-mips.org/linux-dt.git
  http://www.linux-mips.org/wiki/Device_Tree (brief documentation & links)

An incomplete to do list:

  o Sort out interface for firmware to pass a DT to the kernel.  Because we
    have so many different firmware implementations this one might get a
    slight bit interesting.
  o Interface to select one of several builtin DT images.  I am thinking of
    extending the existing MIPS_MACHINE() / machtype mechanism to play
    nicely with DT.
  o Finish and test AR7, Cobalt, Jazz, Malta, MIPSsim and SNI ports.
  o Convert the remaining platforms; find if it's actually sensible to
    convert all platforms.
  o I'm considering to make DT support a requirement for future MIPS
    platforms so you might as well start beating your firmware monkeys /
    ask Santa to put you a shiny new bootloader blob into the boot now.
  o Write more of the required infrastructure.
  o Write documentation

Contributions and comments welcome,

  Ralf
