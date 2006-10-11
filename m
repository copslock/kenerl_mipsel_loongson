Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2006 14:15:41 +0100 (BST)
Received: from smtp105.biz.mail.re2.yahoo.com ([206.190.52.174]:17076 "HELO
	smtp105.biz.mail.re2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20037734AbWJKNPg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Oct 2006 14:15:36 +0100
Received: (qmail 11339 invoked from network); 11 Oct 2006 13:15:26 -0000
Received: from unknown (HELO ?192.168.253.28?) (dan@embeddedalley.com@209.113.146.155 with plain)
  by smtp105.biz.mail.re2.yahoo.com with SMTP; 11 Oct 2006 13:15:25 -0000
In-Reply-To: <452BF775.6090504@ru.mvista.com>
References: <20061010182747.GA14539@enneenne.com> <29381BAC-4A96-4BFE-8E86-836A3564F2F5@embeddedalley.com> <452BF775.6090504@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EF75E0BE-76C7-4C60-9C6E-38A6B609EB73@embeddedalley.com>
Cc:	Rodolfo Giometti <giometti@linux.it>, linux-mips@linux-mips.org
Content-Transfer-Encoding: 7bit
From:	Dan Malek <dan@embeddedalley.com>
Subject: Re: Problem on au1100 USB device support
Date:	Wed, 11 Oct 2006 09:15:27 -0400
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
X-Mailer: Apple Mail (2.752.2)
Return-Path: <dan@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddedalley.com
Precedence: bulk
X-list: linux-mips


On Oct 10, 2006, at 3:41 PM, Sergei Shtylyov wrote:

>    Note that AMD claims that the latency (and other) errata fixed  
> in the late revs of their SOCs.
> For Au1100, BE and BF revs are claimed to be errata-free.

I've been looking for the code I did long ago for
this, but haven't found it yet.  As I recall, the BE and
later version actually fixed some chip bugs, but didn't
solve the design challenges of the CPU responding
in a required time to collect proper status or to
meet the USB timing.

I'll keep looking and do whatever I can to help out.

Thanks.

	-- Dan
