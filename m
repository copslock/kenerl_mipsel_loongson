Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2007 20:54:53 +0100 (BST)
Received: from ag-out-0708.google.com ([72.14.246.243]:42559 "EHLO
	ag-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20023166AbXIKTyp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Sep 2007 20:54:45 +0100
Received: by ag-out-0708.google.com with SMTP id 33so890211agc
        for <linux-mips@linux-mips.org>; Tue, 11 Sep 2007 12:54:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=PHtTfykPntURUL8l2FzGIs3j/AVzL3Fk++26IvkF+zI=;
        b=akCmvrmZqPBQOWPo+11j6DwVYWO7IzcqdL3lAy8JDpFCRKNDAuIarPQlDnz/XsLjIrSLVGeAL/dW1PzZsvdwc9w9D6aU35TDzGC4SiOntONERk7YFZNpNih96uz7sGcJeC1CSOKZtvmd2ys1/3Y6zlURFEwSp/EXV1YuB4ZNZDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=M4C1n6x8GkAAUackLsAdp8EA/G48pUaeq0PgRbK/utn4UsopSG0gvtJ0y+fGxDpbrdLst2BL03o/rG/QL3fp/zlp0NmGaYoXy5BY40K0Ww5hiw+Ks50zkycvuuT9ybAUNuUDW/HBy0j8dkFC/ALLuDOLTjWLrt1WkgAtqK6udEM=
Received: by 10.100.127.1 with SMTP id z1mr7098683anc.1189540466427;
        Tue, 11 Sep 2007 12:54:26 -0700 (PDT)
Received: from raver.cocorico ( [79.18.35.53])
        by mx.google.com with ESMTPS id h18sm11062200wxd.2007.09.11.12.54.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Sep 2007 12:54:25 -0700 (PDT)
From:	Matteo Croce <technoboy85@gmail.com>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH][MIPS][5/7] AR7: watchdog timer
Date:	Tue, 11 Sep 2007 21:54:24 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070831.706792)
Cc:	Florian Fainelli <florian.fainelli@telecomint.eu>,
	Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
	Nicolas Thill <nico@openwrt.org>,
	Enrik Berkhan <Enrik.Berkhan@akk.org>,
	Christer Weinigel <wingel@nano-system.com>
References: <200708201704.11529.technoboy85@gmail.com> <20070910080634.GA5857@alpha.franken.de> <20070910090022.GA6085@alpha.franken.de>
In-Reply-To: <20070910090022.GA6085@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200709112154.25234.technoboy85@gmail.com>
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Il Monday 10 September 2007 11:00:23 Thomas Bogendoerfer ha scritto:
> On Mon, Sep 10, 2007 at 10:06:34AM +0200, Thomas Bogendoerfer wrote:
> > On Sun, Sep 09, 2007 at 08:27:29PM +0200, Florian Fainelli wrote:
> > > The thing is that the different TNETD versions : 7100, 7200 and 7300 should 
> > > not have the same watchdog handling.
> > 
> > you just need to use the right address, 7100/7200 have a different
> > address where the watchdog is (0x18611F00) than the 7300 (0x18610B00).
> > Usage of the watchdog is the same.
> > 
> 
> got the addresses wrong, they are 0x08611f00 and 0x08610b00 (both physical
> addresses).
> 
> Thomas.
> 


If you read the ar7.h include file you will find:

#define AR7_REGS_BASE	0x08610000

#define AR7_REGS_WDT	(AR7_REGS_BASE + 0x1f00)
#define UR8_REGS_WDT	(AR7_REGS_BASE + 0x0b00)

So they are correct
