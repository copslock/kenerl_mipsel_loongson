Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jul 2006 07:03:42 +0100 (BST)
Received: from smtp106.biz.mail.mud.yahoo.com ([68.142.200.254]:61788 "HELO
	smtp106.biz.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133497AbWGNGDb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Jul 2006 07:03:31 +0100
Received: (qmail 28648 invoked from network); 14 Jul 2006 06:03:25 -0000
Received: from unknown (HELO ?192.168.15.100?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp106.biz.mail.mud.yahoo.com with SMTP; 14 Jul 2006 06:03:24 -0000
Subject: Re: BSP: for an AU1500 board.
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	ashlesha@kenati.com
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1152831547.7681.14.camel@sandbar.kenati.com>
References: <1152831547.7681.14.camel@sandbar.kenati.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Thu, 13 Jul 2006 23:03:16 -0700
Message-Id: <1152856996.18840.106.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Thu, 2006-07-13 at 15:59 -0700, Ashlesha Shintre wrote:
> Hi,
> 
> I m working with an AU-1500 MIPS processor on the EncoreM3 board and my
> task is to write board support packages for the same.  I am very much a
> newbie to linux and embedded systems.
> 
> I m not entirely sure of the sequence in which i should start doing
> things, but here is a rough roadmap: 
> 
> 1) To create a config file appropriate to the board using menuconfig
> 2) Map the VIA southbridge
> 3) Adding IRQ Mappings
> 4) Integration and Debugging
> 
> First I decided to 'do' the configuration file, but I still havent got a
> birdseye picture of how I should proceed.  Any pointers?

You said newbie to Linux _and_ embedded systems. I'm not sure a new BSP
is the place to start. If you have access to a well supported embedded
board, start with that by rebuilding the kernel, booting it, and getting
familiar with making kernel changes.

Pete

> Also, when does the config file come into play during the bootup
> process, and where will I find the addresses of different devices say on
> the PCI bus (memory adds) that will need to be mapped at boottime?
> 
> Thanks,
> Ashlesha.
> 
> 
> 
