Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Sep 2004 21:37:07 +0100 (BST)
Received: from 67-121-164-6.ded.pacbell.net ([IPv6:::ffff:67.121.164.6]:43849
	"EHLO mailserver.sunrisetelecom.com") by linux-mips.org with ESMTP
	id <S8224935AbUI0UhD>; Mon, 27 Sep 2004 21:37:03 +0100
Received: from sunrisetelecom.com ([192.168.50.222]) by mailserver.sunrisetelecom.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 27 Sep 2004 13:36:57 -0700
Message-ID: <415879BF.3060802@sunrisetelecom.com>
Date: Mon, 27 Sep 2004 16:36:15 -0400
From: Karl Lessard <klessard@sunrisetelecom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: 2.6 status for pb1100?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Sep 2004 20:36:57.0433 (UTC) FILETIME=[BB840C90:01C4A4D1]
Return-Path: <klessard@sunrisetelecom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: klessard@sunrisetelecom.com
Precedence: bulk
X-list: linux-mips

Hi,

I'm working with a PB1100 board, and I try to run a linux 2.6 kernel. 
I've both try the kernel.org releases (2.6.8.1)and linux-mips CVS head.
While both fail due to many reasons, I've observed that some drivers 
have not been implemented or updated for kernel 2.6 series (for example
the au1100 framebuffer driver still use some kernel 2.4 headers).

My question is: Do PB1100 boards are officially supported by  2.6.x kernels?

Thanks,
Karl
