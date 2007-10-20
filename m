Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Oct 2007 09:07:29 +0100 (BST)
Received: from web7908.mail.in.yahoo.com ([202.86.4.84]:46252 "HELO
	web7908.mail.in.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20031013AbXJTIHS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 20 Oct 2007 09:07:18 +0100
Received: (qmail 82174 invoked by uid 60001); 20 Oct 2007 08:07:07 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=X-YMail-OSG:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=2Ucfrx3E6ELRGu528Y4/pRt/9mXIIP3vi6uD5l/IZHa/jCsljB0gMwrYtM45jyDxHB0Dd1zn4DSO8EyLldppCPyQ7G4QSH6F6BZHKV5LrqZ3ouiuYBb942Ik5nOlPN6DWp0vS9TqBskGxH/4zFfsTYvA6XrCskfwnuqUg8YFUMw=;
X-YMail-OSG: u0eklXMVM1kAZMoa75dkGBU3CGAS24Fc19CVg7sFmmSqGVafV18UmA85oCZSXzDDaKB3HQD4LD55WEbWkWe3nzr5CAB7YU6nVvewnE7iDJ.Cc.gesg675YT3QfEyKsMElKV7zY3.3EqOZRE6
Received: from [199.239.167.162] by web7908.mail.in.yahoo.com via HTTP; Sat, 20 Oct 2007 09:07:07 BST
Date:	Sat, 20 Oct 2007 09:07:07 +0100 (BST)
From:	sathesh babu <sathesh_edara2003@yahoo.co.in>
Subject: MIPS Crosstoolchain for MIPS24K with dsp amd 24k compiler options 
To:	linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, buildroot@uclibc.org
In-Reply-To: <Pine.LNX.4.64N.0710192135440.13279@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1611430905-1192867627=:82132"
Content-Transfer-Encoding: 8bit
Message-ID: <712862.82132.qm@web7908.mail.in.yahoo.com>
Return-Path: <sathesh_edara2003@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sathesh_edara2003@yahoo.co.in
Precedence: bulk
X-list: linux-mips

--0-1611430905-1192867627=:82132
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi, 
   
  I would like to build cross toolchain for MIPS24K processor with "-mdsp" and
   "-m24k" compile flag options for linux-2.6.18.8 kernel.
   
  I tried with below combinations of
  - GCC-4.2.1,GCC-4.0.1, GCC-4.1.0
  - binutils-2.15, binutil-2.17,binutil-2.18 
  -  uClibc-0.9.27 
  but i couldn't succeed any of the above combinations.
   
  I checked the mailing list and it is mentioned that GCC-4.2.x version of gcc has problems.
   
  Could you please guide me the, the exact versions of
   - GCC 
   - binutils
   - ucLibc
  to be used to build toolchain with "-mdsp" and "-m24k" compiler options for linux-2.6.18.8 kernel version.
   
  Thanks. 
   
  Regards,
  Sathesh

       
---------------------------------
 Bollywood, fun, friendship, sports and more. You name it,  we have it.
--0-1611430905-1192867627=:82132
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi, </div>  <div>&nbsp;</div>  <div>I would like to build cross toolchain for MIPS24K processor with "-mdsp" and</div>  <div>&nbsp;"-m24k" compile flag options for linux-2.6.18.8 kernel.</div>  <div>&nbsp;</div>  <div>I tried&nbsp;with below combinations of</div>  <div>- GCC-4.2.1,GCC-4.0.1, GCC-4.1.0</div>  <div>- binutils-2.15, binutil-2.17,binutil-2.18&nbsp;</div>  <div>- &nbsp;uClibc-0.9.27 </div>  <div>but i couldn't succeed any of the above combinations.</div>  <div>&nbsp;</div>  <div>I checked the mailing list and it is mentioned that GCC-4.2.x version of gcc has problems.</div>  <div>&nbsp;</div>  <div>Could you please guide me the, the exact versions of</div>  <div>&nbsp;- GCC&nbsp;</div>  <div>&nbsp;- binutils</div>  <div>&nbsp;- ucLibc</div>  <div>to be used to build toolchain with "-mdsp" and "-m24k"&nbsp;compiler options for linux-2.6.18.8 kernel version.</div>  <div>&nbsp;</div>  <div>Thanks.&nbsp;</div>  <div>&nbsp;</div>  <div>Regards,</div> 
 <div>Sathesh</div><p>&#32;


      <!--1--><hr size=1></hr> Bollywood, fun, friendship, sports and more. You name it, <a href="http://in.rd.yahoo.com/tagline_groups_1/*http://in.promos.yahoo.com/groups"> we have it.</a>
--0-1611430905-1192867627=:82132--
