Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jan 2011 12:15:43 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:62639 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490996Ab1AFLPk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Jan 2011 12:15:40 +0100
Received: by wwi17 with SMTP id 17so16334537wwi.24
        for <multiple recipients>; Thu, 06 Jan 2011 03:15:34 -0800 (PST)
Received: by 10.227.129.141 with SMTP id o13mr822852wbs.85.1294312534676;
        Thu, 06 Jan 2011 03:15:34 -0800 (PST)
Received: from localhost (cpc1-chap8-2-0-cust102.aztw.cable.virginmedia.com [94.169.120.103])
        by mx.google.com with ESMTPS id q18sm16702754wbe.17.2011.01.06.03.15.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Jan 2011 03:15:33 -0800 (PST)
Date:   Thu, 6 Jan 2011 11:15:30 +0000
From:   Jamie Iles <jamie@jamieiles.com>
To:     John Crispin <blogic@openwrt.org>
Cc:     Jamie Iles <jamie@jamieiles.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 05/10] MIPS: lantiq: add watchdog support
Message-ID: <20110106111530.GD2946@pulham.picochip.com>
References: <1294257379-417-1-git-send-email-blogic@openwrt.org>
 <1294257379-417-6-git-send-email-blogic@openwrt.org>
 <20110105234910.GD2112@gallagher>
 <4D25908E.9070509@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D25908E.9070509@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jamie@jamieiles.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jamie@jamieiles.com
Precedence: bulk
X-list: linux-mips

On Thu, Jan 06, 2011 at 10:51:10AM +0100, John Crispin wrote:
> On 06/01/11 00:49, Jamie Iles wrote:
> > I think you need a clk_put() here too to balance the clk_get() in the 
> > probe method so you'll need to keep a reference to the clk.
> >
> >   
> 
> Hi Jamie,
> 
> i will fold your suggestions into the series.
> 
> the clk.c/h implementation on the lantiq target is very simple. it only
> allows to read the static rates of the 3 clocks. clk_put is implemented
> as follows
> 
> void
> clk_put(struct clk *clk)
> {
>     /* not used */
> }
> EXPORT_SYMBOL(clk_put);
> 
> so in theory you are right and we should call that function, however as
> it is only a stub and the driver is only used by the lantiq target i
> think it is save to leave out the clk_put(); call. we could however put
> a commet in the code to make this clear (same as with the clk_enable()
> not being needed as the clocks are always running)

Could that ever change for future devices that share the same watchdog 
block?  If so, then adding in that clk_put() and clk_enable() might be 
worth it as it doesn't cost much.

Jamie
