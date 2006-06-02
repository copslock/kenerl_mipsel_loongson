Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2006 21:01:53 +0200 (CEST)
Received: from w099.z064220152.sjc-ca.dsl.cnc.net ([64.220.152.99]:63935 "HELO
	duck.specifix.com") by ftp.linux-mips.org with SMTP
	id S8133877AbWFBTBj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Jun 2006 21:01:39 +0200
Received: from [127.0.0.1] (duck.corp.specifix.com [192.168.1.1])
	by duck.specifix.com (Postfix) with ESMTP
	id 22A75FC5E; Fri,  2 Jun 2006 12:01:24 -0700 (PDT)
Subject: Re: where I can find a crosscompiler for BCM1255
From:	James E Wilson <wilson@specifix.com>
To:	richard <yczhao@hhcn.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <1149232577$80806$99988841@yczhao@hhcn.com>
References: <1149232577$80806$99988841@yczhao@hhcn.com>
Content-Type: text/plain
Message-Id: <1149274883.17016.6.camel@aretha.corp.specifix.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date:	Fri, 02 Jun 2006 12:01:24 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <wilson@specifix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@specifix.com
Precedence: bulk
X-list: linux-mips

On Fri, 2006-06-02 at 00:16, richard wrote:
> I download crosscompilers(sb1-elf-,mips-linux-) from broadcom website, but error occurs when compiling

We can't help you unless you specify exactly what the error was, and
exactly what command you typed that generated the error.  If this was a
kernel compilation problem, you may need to specify the kernel
configuration used.

By the way, there is a default kernel config that you should start with,
and then modify as necessary.  It is in arch/mips/configs in the
sb1250-swarm_defconfigs file.

> Do the compilers work for linux compiling?

The sb1-elf toolchain will not work for compiling linux.  The mips-linux
toolchain will work for compiling linux.  However, because of
interdependencies between the linux kernel and gcc, certain gcc versions
may be required for compiling certain linux kernel versions.

>  or I should download other versions of compiler for the kernel? And where?

There is some useful info in the wiki about this.
    http://www.linux-mips.org/wiki/Toolchains
You can always start with FSF releases if you are willing to build the
toolchains yourself.
-- 
Jim Wilson, GNU Tools Support, http://www.specifix.com
