Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2005 16:11:12 +0100 (BST)
Received: from smtp102.biz.mail.re2.yahoo.com ([68.142.229.216]:46937 "HELO
	smtp102.biz.mail.re2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133451AbVJUPKw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Oct 2005 16:10:52 +0100
Received: (qmail 58949 invoked from network); 21 Oct 2005 15:10:44 -0000
Received: from unknown (HELO ?10.1.7.13?) (dan@embeddedalley.com@12.6.244.2 with plain)
  by smtp102.biz.mail.re2.yahoo.com with SMTP; 21 Oct 2005 15:10:44 -0000
In-Reply-To: <DAF42D2FFC65A146BAB240719E4AD214C212F3@gbrwgceumf02.eu.xerox.net>
References: <DAF42D2FFC65A146BAB240719E4AD214C212F3@gbrwgceumf02.eu.xerox.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <11386cff191ef9d9414dbde253de402d@embeddedalley.com>
Content-Transfer-Encoding: 7bit
Cc:	'linux-mips@linux-mips.org' MIPS <linux-mips@linux-mips.org>
From:	Dan Malek <dan@embeddedalley.com>
Subject: Re: au1x00 usb device status
Date:	Fri, 21 Oct 2005 11:16:36 -0400
To:	"Hamilton, Ian" <Ian.Hamilton@xerox.com>
X-Mailer: Apple Mail (2.623)
Return-Path: <dan@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddedalley.com
Precedence: bulk
X-list: linux-mips


On Oct 21, 2005, at 10:01 AM, Hamilton, Ian wrote:

> ......  so I guess a tty/raw emulation
> would be appropriate,

That's all that was available in 2.4.  I'd say if you actually
see it working, you are lucky :-)  The only way I have seen
this work successfully in a real product was using a
custom RTLinux driver to service most of the USB hardware,
then feed this upstream to the Linux USB software.

> I was hoping it would be a straight copy from 2.4 to 2.6, but clearly 
> it
> isn't :-(

You will want to use the gadget interface.  I think most of what
we had done in the past has been checked in, but if not I'll
dig it out.  It was never functional to my satisfaction.


Thanks.


	-- Dan
