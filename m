Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jan 2009 19:35:12 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:62570 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21365010AbZAHTfJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Jan 2009 19:35:09 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4966555b0000>; Thu, 08 Jan 2009 14:34:51 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 8 Jan 2009 11:34:41 -0800
Received: from [192.168.162.106] ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 8 Jan 2009 11:34:41 -0800
Message-ID: <49665551.2050804@caviumnetworks.com>
Date:	Thu, 08 Jan 2009 11:34:41 -0800
From:	Chad Reese <kreese@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.14eol) Gecko/20070505 Iceape/1.0.9 (Debian-1.0.13~pre080323b-0etch3)
MIME-Version: 1.0
To:	"Kevin D. Kissell" <kevink@paralogos.com>
CC:	Ihar Hrachyshka <ihar.hrachyshka@gmail.com>,
	linux-mips@linux-mips.org
Subject: Re: NXP STB225 board support
References: <fce2a370812230648s798ebbf6y1387a237ae640e39@mail.gmail.com> <fce2a370901080858s345a33a6x3a2f821a7d9645b8@mail.gmail.com> <496652B7.60500@paralogos.com>
In-Reply-To: <496652B7.60500@paralogos.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jan 2009 19:34:41.0618 (UTC) FILETIME=[26DCEB20:01C971C8]
Return-Path: <Kenneth.Reese@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kreese@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Kevin D. Kissell wrote:
> Ihar Hrachyshka wrote:
>  >
>  >
>  > Bisecting my Linus vanilla git, I found that the problem appeared
>  > after the following patch was applied:
>  >
>  > 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=566f74f6b2f8b85d5b8d6caaf97e5672cecd3e3e
>  >
>  > After reverting the patch, Linus vanilla git kernel again boots ok on
>  > the board. Please, take a look.
> 
> Could one of the Cavium guys explain why the new code for V2 cores does
> "ebase += ..."  and not "ebase = "?

The value "(read_c0_ebase() & 0x3ffff000)" is a physical address and
must be converted into Mips KSEG address by adding CAC_BASE. My guess is
that something about the NXP STB225 isn't fully Mips r2 and doesn't
implement the ebase register correctly. I'm afraid I don't know anything
about that processor.

Chad
