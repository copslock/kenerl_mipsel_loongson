Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jan 2009 19:23:44 +0000 (GMT)
Received: from aux-209-217-49-36.oklahoma.net ([209.217.49.36]:13326 "EHLO
	proteus.paralogos.com") by ftp.linux-mips.org with ESMTP
	id S21365018AbZAHTXm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Jan 2009 19:23:42 +0000
Received: from [192.168.236.58] ([217.109.65.213])
	by proteus.paralogos.com (8.9.3/8.9.3) with ESMTP id NAA28505;
	Thu, 8 Jan 2009 13:54:37 -0600
Message-ID: <496652B7.60500@paralogos.com>
Date:	Thu, 08 Jan 2009 13:23:35 -0600
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
MIME-Version: 1.0
To:	Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: NXP STB225 board support
References: <fce2a370812230648s798ebbf6y1387a237ae640e39@mail.gmail.com> <fce2a370901080858s345a33a6x3a2f821a7d9645b8@mail.gmail.com>
In-Reply-To: <fce2a370901080858s345a33a6x3a2f821a7d9645b8@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Ihar Hrachyshka wrote:
 >
 >
 > Bisecting my Linus vanilla git, I found that the problem appeared
 > after the following patch was applied:
 >
 > 
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=566f74f6b2f8b85d5b8d6caaf97e5672cecd3e3e
 >
 > After reverting the patch, Linus vanilla git kernel again boots ok on
 > the board. Please, take a look.

Could one of the Cavium guys explain why the new code for V2 cores does
"ebase += ..."  and not "ebase = "?

          Kevin K.
