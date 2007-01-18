Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2007 02:33:44 +0000 (GMT)
Received: from web7902.mail.in.yahoo.com ([202.86.4.78]:35181 "HELO
	web7902.mail.in.yahoo.com") by ftp.linux-mips.org with SMTP
	id S28584841AbXARCdi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Jan 2007 02:33:38 +0000
Received: (qmail 24184 invoked by uid 60001); 18 Jan 2007 02:33:32 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=V5j2VOLSpuzciVTz56+iXfxDx25UQglX05B2hlYFGPq/DVTHsoqkvv2oPFgx1JpMvJV/TKA4llAi2WDzFhTgudUoCQmxAUUkDCoH5Lh7W/vFmhnKOCG9NrXDcghvI3Qy6aXpEWjfZNrPNE2WWH9LxfKEAb2vbJ9aTsaGUDPGFl8=;
X-YMail-OSG: .wcZcmkVM1kuhDBlQn72POylUfLtSeF2Vp1ZcrVfOV7Vcpm5vVSPahUD.fN7gUMaZZiTmfByYp5OfcMU_9TiS3HgJX6mWxd_cViI3dO_ciy1IzxpRKqh4joWCtMR6WkhMwMYvQsJjMbMmFyhzXdwCyUzkw--
Received: from [206.40.46.114] by web7902.mail.in.yahoo.com via HTTP; Thu, 18 Jan 2007 02:33:31 GMT
Date:	Thu, 18 Jan 2007 02:33:31 +0000 (GMT)
From:	sathesh babu <sathesh_edara2003@yahoo.co.in>
Subject: Setting Write through mode in linux-2.6.18.2 kernel ( MIPS 24KE) 
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-657535069-1169087611=:24060"
Content-Transfer-Encoding: 8bit
Message-ID: <42504.24060.qm@web7902.mail.in.yahoo.com>
Return-Path: <sathesh_edara2003@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sathesh_edara2003@yahoo.co.in
Precedence: bulk
X-list: linux-mips

--0-657535069-1169087611=:24060
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,
    I am porting linux-2.6.18.2 kernel on MIPS 24KE processor.
  I would like to configure  write through cache mode.
   
  I checked the cache defines ( asm-mips/pgtable-bits.h) .
   
  Only write back mode is defined for MIPS32.
   
  Does the linux-2.6.18.2 kernel ( on MIPS 24KE) have support for write through mode?.
  Could you please tell me write through mode is there in linux-2.6.18.2 kernel for MIPS 24KE.
   
   
  Thanks in advance.
   
  Regards,
  Sathesh
   
   

 				
---------------------------------
 Here’s a new way to find what you're looking for - Yahoo! Answers 
--0-657535069-1169087611=:24060
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi,</div>  <div>&nbsp; I am porting linux-2.6.18.2 kernel on MIPS 24KE processor.</div>  <div>I would like to configure &nbsp;write through cache mode.</div>  <div>&nbsp;</div>  <div>I checked the cache&nbsp;defines&nbsp;( asm-mips/pgtable-bits.h)&nbsp;.</div>  <div>&nbsp;</div>  <div>Only write back mode is defined for MIPS32.</div>  <div>&nbsp;</div>  <div>Does the linux-2.6.18.2 kernel ( on MIPS 24KE) have support for write through mode?.</div>  <div>Could you please tell me write through mode is there in linux-2.6.18.2 kernel for MIPS 24KE.</div>  <div>&nbsp;</div>  <div>&nbsp;</div>  <div>Thanks in advance.</div>  <div>&nbsp;</div>  <div>Regards,</div>  <div>Sathesh</div>  <div>&nbsp;</div>  <div>&nbsp;</div><p>&#32;
	

	
		<hr size=1></hr> 
Here’s a new way to find what you're looking for - <a href="http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.com/">Yahoo! Answers</a> 
--0-657535069-1169087611=:24060--
