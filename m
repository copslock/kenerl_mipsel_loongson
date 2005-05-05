Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 May 2005 17:43:00 +0100 (BST)
Received: from smtp007.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.170.10]:17335
	"HELO smtp007.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8225005AbVEEQmp>; Thu, 5 May 2005 17:42:45 +0100
Received: from unknown (HELO ?192.168.1.101?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp007.bizmail.sc5.yahoo.com with SMTP; 5 May 2005 16:42:42 -0000
Subject: Re: USB hangs on AU1100
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Rodolfo Giometti <giometti@linux.it>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <20050505155435.GA28227@enneenne.com>
References: <20050505155435.GA28227@enneenne.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Thu, 05 May 2005 09:42:41 -0700
Message-Id: <1115311361.1614.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Thu, 2005-05-05 at 17:54 +0200, Rodolfo Giometti wrote:
> Hello,
> 
> I'm just using USB host support on a AU1100 developing board (DB1100
> configuration) and i notice that CPU locks in function
> au1xxx_start_hc():
> 
>         /* wait for reset complete (read register twice; see au1500 errata) */
>         while (au_readl(USB_HOST_CONFIG),
>                 !(au_readl(USB_HOST_CONFIG) & USBH_ENABLE_RD))
>                 udelay(1000);
> 
> while waiting for USB controller to reset. I checked it out and I
> discovered that register USB_HOST_CONFIG is fixed at value 0xe! So the
> controller never reset...
> 
> Linux is 2.6.12-rc3 from CVS.
> 
> Someone knows whats wrong?

It sounds like this is a custom Au1100 based board? What boot code are
you running?  I'm guessing the SOC isn't setup correctly or you have a
HW problem.

Pete
