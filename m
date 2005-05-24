Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2005 07:35:59 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:49600 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8224970AbVEXGfo>;
	Tue, 24 May 2005 07:35:44 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j4O6ZdSO018138;
	Tue, 24 May 2005 02:35:39 -0400
Received: from firetop.home (vpn50-30.rdu.redhat.com [172.16.50.30])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j4O6ZcO01197;
	Tue, 24 May 2005 02:35:38 -0400
Received: from rsandifo by firetop.home with local (Exim 4.50)
	id 1DaT0m-00012p-C4; Tue, 24 May 2005 07:35:32 +0100
From:	Richard Sandiford <rsandifo@redhat.com>
To:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc:	linux-mips@linux-mips.org
Subject: Re: Unmatched R_MIPS_HI16/R_MIPS_LO16 on gcc 3.5
References: <8764x926wq.fsf@firetop.home>
	<Pine.GSO.4.10.10505231928030.8910-100000@helios.et.put.poznan.pl>
Date:	Tue, 24 May 2005 07:35:32 +0100
In-Reply-To: <Pine.GSO.4.10.10505231928030.8910-100000@helios.et.put.poznan.pl>
	(Stanislaw Skowronek's message of "Mon, 23 May 2005 19:32:00 +0200
	(MET DST)")
Message-ID: <87ekbx872j.fsf@firetop.home>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL> writes:
>> What do you mean?  I'm talking about reordering the relocations in
>> the .rel.foo section, not reordering the code.  I.e. if you have:
>> 
>>     .text
>>     ...
>>     addiu $4,$4,%lo(foo)
>>     ...
>>     lui $4,%hi(foo)
>> 
>> the assembler is expected to output the R_MIPS_HI16 .rel.text entry
>> for the lui before the R_MIPS_LO16 entry for the addiu.
>
> If you have something like that:
>
> 	.text
> 	...
> loop_label:
> 	lui $4, %hi(foo)
> 	addiu $4, $4, %lo(foo)
> 	...
> 	jmp loop_label
> 	...
>
> the compiler might be smart and change it into:
>
> 	.text
> 	...
> 	lui $4, %hi(foo)
> loop_label:
> 	addiu $4, $4, %lo(foo)
> 	...
> 	lui $4, %hi(foo)
> 	jmp loop_label
> 	...
>
> for instance, to put the lui into branch delay slot (quite a smart
> decision, this one). However now %hi and %lo are unpaired. What should the
> tool do?

It should generate:

    R_MIPS_HI16
    R_MIPS_HI16
    R_MIPS_LO16

And yes, the idea that several HI16s can be associated with the same
LO16 is also a GNU extension. ;)

(FWIW: as before, this extension, and indeed the whole idea of "out of
order" or "unpaired" %hi()s, isn't new.  It's been around for 10 years.)

Richard
