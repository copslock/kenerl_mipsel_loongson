Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 May 2004 09:56:49 +0100 (BST)
Received: from gw-eur4.philips.com ([IPv6:::ffff:161.85.125.10]:37863 "EHLO
	gw-eur4.philips.com") by linux-mips.org with ESMTP
	id <S8225559AbUENI4s>; Fri, 14 May 2004 09:56:48 +0100
Received: from smtpscan-eur4.philips.com (smtpscan-eur4.mail.philips.com [130.144.57.167])
	by gw-eur4.philips.com (Postfix) with ESMTP id 5E23649FA7
	for <linux-mips@linux-mips.org>; Fri, 14 May 2004 08:56:39 +0000 (UTC)
Received: from smtpscan-eur4.philips.com (localhost [127.0.0.1])
	by localhost.philips.com (Postfix) with ESMTP id 32307CC
	for <linux-mips@linux-mips.org>; Fri, 14 May 2004 08:56:39 +0000 (GMT)
Received: from smtprelay-nl2.philips.com (smtprelay-eur2.philips.com [130.139.36.35])
	by smtpscan-eur4.philips.com (Postfix) with ESMTP id 165BFB7
	for <linux-mips@linux-mips.org>; Fri, 14 May 2004 08:56:39 +0000 (GMT)
Received: from ehvrmh02.diamond.philips.com (ehvrmh02-srv.diamond.philips.com [130.139.27.125]) 
	by smtprelay-nl2.philips.com (8.9.3p3/8.8.5-1.2.2m-19990317) with ESMTP id KAA04833
	for <linux-mips@linux-mips.org>; Fri, 14 May 2004 10:56:38 +0200 (MEST)
From: shiraz.ta@philips.com
Subject: Porting of Linux on to a MIPS16 Processor. Help required 
To: linux-mips@linux-mips.org
X-Mailer: Lotus Notes Release 5.0.9a  January 7, 2002
Message-ID: <OF9C1094DD.6309A695-ON45256E94.002F4A91-65256E94.00311FA8@philips.com>
Date: Fri, 14 May 2004 14:24:50 +0530
X-MIMETrack: Serialize by Router on ehvrmh02/H/SERVER/PHILIPS(Release 6.0.2CF1HF634 | May
 5, 2004) at 14/05/2004 10:54:55
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Return-Path: <shiraz.ta@philips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shiraz.ta@philips.com
Precedence: bulk
X-list: linux-mips





Hi,

I am new to linux.  I am  in need of porting linux to a MIPS16 based
processor.   I need some information regarding the porting. It will be a
great help if somebody could answer me.

1) Is there any port available already for this? If available how do i get
it along with the development environment.

2) If the port  is not available  then how much complex (How much effort ?)
is it to port it to MIPS 16.

3) Where can  I get the tool chain on windows and linux kernel source code
which can be used .

4)curently the board uses EJTAG for download and execute. We have a
uart(serial port) on the board which we use as console connected to the
hyperterminal on a windows pc.. There is no shell supported. We can compile
and run  applications on the target.

5) We have the existing BSP  and  custom drivers ported over a OS
abstraction layer. Once the kernel is ported we have to get the custom
drivers ported.

6) I would like to know how much would be  the code size for the kernel
alone with out any shell and with  the console driver. (Source code and
Binary)


Thanks in advance.


Warm Regards
Shiraz
