Received:  by oss.sgi.com id <S305196AbQDDIp7>;
	Tue, 4 Apr 2000 01:45:59 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:20562 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305176AbQDDIpn>; Tue, 4 Apr 2000 01:45:43 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id BAA02938; Tue, 4 Apr 2000 01:49:26 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA87204
	for linux-list;
	Tue, 4 Apr 2000 01:34:22 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA30816
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 4 Apr 2000 01:34:21 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA09516
	for <linux@cthulhu.engr.sgi.com>; Tue, 4 Apr 2000 01:34:19 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id CAE9E7F9; Tue,  4 Apr 2000 10:34:19 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id D3F4F8FC3; Tue,  4 Apr 2000 10:22:52 +0200 (CEST)
Date:   Tue, 4 Apr 2000 10:22:52 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: Re: kernel hang indigo2 current cvs more specific
Message-ID: <20000404102252.B276@paradigm.rfc822.org>
References: <20000404015430.E275@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20000404015430.E275@paradigm.rfc822.org>; from Florian Lohoff on Tue, Apr 04, 2000 at 01:54:30AM +0200
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, Apr 04, 2000 at 01:54:30AM +0200, Florian Lohoff wrote:
> Ok,
> i debugged a bit arround and found that the current CVS kernel
> hang at "alloc_page.c" (For SGI_IP22)
> 
>         lmem_map = (struct page *) alloc_bootmem_node(nid, map_size);
> 
> I had a small look into the function alloc_bootmem_node/core but didnt
> understand a word.

Reduced it even more - At the end of alloc_bootmem_core the memset is
the fault - It seems to overwrite something and/or does not return.

My suspicion is that the memory map(s) are not correct and initializing
existing memory causes this fault.

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
