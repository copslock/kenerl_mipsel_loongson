Received:  by oss.sgi.com id <S553712AbRADThZ>;
	Thu, 4 Jan 2001 11:37:25 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:48626 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553683AbRADThO>;
	Thu, 4 Jan 2001 11:37:14 -0800
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f04JYpC01619;
	Thu, 4 Jan 2001 11:34:51 -0800
Message-ID: <3A54D12C.FB92DC29@mvista.com>
Date:   Thu, 04 Jan 2001 11:38:20 -0800
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: bg, en
MIME-Version: 1.0
To:     Glenn Serre <gaserre@innovisiontv.com>
CC:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Cross-gdb for mipsel on i386?
References: <3A54C8BA.3050300@innovisiontv.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Glenn Serre wrote:
> 
> Good morning,
> 
> Does anyone know where I can get a precompiled cross-gdb for a mipsel
> target hosted on an i386 (Redhat 7.0)?  I didn't see one on the
> oss.sgi.com, but maybe I was just looking in the wrong place.

ftp.mvista.com:/pub/Area51/ddb-5476

The names of the packages will probably change by the time we officially
release this and other mips boards, but that shouldn't matter for you.
Note that Redhat 7.0 is not yet one of our supported hosts,  but it
should work.

Pete
