Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2003 15:43:56 +0100 (BST)
Received: from kauket.visi.com ([IPv6:::ffff:209.98.98.22]:20949 "HELO
	mail-out.visi.com") by linux-mips.org with SMTP id <S8225263AbTDDOnf>;
	Fri, 4 Apr 2003 15:43:35 +0100
Received: from mehen.visi.com (mehen.visi.com [209.98.98.97])
	by mail-out.visi.com (Postfix) with ESMTP id 699E736D1
	for <linux-mips@linux-mips.org>; Fri,  4 Apr 2003 08:43:26 -0600 (CST)
Received: from mehen.visi.com (localhost [127.0.0.1])
	by mehen.visi.com (8.12.9/8.12.5) with ESMTP id h34EhQ6D047951
	for <linux-mips@linux-mips.org>; Fri, 4 Apr 2003 08:43:26 -0600 (CST)
	(envelope-from erik@greendragon.org)
Received: (from www@localhost)
	by mehen.visi.com (8.12.9/8.12.5/Submit) id h34EhQeP047950
	for linux-mips@linux-mips.org; Fri, 4 Apr 2003 14:43:26 GMT
X-Authentication-Warning: mehen.visi.com: www set sender to erik@greendragon.org using -f
Received: from stpns.guidant.com (stpns.guidant.com [132.189.76.10]) 
	by my.visi.com (IMP) with HTTP 
	for <longshot@imap.visi.com>; Fri,  4 Apr 2003 14:43:25 +0000
Message-ID: <1049467405.3e8d9a0dea4a5@my.visi.com>
Date: Fri,  4 Apr 2003 14:43:25 +0000
From: "Erik J. Green" <erik@greendragon.org>
To: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Unknown ARCS message/hang
References: <1049427871.3e8cff9f9c50e@my.visi.com> <Pine.GSO.3.96.1030404142811.7307B-100000@delta.ds2.pg.gda.pl> <20030404131935.GF11906@bogon.ms20.nix>
In-Reply-To: <20030404131935.GF11906@bogon.ms20.nix>
MIME-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 132.189.76.10
Return-Path: <erik@greendragon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: erik@greendragon.org
Precedence: bulk
X-list: linux-mips


.. and just to display my complete technical mastery, I failed to echo this
message to the list the first time around =\


Quoting Guido Guenther <agx@sigxcpu.org>:
> >  0x211c4018 is a mapped address, which you can't use that early in a boot.
> Isn't 0xa8000000211c4000 in xkphys and therefore unmapped? The PROM only
> seems to look at the lower 32bits of PC though.
> Puzzled,
>  -- Guido

That's what I thought too.  I did notice that the 64 bit kernel seems to refer
to some 32 bit compatibility address spaces, so I'm probably confused on what
gets used when.

FYI, the load address I'm using (0xa800000020004000) is the one specified in the
irix headers for an IP30 kernel (as I read it anyway) and is very close to the
entry point IRIX uses on the same machine.

Erik




-- 
Erik J. Green
erik@greendragon.org
