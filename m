Received:  by oss.sgi.com id <S553796AbRADRpY>;
	Thu, 4 Jan 2001 09:45:24 -0800
Received: from blackdog.wirespeed.com ([208.170.106.25]:41738 "EHLO
        blackdog.wirespeed.com") by oss.sgi.com with ESMTP
	id <S553768AbRADRpE>; Thu, 4 Jan 2001 09:45:04 -0800
Received: from redhat.com (IDENT:joe@dhcp-4.wirespeed.com [172.16.17.4])
	by blackdog.wirespeed.com (8.9.3/8.9.3) with ESMTP id LAA11147;
	Thu, 4 Jan 2001 11:40:52 -0600
Message-ID: <3A54B6F4.7000909@redhat.com>
Date:   Thu, 04 Jan 2001 11:46:28 -0600
From:   Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        John Van Horne <JohnVan.Horne@cosinecom.com>,
        "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>,
        "'wesolows@foobazco.org'" <wesolows@foobazco.org>
Subject: Re: your mail
References: <Pine.GSO.3.96.1010104171213.4624E-100000@delta.ds2.pg.gda.pl> <3A54A789.1070608@redhat.com> <20010104151334.C2525@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:

> On Thu, Jan 04, 2001 at 10:40:41AM -0600, Joe deBlaquiere wrote:
> 
> If you're really only doing 32-bit mips you might consider removing the 
>> 64 bit targets in the config.bfd... I think that will solve the problems.
> 
> 
> Doesn't really solve the problem.  For example on an Origin we have a 32-bit
> userland but 64-bit kernel addresses which confuses ksymops and procps.
> 
>   Ralf


It was meant as a workaround...

Perhaps we could have an option to objcopy that would allow you to copy 
the addresses without sign extension?

Joe
