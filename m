Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Mar 2006 10:02:52 +0100 (BST)
Received: from web53504.mail.yahoo.com ([206.190.37.65]:35668 "HELO
	web53504.mail.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133370AbWC3JCn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Mar 2006 10:02:43 +0100
Received: (qmail 44806 invoked by uid 60001); 30 Mar 2006 09:13:13 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ilQ/bEqVQx5yq1MAomPk1y+Enxhgg+SKC7K8N0XZR7fURyKHmxLIDy9/3Yrwcp8Fb3PYtvg/uNzF+sNSkmk9FWJ/JGGOxr2OPCg2fCjVHdYLvMhyKtCJoCERsdBYODE/s9ILWKMYywBX7PwIPVWGcfp0ODKwddvfOxxXjzNHcFg=  ;
Message-ID: <20060330091313.44804.qmail@web53504.mail.yahoo.com>
Received: from [203.145.155.11] by web53504.mail.yahoo.com via HTTP; Thu, 30 Mar 2006 01:13:13 PST
Date:	Thu, 30 Mar 2006 01:13:13 -0800 (PST)
From:	Krishna <dhunjukrishna@yahoo.com>
Reply-To: dhunjukrishna@gmail.com
Subject: compilation problem with kernel 2.6.15 
To:	Linux-MIPS <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1100918324-1143709993=:43114"
Content-Transfer-Encoding: 8bit
Return-Path: <dhunjukrishna@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhunjukrishna@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-1100918324-1143709993=:43114
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

While trying to cross compile kernel 2.6.15 for BCM1480 
  Ii got the following error:
   
    CC      arch/mips/kernel/signal.o
  CC      arch/mips/kernel/syscall.o
  CC      arch/mips/kernel/time.o
  CC      arch/mips/kernel/traps.o
  CC      arch/mips/kernel/unaligned.o
  CC      arch/mips/kernel/mips_ksyms.o
  CC      arch/mips/kernel/module.o
  AS      arch/mips/kernel/r4k_fpu.o
  AS      arch/mips/kernel/r4k_switch.o
  CC      arch/mips/kernel/smp.o
  CC      arch/mips/kernel/smp_mt.o
/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/arch/mips/kernel/smp_mt.c: In fu
nction `prom_prepare_cpus':
/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/arch/mips/kernel/smp_mt.c:276: e
rror: `IRQ_PER_CPU' undeclared (first use in this function)
/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/arch/mips/kernel/smp_mt.c:276: e
rror: (Each undeclared identifier is reported only once
/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/arch/mips/kernel/smp_mt.c:276: e
rror: for each function it appears in.)
make[2]: *** [arch/mips/kernel/smp_mt.o] Error 1
make[1]: *** [arch/mips/kernel] Error 2
make: *** [_all] Error 2
  
Please anyone help me to solve this problem.
   
  Krishna

			
---------------------------------
Yahoo! Messenger with Voice. PC-to-Phone calls for ridiculously low rates.
--0-1100918324-1143709993=:43114
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>While trying to cross compile kernel 2.6.15 for BCM1480&nbsp;</div>  <div>Ii got the following error:</div>  <div>&nbsp;</div>  <div>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/mips/kernel/signal.o<BR>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/mips/kernel/syscall.o<BR>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/mips/kernel/time.o<BR>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/mips/kernel/traps.o<BR>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/mips/kernel/unaligned.o<BR>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/mips/kernel/mips_ksyms.o<BR>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/mips/kernel/module.o<BR>&nbsp; AS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/mips/kernel/r4k_fpu.o<BR>&nbsp; AS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/mips/kernel/r4k_switch.o<BR>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/mips/kernel/smp.o<BR>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/mips/kernel/smp_mt.o<BR>/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/arch/mips/kernel/smp_mt.c: In fu<BR>nction
 `prom_prepare_cpus':<BR>/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/arch/mips/kernel/smp_mt.c:276: e<BR>rror: `IRQ_PER_CPU' undeclared (first use in this function)<BR>/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/arch/mips/kernel/smp_mt.c:276: e<BR>rror: (Each undeclared identifier is reported only once<BR>/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/arch/mips/kernel/smp_mt.c:276: e<BR>rror: for each function it appears in.)<BR>make[2]: *** [arch/mips/kernel/smp_mt.o] Error 1<BR>make[1]: *** [arch/mips/kernel] Error 2<BR>make: *** [_all] Error 2</div>  <div><BR>Please anyone help&nbsp;me to solve this problem.</div>  <div>&nbsp;</div>  <div>Krishna</div><p>
	
		<hr size=1><a href="http://us.rd.yahoo.com/mail_us/taglines/postman3/*http://us.rd.yahoo.com/evt=39666/*http://beta.messenger.yahoo.com">Yahoo! Messenger with Voice.</a> PC-to-Phone calls for ridiculously low rates.
--0-1100918324-1143709993=:43114--
