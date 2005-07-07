Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2005 19:42:00 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.193]:62402 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226313AbVGGSlp> convert rfc822-to-8bit;
	Thu, 7 Jul 2005 19:41:45 +0100
Received: by wproxy.gmail.com with SMTP id 70so264767wra
        for <linux-mips@linux-mips.org>; Thu, 07 Jul 2005 11:42:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mQpyRjRoqtaOOiHxDp2ep0/lV0OZohVmhg3BdbMJI+RTnRnzSHo8tkmUCdxsqoV+PirIKkaVWCBxYW7Ae6bLgo/hUyjXnA+OwEXw5yhCZKAr+qfprWcyviMhSepdMnZxWvaxJ8V2ZoPD8JABl7ldD26H8vnciP/Z1tUQJ+sJlJ0=
Received: by 10.54.33.65 with SMTP id g65mr988463wrg;
        Thu, 07 Jul 2005 11:42:14 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Thu, 7 Jul 2005 11:42:14 -0700 (PDT)
Message-ID: <2db32b7205070711424c119780@mail.gmail.com>
Date:	Thu, 7 Jul 2005 11:42:14 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: booting error on db1550 using linux 2.6.12 from linux-mips.org
Cc:	ppopov@embeddedalley.com,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <1120756200.317.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <2db32b7205070114172483d2dd@mail.gmail.com>
	 <1120253048.5987.16.camel@localhost.localdomain>
	 <2db32b72050701153566c83bb6@mail.gmail.com>
	 <1120257851.5987.37.camel@localhost.localdomain>
	 <2db32b7205070508504b675dd6@mail.gmail.com>
	 <1120756200.317.14.camel@localhost.localdomain>
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

Alan,
Tried your patch on db1550 and linux 2.6.12. It still doesn't work. 
During the boot-up, the kernel will hang up right after it prints out:

>>hdg: max request size: 128 KiB


Any suggestion?


On 7/7/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2005-07-05 at 16:50, rolf liu wrote:
> > Pete,
> > I tried to make HPT working on db1550 for linux 2.6.12 cvs head. If I
> > didn't force it to use 372 timing, it just hangs up after it detect
> > the drive. If I used the 372 timing using the 2.4 trick, the kernel
> > just crashed. Any clue?
> 
> Fix has been in the -ac tree for ages. Its finally gotten to Linus for
> 2.6.13 tree so pull it out of there.
> 
> 
>
