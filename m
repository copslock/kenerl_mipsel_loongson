Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 21:32:43 +0000 (GMT)
Received: from 154-84-51-66.reonbroadband.com ([IPv6:::ffff:66.51.84.154]:59008
	"EHLO tibook.netx4.com") by linux-mips.org with ESMTP
	id <S8225198AbTBTVcm>; Thu, 20 Feb 2003 21:32:42 +0000
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.netx4.com (8.11.1/8.11.1) with ESMTP id h1KLRoP01265;
	Thu, 20 Feb 2003 16:27:50 -0500
Message-ID: <3E554856.4010306@embeddededge.com>
Date: Thu, 20 Feb 2003 16:27:50 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Guido Guenther <agx@sigxcpu.org>
CC: linux-mips@linux-mips.org
Subject: Re: Ramdisk image on flash.
References: <200302201135.09154.krishnakumar@naturesoft.net> <1045765647.30379.262.camel@zeus.mvista.com> <20030220205911.GB27240@bogon.ms20.nix>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips

Guido Guenther wrote:

> We're using a patch for the debian kernels that allows to pass the
> initrd's loadaddress and size on the kernel's command line. If this is of
> some use I can send a patch.

Thanks.  I think that patch has been posted in the past because I am
using it in what I am doing.  I would actually like to pass this as
enviornment variables, since the command lines are getting quite long
in some cases and IMHO should really reflect general driver/kernel
options.


	-- Dan
