Received:  by oss.sgi.com id <S42436AbQFEOvb>;
	Mon, 5 Jun 2000 07:51:31 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:54123 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42334AbQFENp1>;
	Mon, 5 Jun 2000 06:45:27 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id HAA05485; Mon, 5 Jun 2000 07:40:33 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA83933
	for linux-list;
	Mon, 5 Jun 2000 07:33:22 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA97694
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 5 Jun 2000 07:33:11 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA03427
	for <linux@cthulhu.engr.sgi.com>; Mon, 5 Jun 2000 07:32:54 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 701CA808; Mon,  5 Jun 2000 16:32:45 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 03E768FA7; Mon,  5 Jun 2000 16:29:33 +0200 (CEST)
Date:   Mon, 5 Jun 2000 16:29:33 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Chris Ruvolo <csr6702@grace.rit.edu>, fisher@sgi.com,
        linux@cthulhu.engr.sgi.com
Subject: Re: Problems booting Indigo...
Message-ID: <20000605162933.C3774@paradigm.rfc822.org>
References: <200005310410.VAA00290@hollywood.engr.sgi.com> <Pine.LNX.4.21.0005310417570.274-100000@hork> <20000531122527.A26328@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20000531122527.A26328@lug-owl.de>; from jbglaw@lug-owl.de on Wed, May 31, 2000 at 12:25:27PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, May 31, 2000 at 12:25:27PM +0200, Jan-Benedict Glaw wrote:
> I hacked the BSD tftpd last night (-> standalone and send from #69) but
> you're right. It makes no difference at all. This morning, I played with
> the transceiver again -- 2 switches, 4 possibilities. Tested all, but
> no success. Some two month ago I booted that Indigo over net (okay, it
> crashed immediately;) but the only difference is that we used a switched
> port there... It's brain-dead, but I'll fetch a switch from my old school
> and test it...

It cant be the tftp server etc - Use your brain - We have booted
your machine here - Its an ARP problem i guess. 

And BTW - Use a hub - i had loads of problems booting the
decstation and the indigo2 via a switch - Hangs in the middle
were completely normal.

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-waiting-4-telekom
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
