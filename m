Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Oct 2004 16:45:07 +0100 (BST)
Received: from [IPv6:::ffff:145.253.187.134] ([IPv6:::ffff:145.253.187.134]:34705
	"EHLO mail01.baslerweb.com") by linux-mips.org with ESMTP
	id <S8224908AbUJSPpB>; Tue, 19 Oct 2004 16:45:01 +0100
Received: from mail01.baslerweb.com (localhost.localdomain [127.0.0.1])
	by localhost.domain.tld (Basler) with ESMTP
	id BAFDE13402A; Tue, 19 Oct 2004 17:44:19 +0200 (CEST)
Received: from comm1.baslerweb.com (unknown [172.16.13.2])
	by mail01.baslerweb.com (Basler) with ESMTP
	id B82DF134028; Tue, 19 Oct 2004 17:44:19 +0200 (CEST)
Received: from vclinux-1.basler.corp (localhost [172.16.13.253]) by comm1.baslerweb.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id 4YRPLYW3; Tue, 19 Oct 2004 17:44:52 +0200
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: linux-mips@linux-mips.org
Subject: Re: jump instruction in delay slot
Date: Tue, 19 Oct 2004 17:48:50 +0200
User-Agent: KMail/1.6.2
Cc: "Kevin D. Kissell" <kevink@mips.com>
References: <200410191605.47543.thomas.koeller@baslerweb.com> <000901c4b5e8$70141160$10eca8c0@grendel>
In-Reply-To: <000901c4b5e8$70141160$10eca8c0@grendel>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410191748.50810.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

On Tuesday 19 October 2004 16:32, Kevin D. Kissell wrote:

> By default, a MIPS assembler will automatically
> fill delay slots and even move instructions around
> to fill them.  This can be inhibited by the
>     set .noreorder
> directive, of which you'll note there is one in the
> top level tital_handle_int routine, but there's a
>     set .reorder
> at the end of that routine, so by the time it gets to
> the code you're interested in, things should be OK.

I see. I really wonder if there is any up-to-date
documentation covering the mips-specific features
of gas. Have been googling for it, no success so
far.

thanks,
Thomas
-- 
--------------------------------------------------

Thomas Koeller, Software Development

Basler Vision Technologies
An der Strusbek 60-62
22926 Ahrensburg
Germany

Tel +49 (4102) 463-390
Fax +49 (4102) 463-46390

mailto:thomas.koeller@baslerweb.com
http://www.baslerweb.com

==============================
