Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2006 07:37:28 +0100 (BST)
Received: from web53501.mail.yahoo.com ([206.190.37.62]:34455 "HELO
	web53501.mail.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133421AbWD1GhT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Apr 2006 07:37:19 +0100
Received: (qmail 39758 invoked by uid 60001); 28 Apr 2006 06:37:12 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=xCUGXaMSvW0skBFnOcE8f3B6YBUbqmSohfmu3LqnDMT0Wyt4Rs7r9T2mNp1UXD71x7OMhl8yuvbx86/82aG7Oen9cuys2n1xIX67TK05Psl64h+hBvluxIPLCPeH4I97X/zcYiX7Uztf4mln3BwY5I6c3CPyu5f2Puv+7G9yKmI=  ;
Message-ID: <20060428063712.39756.qmail@web53501.mail.yahoo.com>
Received: from [203.145.155.11] by web53501.mail.yahoo.com via HTTP; Thu, 27 Apr 2006 23:37:12 PDT
Date:	Thu, 27 Apr 2006 23:37:12 -0700 (PDT)
From:	Krishna <dhunjukrishna@yahoo.com>
Reply-To: dhunjukrishna@gmail.com
Subject: problem with mips-linux gprof 
To:	Linux-MIPS <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-47132144-1146206232=:39523"
Content-Transfer-Encoding: 8bit
Return-Path: <dhunjukrishna@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhunjukrishna@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-47132144-1146206232=:39523
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,
   
  I have been trying to use mips-linux gprof from last few days. But not able to get profile data. Here what I did: 
   
  1. cross compiled program for mips-linux as follows
  $ mips-unknown-linux-gnu-gcc -o hello hello.c -g -pg -lc
   
  2. then ran hello on target mips-linux system (BCM91480B) which generates gmon.out file.
   
  3. copy gmon.out to the host.
   
  4. run mips-linux gprof as follows 
  $mips-unknown-linux-gnu-gprof hello
   
  But i get the following error message
  mips-unknown-linux-gnu-gprof: gmon.out file is missing call-graph data
   
  Then I googled around and found someone suggesting to use lib_p.a during compilation. But i don't have that library.
  Please someone help me to get rid of this problem.
   
  Thanks and Regards,
  Krishna

			
---------------------------------
Yahoo! Mail goes everywhere you do.  Get it on your phone.
--0-47132144-1146206232=:39523
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi,</div>  <div>&nbsp;</div>  <div>I have been trying to use mips-linux gprof from last few days. But&nbsp;not able to get profile data. Here what&nbsp;I did:&nbsp;</div>  <div>&nbsp;</div>  <div>1. cross compiled program for mips-linux&nbsp;as follows</div>  <div>$&nbsp;mips-unknown-linux-gnu-gcc -o hello hello.c -g -pg -lc</div>  <div>&nbsp;</div>  <div>2. then ran hello on target mips-linux system (BCM91480B) which generates gmon.out file.</div>  <div>&nbsp;</div>  <div>3. copy gmon.out to the host.</div>  <div>&nbsp;</div>  <div>4. run mips-linux gprof as follows&nbsp;</div>  <div>$mips-unknown-linux-gnu-gprof hello</div>  <div>&nbsp;</div>  <div>But i get the following error message</div>  <div>mips-unknown-linux-gnu-gprof: gmon.out file is missing call-graph data</div>  <div>&nbsp;</div>  <div>Then I googled around and found someone suggesting to use lib_p.a during compilation. But i don't have that library.</div>  <div>Please someone help me to get rid of this
 problem.</div>  <div>&nbsp;</div>  <div>Thanks and Regards,</div>  <div>Krishna</div><p>
	
		<hr size=1>Yahoo! Mail goes everywhere you do. <a href="http://us.rd.yahoo.com/evt=31132/*http://mobile.yahoo.com/services?promote=mail"> Get it on your phone</a>.
--0-47132144-1146206232=:39523--
