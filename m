Received:  by oss.sgi.com id <S553750AbRADQtn>;
	Thu, 4 Jan 2001 08:49:43 -0800
Received: from blackdog.wirespeed.com ([208.170.106.25]:1546 "EHLO
        blackdog.wirespeed.com") by oss.sgi.com with ESMTP
	id <S553661AbRADQtV>; Thu, 4 Jan 2001 08:49:21 -0800
Received: from redhat.com (IDENT:joe@dhcp-4.wirespeed.com [172.16.17.4])
	by blackdog.wirespeed.com (8.9.3/8.9.3) with ESMTP id KAA09708;
	Thu, 4 Jan 2001 10:35:04 -0600
Message-ID: <3A54A789.1070608@redhat.com>
Date:   Thu, 04 Jan 2001 10:40:41 -0600
From:   Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC:     Ralf Baechle <ralf@oss.sgi.com>,
        John Van Horne <JohnVan.Horne@cosinecom.com>,
        "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>,
        "'wesolows@foobazco.org'" <wesolows@foobazco.org>
Subject: Re: your mail
References: <Pine.GSO.3.96.1010104171213.4624E-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

If the BFD stuff is built with any support for 64 bit (even as an 
optional target) it will maintain all addresses as 64-bit values, even 
if the file is 32 bit.

There is a bug in that "some" newer versions of objcopy will not allow 
you to translate these sign-extended 32 bit addresses into Intel Hex 
format.

If you're really only doing 32-bit mips you might consider removing the 
64 bit targets in the config.bfd... I think that will solve the problems.

Maciej W. Rozycki wrote:

> On Thu, 4 Jan 2001, Ralf Baechle wrote:
> 
> 
>>> I see that our start address of 0x80102584 has been turned into
>>> 0xffffffff80102584. I'm thinking that
>>> I need to tell ld something to stop it from doing this. Any ideas?
>> 
>> That's be ok.  32-bit MIPS addresses are sign-extended into 64-bit addresses.
>> Older binutils used to zero-extend addresses which was broken.  So what
>> you observe is actually the sympthom of a bug that got fixed.
> 
> 
>  I'm not sure that's the best solution, I'm afraid.  For elf32-mips
> addresses should be 32-bit and not 64-bit.  It would be consistent with
> other 32-bit platforms, it would make interoperability easier (ksymoops
> cannot make use of System.map to grok kernel oopses which provide 32-bit
> addresses) and it would make objdump outputs more readable.
> 
>  Fixing this problem with BFD is on my to do list (but has a low priority
> assigned). 
