Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 May 2006 20:16:09 +0100 (BST)
Received: from smtp103.biz.mail.mud.yahoo.com ([68.142.200.238]:10428 "HELO
	smtp103.biz.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133466AbWEATP7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 May 2006 20:15:59 +0100
Received: (qmail 1851 invoked from network); 1 May 2006 19:15:52 -0000
Received: from unknown (HELO ?192.168.1.103?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp103.biz.mail.mud.yahoo.com with SMTP; 1 May 2006 19:15:51 -0000
Subject: Re: RFC: au1000_etc.c phylib rewrite
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Herbert Valerio Riedel <hvr@gnu.org>
Cc:	sshtylyov@ru.mvista.com, linux-mips@linux-mips.org,
	jgarzik@pobox.com
In-Reply-To: <1146510542.16643.10.camel@localhost.localdomain>
References: <1146510542.16643.10.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Mon, 01 May 2006 12:15:45 -0700
Message-Id: <1146510945.21947.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Mon, 2006-05-01 at 21:09 +0200, Herbert Valerio Riedel wrote:
> hello *,
> 
> I've started to rewrite the au1000_eth.c driver to make use of the new
> PHY framework in 2.6.x; see the attached patch for the current work in
> progress state;
> 
> I'm a bit unsure what to do about those workarounds/hacks that are in
> the original au1000_eth.c driver (e.g. for the broadcom dual PHY);

Maybe you should dump that bcm dual phy support. I can't remember what
board it was on and whether that board is even supported still. 

> any comments/ideas? shall I continue work on this au1xxx-eth
> phylib-rewrite, or is it of no use?

Seems like a good idea to me. 

Pete
