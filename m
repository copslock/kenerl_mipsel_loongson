Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2015 14:48:20 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27008166AbbCENsTLvfGk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Mar 2015 14:48:19 +0100
Date:   Thu, 5 Mar 2015 13:48:19 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     =?ISO-8859-2?Q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>
cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: Looking for an idea/workaround for using MIPS ioremap_nocache
 (__ioremap) in IRQ
In-Reply-To: <CACna6rx+3TbNfLmT1Br-JjhDnTQLrFFtVzfmid=yOdBfcOwHoA@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1503050227140.18344@eddie.linux-mips.org>
References: <CACna6rx+3TbNfLmT1Br-JjhDnTQLrFFtVzfmid=yOdBfcOwHoA@mail.gmail.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Mon, 16 Feb 2015, Rafa³ Mi³ecki wrote:

> As the result forwardtrace looks like this:
> 1) ioremap_nocache
> 2) __ioremap_mode
> 3) __ioremap
> 4) get_vm_area
> 5) __get_vm_area_node
> And then we can hit BUG_ON(in_interrupt());
> 
> Can you see any solution for this? Currently there isn't any mainline
> code triggering this problem, but it would be nice to have everything
> working anyway.

 That looks to me like a case that shouldn't really be handled at the 
hardirq level.  Just use a softirq or a threaded IRQ.  There's prior art 
in phylib I believe, where merely ACKing an IRQ may require pushing data 
through over I2C -- slooow and possibly bit-banged!

 HTH,

  Maciej
