Received:  by oss.sgi.com id <S554104AbRAZUfQ>;
	Fri, 26 Jan 2001 12:35:16 -0800
Received: from blackdog.wirespeed.com ([208.170.106.25]:37902 "EHLO
        blackdog.wirespeed.com") by oss.sgi.com with ESMTP
	id <S554050AbRAZUfD>; Fri, 26 Jan 2001 12:35:03 -0800
Received: from redhat.com (IDENT:joe@dhcp-4.wirespeed.com [172.16.17.4])
	by blackdog.wirespeed.com (8.9.3/8.9.3) with ESMTP id OAA25859;
	Fri, 26 Jan 2001 14:29:57 -0600
Message-ID: <3A71E037.6030300@redhat.com>
Date:   Fri, 26 Jan 2001 14:38:15 -0600
From:   Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To:     Jun Sun <jsun@mvista.com>
CC:     Ralf Baechle <ralf@oss.sgi.com>, Florian Lohoff <flo@rfc822.org>,
        linux-mips@oss.sgi.com
Subject: Re: [FIX] sysmips(MIPS_ATMIC_SET, ...) ret_from_sys_call vs. o32_ret_from_sys_call
References: <20010124163048.B15348@paradigm.rfc822.org> <20010124165919.C15348@paradigm.rfc822.org> <20010125165530.B12576@paradigm.rfc822.org> <3A70705C.5020600@redhat.com> <3A707FFB.60802@redhat.com> <20010125141952.C2311@bacchus.dhis.org> <3A70CA98.102@redhat.com> <20010126120140.E9325@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Jun Sun wrote:

> On Thu, Jan 25, 2001 at 06:53:44PM -0600, Joe deBlaquiere wrote:
> 
>> The end goal of this is to make pthreads work on the Vr4181...it's 
>> certainly an interesting task so far...
>> 
> 
> 
> We have got pthreads working on Vr4181 for a couple of months already.
> What version of kernel are you using?  The toughest problem is not
> MIPS_AUTOMIC_SET.  It is a kernel s0 register corruption bug, which is
> already fixed in the current CVS tree.
> 

which current CVS tree, the linuxvr tree?

what is the s0 register corruption bug?

> Jun


-- 
Joe
