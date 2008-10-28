Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 16:14:15 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10840 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22594246AbYJ1QOG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Oct 2008 16:14:06 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49073a3b0001>; Tue, 28 Oct 2008 12:13:47 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Oct 2008 09:13:44 -0700
Received: from [192.168.162.106] ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Oct 2008 09:13:44 -0700
Message-ID: <49073A38.3070808@caviumnetworks.com>
Date:	Tue, 28 Oct 2008 09:13:44 -0700
From:	Chad Reese <kreese@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.14eol) Gecko/20070505 Iceape/1.0.9 (Debian-1.0.13~pre080323b-0etch3)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	David Daney <ddaney@caviumnetworks.com>,
	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 11/36] MIPSR2 ebase isn't just CAC_BASE
References: <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-7-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-8-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-9-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-10-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-11-git-send-email-ddaney@caviumnetworks.com> <20081028095655.GB18610@linux-mips.org> <alpine.LFD.1.10.0810281604250.27396@ftp.linux-mips.org>
In-Reply-To: <alpine.LFD.1.10.0810281604250.27396@ftp.linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Oct 2008 16:13:44.0399 (UTC) FILETIME=[26754DF0:01C93918]
Return-Path: <Kenneth.Reese@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kreese@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Tue, 28 Oct 2008, Ralf Baechle wrote:
> 
>> Another thing I noticed is that we don't use write_c0_ebase(), so the
>> firmware better setup this correctly or we crash and burn.  We better
>> should initialize that right ...
> 
>  Well, your version still does not do it...
> 
>   Maciej

From an Octeon perspective, we'd prefer that the kernel not touch ebase
as we set it in the bootloader. The bootloader sets the proper value
based on the number of kernels being loaded and which cores the kernel
is loaded on. This allows some interesting things, like running 16
kernels each on a different CPU. Although 16 kernels is just a toy
project, we have a number of customers that run two kernels. They choose
which cores the kernels run on dynamically at boot time.

Chad
