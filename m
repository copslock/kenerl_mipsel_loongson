Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2005 08:06:05 +0100 (BST)
Received: from smtp007.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.170.10]:18794
	"HELO smtp007.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8226859AbVGSHFp>; Tue, 19 Jul 2005 08:05:45 +0100
Received: (qmail 56861 invoked from network); 19 Jul 2005 07:07:26 -0000
Received: from unknown (HELO ?192.168.1.100?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp007.bizmail.sc5.yahoo.com with SMTP; 19 Jul 2005 07:07:26 -0000
Subject: Re: Power Management for au1100 fixed! :)
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Dan Malek <dan@embeddedalley.com>
Cc:	Rodolfo Giometti <giometti@linux.it>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <1f5157240f623e21b61131958e19042d@embeddedalley.com>
References: <20050712142202.GB9234@gundam.enneenne.com>
	 <20050712181013.GC9234@gundam.enneenne.com>
	 <a2882b70a3d6c0f32728086e0c63764c@embeddededge.com>
	 <20050718173052.GC28995@enneenne.com>
	 <1f5157240f623e21b61131958e19042d@embeddedalley.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Tue, 19 Jul 2005 00:07:24 -0700
Message-Id: <1121756845.7285.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Mon, 2005-07-18 at 21:02 -0400, Dan Malek wrote:
> On Jul 18, 2005, at 1:30 PM, Rodolfo Giometti wrote:
> 
> > Ok, Fixed! :)
> 
> Thanks.
> 
> > Here you can see the patch. Please note that I also fixed some type
> > mismatches and some comments.
> 
> Looks good.  I asked Pete to push it in.

arch/mips/au1000/common/irq.c didn't apply cleanly. I applied it
manually. Rodolfo, do a cvs update and give it a try :)

Pete
