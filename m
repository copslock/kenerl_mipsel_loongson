Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jul 2005 04:21:23 +0100 (BST)
Received: from zproxy.gmail.com ([IPv6:::ffff:64.233.162.196]:3212 "EHLO
	zproxy.gmail.com") by linux-mips.org with ESMTP id <S8225558AbVGZDVD> convert rfc822-to-8bit;
	Tue, 26 Jul 2005 04:21:03 +0100
Received: by zproxy.gmail.com with SMTP id 14so610618nzn
        for <linux-mips@linux-mips.org>; Mon, 25 Jul 2005 20:23:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FkomF0Dh1eDUdfuhoUUDUPWUyiG4wVydhg4v/I7uUmC95zVKjFQeQtGacnCPaQ+KFrTr8r65uf2LCWq2OpXzQjJVi82DCXP5ijf0TqZKvnLnzIoy84/NNkDHG+q5W+N67gvdH/0O4BJ2u6RqN9dPO1Uj+FWUBPf3GZEJKlxX9ao=
Received: by 10.36.100.17 with SMTP id x17mr2394515nzb;
        Mon, 25 Jul 2005 20:23:23 -0700 (PDT)
Received: by 10.36.160.10 with HTTP; Mon, 25 Jul 2005 20:23:23 -0700 (PDT)
Message-ID: <6097c49050725202347a40e87@mail.gmail.com>
Date:	Tue, 26 Jul 2005 03:23:23 +0000
From:	Maxim Osipov <maxim.osipov@gmail.com>
Reply-To: maxim@mox.ru
To:	Bryan Althouse <bryan.althouse@3phoenix.com>
Subject: Re: Fwd: mips64 gdb problem
Cc:	linux-mips@linux-mips.org
In-Reply-To: <42e57109.14b0f52a.28ce.3671SMTPIN_ADDED@mx.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <42e57109.14b0f52a.28ce.3671SMTPIN_ADDED@mx.gmail.com>
Return-Path: <maxim.osipov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8637
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maxim.osipov@gmail.com
Precedence: bulk
X-list: linux-mips

Nope.
BR,
Maxim

On 7/25/05, Bryan Althouse <bryan.althouse@3phoenix.com> wrote:
> I'm butting heads with this problem also.  I get the error below when
> running mips64-unknown-linux-gdb on a 64 bit mips binary.  Has anyone come
> up with a work around?
> 
> Thanks,
> Bryan
> 
> >Hello,
> >I wonder, is there some way to get debuger working on N64 target?
> >Thanks,
> >Maxim
> 
> >>On Fri, Jun 24, 2005 at 05:42:25PM +0400, Maxim Osipov wrote:
> >> Hello,
> >>
> >> I have a problem trying to debug 64-bit mips binary with gdb-6.3. It
> >> fails with the following message:
> >>
> >> /home # gdb 64test
> >> GNU gdb 6.3
> >> Copyright 2004 Free Software Foundation, Inc.
> >> GDB is free software, covered by the GNU General Public License, and you
> are
> >> welcome to change it and/or distribute copies of it under certain
> conditions.
> >> Type "show copying" to see the conditions.
> >> There is absolutely no warranty for GDB.  Type "show warranty" for
> details.
> >> This GDB was configured as "mips64-linux-gnu"...
> >> ../../gdb-6.3/gdb/dwarf2-frame.c:1411: internal-error:
> >> decode_frame_entry_1: Assertion `fde->cie != NULL' failed.
> 
>
