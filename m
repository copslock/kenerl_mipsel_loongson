Received:  by oss.sgi.com id <S554041AbRAYWXK>;
	Thu, 25 Jan 2001 14:23:10 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:1358 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S554038AbRAYWWw>;
	Thu, 25 Jan 2001 14:22:52 -0800
Received: from dhcp-163-154-5-240.engr.sgi.com ([163.154.5.240]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA06031
	for <linux-mips@oss.sgi.com>; Thu, 25 Jan 2001 14:22:51 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870759AbRAYWTw>; Thu, 25 Jan 2001 14:19:52 -0800
Date: 	Thu, 25 Jan 2001 14:19:52 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Joe deBlaquiere <jadb@redhat.com>
Cc:     Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: [FIX] sysmips(MIPS_ATMIC_SET, ...) ret_from_sys_call vs. o32_ret_from_sys_call
Message-ID: <20010125141952.C2311@bacchus.dhis.org>
References: <20010124163048.B15348@paradigm.rfc822.org> <20010124165919.C15348@paradigm.rfc822.org> <20010125165530.B12576@paradigm.rfc822.org> <3A70705C.5020600@redhat.com> <3A707FFB.60802@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A707FFB.60802@redhat.com>; from jadb@redhat.com on Thu, Jan 25, 2001 at 01:35:23PM -0600
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Jan 25, 2001 at 01:35:23PM -0600, Joe deBlaquiere wrote:

> sysmips(MIPS_ATOMIC_SET,ptr,val)
> {
> 	 *ptr = val ;
> 	val 0 ;
> }
> 
> but it is an atomic operation
> 
> if this correct in a pseudo-code sense?

It's more:

sysmips(MIPS_ATOMIC_SET, ptr, val)
{
	result = *ptr;
	*ptr = val;

	return result;
}

   Ralf
