Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2006 08:00:25 +0000 (GMT)
Received: from www.haninternet.co.kr ([211.63.64.4]:31760 "EHLO
	www.haninternet.co.kr") by ftp.linux-mips.org with ESMTP
	id S8133596AbWCXIAP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Mar 2006 08:00:15 +0000
Received: from [211.63.70.179] ([211.63.70.179])
	by www.haninternet.co.kr (8.9.3/8.9.3) with ESMTP id RAA22206;
	Fri, 24 Mar 2006 17:07:54 +0900
Subject: Re: Compilation problem with kernel 2.4.16
From:	Gowri Satish Adimulam <gowri@bitel.co.kr>
Reply-To: gowri@bitel.co.kr
To:	dhunjukrishna@gmail.com
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060324074521.53361.qmail@web53506.mail.yahoo.com>
References: <20060324074521.53361.qmail@web53506.mail.yahoo.com>
Content-Type: text/plain
Organization: Bitel Co Ltd
Date:	Fri, 24 Mar 2006 17:09:50 +0900
Message-Id: <1143187790.3249.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Return-Path: <gowri@bitel.co.kr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gowri@bitel.co.kr
Precedence: bulk
X-list: linux-mips

Hi,
could you post the error message , so that group members can analyse and
post you correct solution.

Gowri
On Thu, 2006-03-23 at 23:45 -0800, Krishna wrote:
> Hi,
>  
> I have been trying to cross compile Linux/MIPS kernel verison 2.4.16
> with the specifix's sibyte cross compiler (sb1-elf cross compilers for
> x86 linux hosts) for BCM 1480 Broadcom board. I have set the path for
> cross compiler properly in make file even then the compilation failed.
> Then we tried adding parameter " -Tcfe.ld" (which is must for
> compilation) in compilation command (as has been suggested by
> broadcom) still unble to get it done correctly. Wondering what else we
> need to change in make file. Or else is there any other cross compiler
> for BCM 1480 (than specifix one) that we can use. Anyone suggest me
> the proper way for compiling the kernel with the above cross
> compiler. 
>  
> Thanks and Regards
> Krishna
> 
> ______________________________________________________________________
> New Yahoo! Messenger with Voice. Call regular phones from your PC and
> save big.
