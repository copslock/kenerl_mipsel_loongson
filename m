Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Jun 2013 13:20:20 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52204 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823690Ab3FLLUOtbrxy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 12 Jun 2013 13:20:14 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5CBKCQ5007866;
        Wed, 12 Jun 2013 13:20:12 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5CBKAKL007859;
        Wed, 12 Jun 2013 13:20:10 +0200
Date:   Wed, 12 Jun 2013 13:20:09 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org, Michal Marek <mmarek@suse.cz>,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] MIPS: Kconfig: Set default value for the "Kernel code
 model"
Message-ID: <20130612112009.GA7422@linux-mips.org>
References: <1370944336-13703-1-git-send-email-markos.chandras@imgtec.com>
 <20130611154129.GD13126@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130611154129.GD13126@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Here's a simplified test case:

< --------- bite here --------- >
choice
	prompt "choice 1"

config FOO1
	bool "foo 1"

config FOO2
	bool "foo 2"
endchoice

choice
	prompt "frob"

config BAR
	bool "bar"
	depends on FOO2

endchoice
< --------- bite here --------- >

Save this to a file, then run:

  scripts/kconfig/conf --randconfig /tmp/xxx && cat .config

There will be two possible variants for generated .config files:

< --------- Variant 1 --------- >
CONFIG_FOO1=y
# CONFIG_FOO2 is not set
< --------- Variant 2 --------- >
# CONFIG_FOO1 is not set
# CONFIG_FOO2 is not set
< --------- End       --------- >

The intended third outcome which would be
< --------- doesn't happen ---- >
# CONFIG_FOO1 is not set
CONFIG_FOO2=y
< --------- End --------------- >

never gets generated.

Pretty much any tempering with this test case will change the behaviour.
For example removing the "depends on FOO2" line will result in the
behaviour of either CONFIG_FOO1 or CONFIG_FOO2 being set to y but never
none or both.  Other minor changes might result in both symbols getting
set.

  Ralf
