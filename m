Received:  by oss.sgi.com id <S553778AbRCLNnT>;
	Mon, 12 Mar 2001 05:43:19 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:10758 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553774AbRCLNnO>;
	Mon, 12 Mar 2001 05:43:14 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id A65C57FE; Mon, 12 Mar 2001 14:43:02 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 62D17EFD0; Mon, 12 Mar 2001 14:41:31 +0100 (CET)
Date:   Mon, 12 Mar 2001 14:41:31 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Illegal instruction - a workaround or fix ?
Message-ID: <20010312144131.C7715@paradigm.rfc822.org>
References: <20010311191639.A8587@paradigm.rfc822.org> <20010312122134.B1235@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010312122134.B1235@bacchus.dhis.org>; from ralf@oss.sgi.com on Mon, Mar 12, 2001 at 12:21:34PM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Mar 12, 2001 at 12:21:34PM +0100, Ralf Baechle wrote:
> Thanks, that was the hint I needed.  o32_ret_from_sys_call expects the
> content of s-registers to be unchanged from userspace but sys_sysmips
> clobbers them.
> 
> Below a patch from the famous ``Smoke This, It's Good For You (TM)''
> series.  Lemme know if it helps.

As mentioned on IRC - This "Oopses" for me ...

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
