Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Apr 2007 23:00:27 +0100 (BST)
Received: from web53812.mail.re2.yahoo.com ([206.190.39.55]:44889 "HELO
	web53812.mail.re2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20022613AbXDGWAW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 7 Apr 2007 23:00:22 +0100
Received: (qmail 42482 invoked by uid 60001); 7 Apr 2007 21:59:15 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=KUbXwErGz5/XYep0feSfAgphBJo0VIOX63tguoAnmqKh5JfGFgl3HIlLEo3FI6mglqvOK6z7Fuz3GpdrRXIr0n6eGJxWSNHs3iB2H7TNM9jSk1F8bdn2m+kAS28n5cRfASwtqNejXQP51sz92YaW7+Ijn2cgkqNDhsLSiFWsIcs=;
X-YMail-OSG: dH42JW8VM1nOwwHPR8lws9viGLih4Taf3D1nyzi19QtJ5.W3tppJbp62yQRncq7ft891NER_wcpArrrEPyImrCHrWKOnOgdy3LoEWGiZynZau3DyhCBUOfi0dtYN3g--
Received: from [76.192.205.82] by web53812.mail.re2.yahoo.com via HTTP; Sat, 07 Apr 2007 14:59:15 PDT
Date:	Sat, 7 Apr 2007 14:59:15 -0700 (PDT)
From:	h h <harsh512@yahoo.com>
Subject: Describing Physical RAM Map to Linux
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-490179268-1175983155=:41507"
Content-Transfer-Encoding: 8bit
Message-ID: <640437.41507.qm@web53812.mail.re2.yahoo.com>
Return-Path: <harsh512@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: harsh512@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-490179268-1175983155=:41507
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,

I have a very basic question -- When describing physical memory to the kernel in 
prom_init(), should we describe the physical memory region where kernel is loaded or leave it out?  We are using add_memory_region() call to describe physical memory to the kernel.  If we do describe the memory region where kernel is loaded, how will kernel know not to use these pages for User processes?

We are using 2.6.16 on Cavium/Octeon based platform. 

Thanks,
JJ



 
---------------------------------
Don't get soaked.  Take a quick peek at the forecast 
 with theYahoo! Search weather shortcut.
--0-490179268-1175983155=:41507
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,<br><br>I have a very basic question -- When describing physical memory to the kernel in <br>prom_init(), should we describe the physical memory region where kernel is loaded or leave it out?&nbsp; We are using add_memory_region() call to describe physical memory to the kernel.&nbsp; If we do describe the memory region where kernel is loaded, how will kernel know not to use these pages for User processes?<br><br>We are using 2.6.16 on Cavium/Octeon based platform. <br><br>Thanks,<br>JJ<br><br><br><p>&#32;

<hr size=1>
Don't get soaked.  Take a<a href="
http://tools.search.yahoo.com/shortcuts/?fr=oni_on_mail&#news"> quick peek at the forecast </a><br> with the<a href="
http://tools.search.yahoo.com/shortcuts/?fr=oni_on_mail&#news">Yahoo! Search weather shortcut.</a>
--0-490179268-1175983155=:41507--
