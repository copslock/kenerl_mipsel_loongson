Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 03:01:34 +0000 (GMT)
Received: from [IPv6:::ffff:159.226.39.4] ([IPv6:::ffff:159.226.39.4]:47300
	"HELO mail.ict.ac.cn") by linux-mips.org with SMTP
	id <S8225223AbTCMDBd>; Thu, 13 Mar 2003 03:01:33 +0000
Received: (qmail 2110 invoked from network); 13 Mar 2003 02:43:09 -0000
Received: from unknown (HELO ict.ac.cn) (159.226.40.150)
  by 159.226.39.4 with SMTP; 13 Mar 2003 02:43:09 -0000
Message-ID: <3E70A805.1030007@ict.ac.cn>
Date: Thu, 13 Mar 2003 10:47:17 -0500
From: Zhang Fuxin <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020809
X-Accept-Language: zh-cn, en-us
MIME-Version: 1.0
To: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: linux/mips on simos
Content-Type: text/plain; charset=x-gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

hi,
Recently i am working on stanford SIMOS and trying to make it
run linux/mips kernel.

I've managed to run debian-mips root disk on it now. Work includes
adding a serial device simulation to simos,hack around memory/io
address mapping and adapt a linux/mips kernel for simos.

Many powerful features are to be brought back. I am struggling with
SIMOS symbol handling for ELF kernels. The backdoor,data collection
etc. need check too. I would be very glad if anybody here is willing to
help.

The main purpose of my work is to provide a studying environment for people
who want to learn something about linux/mips but without corresponding
hardware at hand. There are more and more such people in China, and I
am a member of a free orgnization that want to help them.

I believe SIMOS will be helpful for linux/mips kernel developing too.
