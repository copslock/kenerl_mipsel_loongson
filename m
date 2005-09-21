Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Sep 2005 18:25:02 +0100 (BST)
Received: from web31503.mail.mud.yahoo.com ([IPv6:::ffff:68.142.198.132]:37482
	"HELO web31503.mail.mud.yahoo.com") by linux-mips.org with SMTP
	id <S8225552AbVIURYn>; Wed, 21 Sep 2005 18:24:43 +0100
Received: (qmail 82845 invoked by uid 60001); 21 Sep 2005 17:24:36 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Qn9JcmBx6YYmK+5v3Iifb4Qf2VXkBZ8xzHO69XDbrsOd+HHCedWWV/FrkxPp98EvSc40QrcKr4u17DC/0wA8MGncFpFPu9/g/8+mlDbTH8AswwtFPRgq1j2ecV3yl5lJk8aCUhlY2yuRMVRoK3qHy4N6pcdf17TdHZhIr3Yqcig=  ;
Message-ID: <20050921172436.82843.qmail@web31503.mail.mud.yahoo.com>
Received: from [208.187.37.98] by web31503.mail.mud.yahoo.com via HTTP; Wed, 21 Sep 2005 10:24:35 PDT
Date:	Wed, 21 Sep 2005 10:24:35 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Building the kernel for a Broadcom SB1
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,

Things've been interesting here, of late. I've got the
toolchain to compile natively 64-bit code (with
considerable effort and the instructions from Linux
From Scratch) and I have a working Linux 2.6.12-rc2
kernel with the SB1 patches from the linux-mips
mailing lists.

So far, so good. Tried compiling the 2.6.14-rc1
kernel, forward-porting all the changes that hadn't
been merged in. the kernel locks in the initial boot
sequence, after a couple of printf's.

Are there any kernel patches for the Broadcom/SiByte
processors that are specific to the 2.6.13-* or
2.6.14-*, or any options that are definitely producing
Bad Code on these kernels but not earlier?



		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
