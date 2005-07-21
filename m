Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jul 2005 15:01:08 +0100 (BST)
Received: from web34008.mail.mud.yahoo.com ([IPv6:::ffff:66.163.178.89]:54401
	"HELO web34008.mail.mud.yahoo.com") by linux-mips.org with SMTP
	id <S8225210AbVGUOAp>; Thu, 21 Jul 2005 15:00:45 +0100
Received: (qmail 65929 invoked by uid 60001); 21 Jul 2005 14:02:36 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=tfn5tlOoB55j/v56gs8tYuYAQlYaxSrokzC53RjVlsVHTNkpppk0/Q9m91jIpSJNYb0vKTO7WUWq31XTAGBesMdyzqLmbjNeDRbZn78s3t3VVEdBv2NMm+xr/Zo+FT4KMkPvM+5LrVvt12ZoKEnNezBYCRb2JrO+EHGsySGC7ho=  ;
Message-ID: <20050721140236.65927.qmail@web34008.mail.mud.yahoo.com>
Received: from [202.149.57.130] by web34008.mail.mud.yahoo.com via HTTP; Thu, 21 Jul 2005 07:02:36 PDT
Date:	Thu, 21 Jul 2005 07:02:36 -0700 (PDT)
From:	mojoe thinks <mojoe_thinks@yahoo.com>
Subject: trying to mmap part of the system memory (RAM)
To:	linux-mips@linux-mips.org, mojoe_thinks@yahoo.com
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-655388557-1121954556=:65925"
Content-Transfer-Encoding: 8bit
Return-Path: <mojoe_thinks@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mojoe_thinks@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-655388557-1121954556=:65925
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,
 
I've been trying to impliment mmap() fucntionality in my driver code. The intent is to reserve a piece of memory as buffer (about 2M) and map this area to the user space that calls this driver.
 
In the book Linux Device Driver by Rubini says that if we limit the use of system memory by the kernel, ie. tell the kernel to use less than the available amount of kernel space using command line option, we could in effect reuse the remaining memory by using the ioremap() system call.
 
I am working on MIPS RM5200 core (32 bit external Sys/Ad bus), the total availabe RAM size on the system is 64M, I have specified in the PMON boot code 32M size for use. So when the system boots up i can see that around 28M space is available using the free command.
Now when i use the ioremap() system call, it returns me an address, which i presume to be the virtual address. When i try to use this address driectly or with writeb()/readb() system call, the whole system just reboots. 
Can any one please tell if i am doing the right thing.. is there an lternate to ioremap() which would actually work? How do i get hold of the unused RAM space?
 
The address range that i'm using is 0xA2000000 as there is a direct mapping of memory in kseg1 address space for MIPS
 
I would be delighted to hear from anybody with a possible sol. :-)
 
Thanking in advance..
Prem

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-655388557-1121954556=:65925
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV>Hi,</DIV>
<DIV>&nbsp;</DIV>
<DIV>I've been trying to impliment mmap() fucntionality in my driver code. The intent is to reserve a piece of memory as buffer (about 2M) and map this area to the user space that calls this driver.</DIV>
<DIV>&nbsp;</DIV>
<DIV>In the book Linux Device Driver by Rubini says that if we limit the use of system memory by the kernel, ie. tell the kernel to use less than the available amount of kernel space&nbsp;using command line option, we could in effect reuse the remaining memory by using the ioremap() system call.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I am working on MIPS RM5200 core (32 bit external Sys/Ad bus), the total availabe RAM size on the system is 64M, I have specified in the PMON boot code 32M size for use. So when the system boots up i can see that around 28M space is available using the free command.</DIV>
<DIV>Now when i use the ioremap() system call, it returns me an address, which i presume to be the virtual address. When i try to use this address driectly or with writeb()/readb() system call, the whole system just reboots. </DIV>
<DIV>Can any one please&nbsp;tell if i am doing the right thing.. is there&nbsp;an lternate to ioremap() which would actually work? How do i get hold of the unused RAM space?</DIV>
<DIV>&nbsp;</DIV>
<DIV>The address range that i'm using is 0xA2000000 as there is a direct mapping of memory in kseg1 address space for MIPS</DIV>
<DIV>&nbsp;</DIV>
<DIV>I would be delighted to hear from anybody with a possible sol. :-)</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanking in advance..</DIV>
<DIV>Prem</DIV><p>__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-655388557-1121954556=:65925--
