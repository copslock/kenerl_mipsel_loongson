Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Jan 2007 23:42:50 +0000 (GMT)
Received: from web7912.mail.in.yahoo.com ([202.86.4.88]:30377 "HELO
	web7912.mail.in.yahoo.com") by ftp.linux-mips.org with SMTP
	id S28578666AbXATXmp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 20 Jan 2007 23:42:45 +0000
Received: (qmail 49128 invoked by uid 60001); 20 Jan 2007 23:42:37 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Ispd8GIhxtzkK2h7ctDXyj32uVmiJpO9H01aGx9uIMMnU7zyPFnXtzFhCJ2O0WgpqI2zDHwSLEIpywVussH/dYggRDCzYG/ZpSgTrQA7wCBZCGrT8US4OZ+ZTodmUhUL2UFeXn8dlx6bwSsCOI6d3UrxMQNWOA5Tb7CbVKjZN3o=  ;
Message-ID: <20070120234237.49126.qmail@web7912.mail.in.yahoo.com>
X-YMail-OSG: _7lwWTMVM1nASmcNO9JtJoz4jfjiWUkgDxjHWx5K3PKw_A1I9HuM3SSQd1HpjfnZuJd3b261ww51tU6Nw9NA9HCJvdfIaHN66joJ_fdhck8YURLPx667FHDPRMbh2i.8HOasozEMCMg30NgVtgJRb3Jvjw--
Received: from [206.40.46.114] by web7912.mail.in.yahoo.com via HTTP; Sat, 20 Jan 2007 23:42:37 GMT
Date:	Sat, 20 Jan 2007 23:42:37 +0000 (GMT)
From:	sathesh babu <sathesh_edara2003@yahoo.co.in>
Subject: Running Linux on FPGA
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1862169920-1169336557=:45458"
Content-Transfer-Encoding: 8bit
Return-Path: <sathesh_edara2003@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sathesh_edara2003@yahoo.co.in
Precedence: bulk
X-list: linux-mips

--0-1862169920-1169336557=:45458
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,
  I am trying to run Linux-2.6.18.2 ( with preemption enable) kernel on FPGA board which has MIPS24KE processor runs at 12 MHZ. Programmed the timer to give interrupt at every 10msec.
  I am seeing some inconsistence behavior during boot up processor. Some times it stops after "NET: Registered protocol family 17" and "VFS: Mounted root (jffs2 filesystem).".
  Could some give some pointers why the behavior is random.
  Is it OK to program the timer to 10 msec? or should it be more.
  Thanks in advance.
  Regards,
  Sathesh

 				
---------------------------------
 Here’s a new way to find what you're looking for - Yahoo! Answers 
--0-1862169920-1169336557=:45458
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi,</div>  <div>I am trying to run Linux-2.6.18.2 ( with preemption enable) kernel on FPGA board which has MIPS24KE processor runs at 12 MHZ. Programmed the timer to give interrupt at every 10msec.</div>  <div>I am seeing some inconsistence behavior during boot up processor. Some times it stops after "NET: Registered protocol family 17" and "VFS: Mounted root (jffs2 filesystem).".</div>  <div>Could some give some pointers why the behavior is random.</div>  <div>Is it OK to program the timer to 10 msec? or should it be more.</div>  <div>Thanks in advance.</div>  <div>Regards,</div>  <div>Sathesh</div><p>&#32;
	

	
		<hr size=1></hr> 
Here’s a new way to find what you're looking for - <a href="http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.com/">Yahoo! Answers</a> 
--0-1862169920-1169336557=:45458--
