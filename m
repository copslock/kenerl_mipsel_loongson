Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Dec 2004 10:29:47 +0000 (GMT)
Received: from web54507.mail.yahoo.com ([IPv6:::ffff:68.142.225.177]:2425 "HELO
	web54507.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225005AbULOK3j>; Wed, 15 Dec 2004 10:29:39 +0000
Received: (qmail 45713 invoked by uid 60001); 15 Dec 2004 10:29:23 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=LQUWUOl8shZsahdu/18fn0FaL2fXWqoKCGjTrWACI1i1hiSdl1qvUjqKgVFp6us8HR/8uceR1OEe1QNLlEd4Gf31XjyfwM3WpljxXzuLVLlt1rZ3J7Pru2VSdJyFAn344Wk9dx1Ap4KWdw/BWNb++UE738c1ZZ4rzWSfOvhWUfY=  ;
Message-ID: <20041215102923.45711.qmail@web54507.mail.yahoo.com>
Received: from [203.101.73.166] by web54507.mail.yahoo.com via HTTP; Wed, 15 Dec 2004 02:29:22 PST
Date: Wed, 15 Dec 2004 02:29:22 -0800 (PST)
From: Srividya Ramanathan <navaraga@yahoo.com>
Subject: unresolved symbol io_remap_page_range
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <navaraga@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6664
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: navaraga@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,
  i had written and compiled a PCI device driver which
works well for X86 architecture. The same driver when
compiled for MIPS architecture gives "unresolved
symbol io_remap_page_range". Is this API deprecated or
is there any other alternative API for
io_remap_page_range()

Thanks
R.Srividya


		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 
