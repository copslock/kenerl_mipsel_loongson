Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jul 2004 00:01:07 +0100 (BST)
Received: from web40006.mail.yahoo.com ([IPv6:::ffff:66.218.78.24]:49590 "HELO
	web40006.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8226162AbUGFXA7>; Wed, 7 Jul 2004 00:00:59 +0100
Message-ID: <20040706230050.53313.qmail@web40006.mail.yahoo.com>
Received: from [63.87.1.243] by web40006.mail.yahoo.com via HTTP; Tue, 06 Jul 2004 16:00:50 PDT
Date: Tue, 6 Jul 2004 16:00:50 -0700 (PDT)
From: Song Wang <wsonguci@yahoo.com>
Subject: kbuild support to build one module with multiple separate components? 
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <wsonguci@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsonguci@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi, Folks

I'm puzzled by the kbuild system in 2.6 kernel.
I want to write a kernel module, which consists of
several components. The module is produced by
linking these components. These components are located
in separate subdirectories (for example A, B,C). 
Each component is generated also by linking 
multiple files. (For example, a_1.c, a_2.c for
building A.o, b_1.c, b_2.c for building B.o, then A.o
and B.o
should be linked to produce mymodule.o) 

I know if I put all the files in a single directory
The makefile of the module looks like

obj-$(CONFIG_MYMODULE) += mymodule.o
mymodule-objs := a_1.o a_2.o b_1.o b_2.o c_1.o c_2.o

It should work. But it is really messy, especially
there are a lot of files or each component requires
different EXTRA_CFLAGS. However, if I write
separate Makefiles for each component in their own
subdirectory, the Makefile of component A looks like

obj-y := A.o (or obj-$(CONFIG_MYMODULE) +=  A.o)
A-objs := a_1.o a_2.o

And the Makefile of mymodule looks like
obj-$(CONFIG_MYMODULE) +=  A/

This is wrong, because kbuild will treat A as
independent module. All I want is to treat
A as component of the only module mymodule.o. It
should be linked to mymodule.o

Any idea on how to write a kbuild Makefile to
support such kind of single module produced
by linking multiple components and each component
is located in separate directory? Thanks.

-Song




		
__________________________________
Do you Yahoo!?
Yahoo! Mail - Helps protect you from nasty viruses.
http://promotions.yahoo.com/new_mail
