Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2006 07:35:33 +0000 (GMT)
Received: from web53506.mail.yahoo.com ([206.190.37.67]:19321 "HELO
	web53506.mail.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133596AbWCXHfZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Mar 2006 07:35:25 +0000
Received: (qmail 53363 invoked by uid 60001); 24 Mar 2006 07:45:21 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=uKgkco7km8Kz1uI4d4ouLtVL17XKXF4iA09PnWlSRQuWPob6CFZ8WlnyNoTNFWZPfkkMHMZOJ2KUdVqYOwulh+trGw3TtcfyfKTYWFx1YftrVAr/rEpQ4czaVDEchdqBF66PNrYWdEC9UJ8dFUFRrwCGifPUwFD3PXF8yDifL/o=  ;
Message-ID: <20060324074521.53361.qmail@web53506.mail.yahoo.com>
Received: from [203.145.155.11] by web53506.mail.yahoo.com via HTTP; Thu, 23 Mar 2006 23:45:21 PST
Date:	Thu, 23 Mar 2006 23:45:21 -0800 (PST)
From:	Krishna <dhunjukrishna@yahoo.com>
Reply-To: dhunjukrishna@gmail.com
Subject: Compilation problem with kernel 2.4.16
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1703484411-1143186321=:53036"
Content-Transfer-Encoding: 8bit
Return-Path: <dhunjukrishna@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhunjukrishna@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-1703484411-1143186321=:53036
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

  Hi,
   
  I have been trying to cross compile Linux/MIPS kernel verison 2.4.16 with the specifix's sibyte cross compiler (sb1-elf cross compilers for x86 linux hosts) for BCM 1480 Broadcom board. I have set the path for cross compiler properly in make file even then the compilation failed. Then we tried adding parameter " -Tcfe.ld" (which is must for compilation) in compilation command (as has been suggested by broadcom) still unble to get it done correctly. Wondering what else we need to change in make file. Or else is there any other cross compiler for BCM 1480 (than specifix one) that we can use. Anyone suggest me the proper way for compiling the kernel with the above cross compiler. 
   
  Thanks and Regards
  Krishna

		
---------------------------------
New Yahoo! Messenger with Voice. Call regular phones from your PC and save big.
--0-1703484411-1143186321=:53036
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<FONT face=Helv size=2>  <div>Hi,</div>  <div>&nbsp;</div>  <div>I have been trying to cross compile Linux/MIPS kernel verison 2.4.16 with the specifix's sibyte cross compiler (sb1-elf cross compilers for x86 linux hosts)&nbsp;for BCM 1480 Broadcom board.&nbsp;I have set the path for cross compiler properly in make file even then the compilation failed. Then we tried adding parameter " -Tcfe.ld" (which is must for compilation) in compilation command (as has been suggested by broadcom) still unble to get it done correctly. Wondering what else we need to change in make file. Or else is there any other cross compiler for BCM 1480 (than specifix one) that we can use. Anyone&nbsp;suggest me the proper way for compiling the kernel with the above cross compiler. </div>  <div>&nbsp;</div>  <div>Thanks and Regards</div>  <div>Krishna</div></FONT><p>
		<hr size=1>New Yahoo! Messenger with Voice. <a href="http://us.rd.yahoo.com/mail_us/taglines/postman5/*http://us.rd.yahoo.com/evt=39666/*http://beta.messenger.yahoo.com 
">Call regular phones from your PC</a> and save big.
--0-1703484411-1143186321=:53036--
