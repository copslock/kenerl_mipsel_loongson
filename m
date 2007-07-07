Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Jul 2007 05:16:52 +0100 (BST)
Received: from web94302.mail.in2.yahoo.com ([203.104.16.212]:47519 "HELO
	web94302.mail.in2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20022556AbXGGEQZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 7 Jul 2007 05:16:25 +0100
Received: (qmail 75876 invoked by uid 60001); 7 Jul 2007 04:15:17 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=6PYCDxhTOsRIkp+CA90TyAPiYrVpfdw+aYdNpPqwtgyCiyVWVU06F5QWGcFPtrLlsI5HQcfRKjtaOx6hGmW2IJ+FV4UwtQUKg7S04yWVAi2EnlC7+swlvmkyDpvCJ6EtKRn6f9O4mV4KOKKkMvqjiNGJsJ6/kht9Zjw5VQ3PnYQ=;
X-YMail-OSG: IbHqHHEVM1mjZgSacN1QKHZEgrq9ir_R4cb8B5MU4cTBHoclbHPs9gil4kLBrdx6I3_eyLWPwKgC3U7lzA_SMQ1M6fJsksICQV7SAelHKRydLKJEPToxyccf1A--
Received: from [59.92.50.213] by web94302.mail.in2.yahoo.com via HTTP; Sat, 07 Jul 2007 05:15:16 BST
Date:	Sat, 7 Jul 2007 05:15:16 +0100 (BST)
From:	saravanan <sar_van81@yahoo.co.in>
Subject: Re: error in crosscompiling autoboot for MIPS
To:	mano@roarinelk.homelinux.net
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20070706094451.GB27044@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-727162940-1183781716=:66060"
Content-Transfer-Encoding: 8bit
Message-ID: <379910.66060.qm@web94302.mail.in2.yahoo.com>
Return-Path: <sar_van81@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sar_van81@yahoo.co.in
Precedence: bulk
X-list: linux-mips

--0-727162940-1183781716=:66060
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

hi ,
 
 using the updated script you sent .but still the error persists. th efollowing are the steps i followed.
 
 1) Untarred the source au1xxx-booter-src-1.0-r000007.tar.gz.
 
 2) Edit the make.rules to inlude the buildroot toolchain and the path to that.
 
 3) configured the package by entering make menuconfig and selecting the following options:
 
 Platform --> DB1200 platform.
 Application --> Au1xxx Autoboot --> AutoBoot (YAMON assist).
 
 4). Edit the applications/booter/booter.ld to include the script you sent.
 
 5). entered make.
 
  Are these steps correct ? or Am i missing something ?
 
 

 Send free SMS to your Friends on Mobile from your Yahoo! Messenger. Download Now! http://messenger.yahoo.com/download.php
--0-727162940-1183781716=:66060
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

hi ,<br> <br> using the updated script you sent .but still the error persists. th efollowing are the steps i followed.<br> <br> 1) Untarred the source au1xxx-booter-src-1.0-r000007.tar.gz.<br> <br> 2) Edit the make.rules to inlude the buildroot toolchain and the path to that.<br> <br> 3) configured the package by entering make menuconfig and selecting the following options:<br> <br> Platform --&gt; DB1200 platform.<br> Application --&gt; Au1xxx Autoboot --&gt; AutoBoot (YAMON assist).<br> <br> 4). Edit the applications/booter/booter.ld to include the script you sent.<br> <br> 5). entered make.<br> <br> &nbsp;Are these steps correct ? or Am i missing something ?<br> <br> <br><p>&#32;Send free SMS to your Friends on Mobile from your Yahoo! Messenger. Download Now! http://messenger.yahoo.com/download.php
--0-727162940-1183781716=:66060--
