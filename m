Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2005 07:57:06 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:48586 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8224970AbVEXG4v>;
	Tue, 24 May 2005 07:56:51 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j4O6ulVw023580;
	Tue, 24 May 2005 02:56:47 -0400
Received: from firetop.home (vpn50-30.rdu.redhat.com [172.16.50.30])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j4O6ugO04623;
	Tue, 24 May 2005 02:56:42 -0400
Received: from rsandifo by firetop.home with local (Exim 4.50)
	id 1DaTL9-00012s-Uk; Tue, 24 May 2005 07:56:35 +0100
From:	Richard Sandiford <rsandifo@redhat.com>
To:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc:	linux-mips@linux-mips.org
Subject: Re: Unmatched R_MIPS_HI16/R_MIPS_LO16 on gcc 3.5
References: <Pine.GSO.4.10.10505240837530.12717-100000@helios.et.put.poznan.pl>
Date:	Tue, 24 May 2005 07:56:35 +0100
In-Reply-To: <Pine.GSO.4.10.10505240837530.12717-100000@helios.et.put.poznan.pl>
	(Stanislaw Skowronek's message of "Tue, 24 May 2005 08:39:14 +0200
	(MET DST)")
Message-ID: <87acml863g.fsf@firetop.home>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL> writes:

>> It should generate:
>> 
>>     R_MIPS_HI16
>>     R_MIPS_HI16
>>     R_MIPS_LO16
>> 
>> And yes, the idea that several HI16s can be associated with the same
>> LO16 is also a GNU extension. ;)
>
> Good, no problem - thanks for confirming my darkest suspicions. How can I
> detect this? (I've got to emit SGI-compliant ECOFF.) I can emit sham
> relocs into .rel.text that point into specially added synthetic
> instructions.

Sorry if this is a dumb question, but why do you need to generate
_relocatable_ ECOFF?  If you really need to do that, I think you'll
just have to force gcc to use assembler macros, ala:

   gcc -mno-explicit-relocs -mno-split-addresses

Richard
